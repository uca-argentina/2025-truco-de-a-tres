Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'board',
		'dice',
		'turn',
		'winner',
		'currentTurnIndex',
		'spaceships',
		'currentPlayerIndex',
		'die',
		'wantsToPassTurn',
		'penaltyShips',
		'penalizedShips',
		'lappedShips',
		'totalLaps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Game class >> new [
    self error: 'Use Game startWithShips:board:dice: instead.'
]

{ #category : 'initialize' }
Game class >> startWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps [

	^ super new initializeWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps
]

{ #category : 'as yet unclassified' }
Game >> addLapTo: aShip [

	(self lapTrackerFor: aShip) addLap
]

{ #category : 'process actions' }
Game >> advanceTurn [

	currentTurnIndex := currentTurnIndex + 1.
	currentTurnIndex > spaceShips size ifTrue: [ currentTurnIndex := 1 ].
	turn := turn + 1
]

{ #category : 'as yet unclassified' }
Game >> allStatuses [
	^ self spaceShips collect: [ :ship | self statusFor: ship ]
]

{ #category : 'accessing' }
Game >> currentShip [
    ^ spaceShips at: currentTurnIndex
]

{ #category : 'accessing' }
Game >> currentTurn [

	^ turn
]

{ #category : 'accessing' }
Game >> currentTurnIndex [

	^ currentTurnIndex 
]

{ #category : 'testing' }
Game >> findPenaltyFor: aShip [
    ^ penalizedShips detect: [ :penalty | penalty isFor: aShip ] ifNone: [ PenalizedShip noPenaltyFor: aShip ]



]

{ #category : 'as yet unclassified' }
Game >> hasWonByLaps: aShip [
	^ (self lapTrackerFor: aShip) hasWonWithTotalLaps: totalLaps
]

{ #category : 'initialization' }
Game >> initializeWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps [

	self validateMinimumSpaceShips: someShips.
	self validateMinimumDice: someDices.
	self validateBoard: aBoard.

	spaceShips := someShips.
	board := aBoard.
	dice := someDices.
	totalLaps := aNumberLaps.
	turn := 1. "Amounts of turns played"
	currentTurnIndex := 1. "Es el indice del jugador que debe jugar" "Seria el indice de la ordered collection para saber de que nave es el turno. EJ: si currentTurnIndex es 1 entonces es el turno de la primer nave que esta en el orderedCollection"
	penalizedShips  := OrderedCollection new.
	wantsToPassTurn := Dictionary new.
	lappedShips := spaceShips collect: [ :ship | LappedShip for: ship ].
	winner := nil
]

{ #category : 'testing' }
Game >> isGameOver [

	^ winner notNil
]

{ #category : 'testing' }
Game >> isPenalized: aShip [
    ^ (self findPenaltyFor: aShip) hasPenalty



]

{ #category : 'as yet unclassified' }
Game >> lapTrackerFor: aShip [

	^ lappedShips detect: [ :lap | lap ship = aShip ]
]

{ #category : 'process actions' }
Game >> passTurn [
	self currentShip restoreFuel.
	self advanceTurn.
]

{ #category : 'process actions' }
Game >> penalize: aShip forTurns: turns [
    penalizedShips add: (PenalizedShip for: aShip withTurns: turns).


]

{ #category : 'process actions' }
Game >> playTurn [

	| ship steps newPosition previousPosition |
	self isGameOver ifTrue: [ self error: 'Game is already over' ].

	ship := self currentShip.

	(self isPenalized: ship) ifTrue: [
		self reducePenaltyFor: ship.
		^ self advanceTurn ].

	(self wantsToPassTurn: ship) ifTrue: [
		self setWantsToPassTurnFor: ship to: false.
		ship restoreFuel.
		^ self advanceTurn ].
	steps := dice sum: [ :eachDie | eachDie roll ].

	previousPosition := ship position.
	newPosition := board newPositionFrom: ship position steps: steps.
	ship moveTo: newPosition.

	self
		registerLapIfNeededFor: ship
		from: previousPosition
		withSteps: steps.

(ship hasReachedGoalOn: board) ifTrue: [
	(self hasWonByLaps: ship) ifTrue: [
		winner := ship
	]
].

	self advanceTurn
]

{ #category : 'process actions' }
Game >> playUntilFinish [

	[ self isGameOver] whileFalse: [ self playTurn ]
]

{ #category : 'as yet unclassified' }
Game >> ranking [

	^ self allStatuses sort: [ :a :b |
		  a lapCount = b lapCount
			  ifTrue: [
				  a position = b position
					  ifTrue: [
						  (self spaceShips indexOf: a ship)
						  < (self spaceShips indexOf: b ship) ]
					  ifFalse: [ a position > b position ] ]
			  ifFalse: [ a lapCount > b lapCount ] ]
]

{ #category : 'testing' }
Game >> reducePenaltyFor: aShip [

	| penalty |
	penalty := self findPenaltyFor: aShip.
	penalty reduceTurn.
	penalty hasPenalty ifFalse: [ penalizedShips remove: penalty ].
	aShip restoreFuel "A implementar Tomi"
]

{ #category : 'as yet unclassified' }
Game >> registerLapIfNeededFor: aShip from: oldPosition to: newPosition [

	| cellCount lap |
	cellCount := board cellCount.

	oldPosition > newPosition ifTrue: [ ^ self ].
	lap := self lapTrackerFor: aShip.
	lap addLap
]

{ #category : 'as yet unclassified' }
Game >> registerLapIfNeededFor: aShip from: oldPosition withSteps: someSteps [

	| cellCount lap |
	cellCount := board cellCount.

	(oldPosition + someSteps) < cellCount ifTrue: [ ^ self ].
	lap := self lapTrackerFor: aShip.
	lap addLap
]

{ #category : 'as yet unclassified' }
Game >> setWantsToPassTurnFor: aShip to: aBoolean [

	wantsToPassTurn at: aShip put: aBoolean
]

{ #category : 'accessing' }
Game >> spaceShips [
    ^ spaceShips

]

{ #category : 'process actions' }
Game >> spaceshipPositions [
	^ spaceShips collect: [ :ship | ship -> ship position ] as: Dictionary
]

{ #category : 'process actions' }
Game >> statusFor: aShip [
	^ ShipStatus
		for: aShip
		position: aShip position
		laps: (self lapTrackerFor: aShip) lapCount
		penalized: (self isPenalized: aShip)
]

{ #category : 'validation' }
Game >> validateBoard: aBoard [
    aBoard isValid ifFalse: [ self error: 'Board is invalid' ].

]

{ #category : 'validation' }
Game >> validateIsCurrentPlayer: aSpaceship [
	self currentShip = aSpaceship ifFalse: [
		self error: 'It is not the turn of this spaceship'
	].
]

{ #category : 'validation' }
Game >> validateMinimumDice: arg1 [

	arg1 ifEmpty: [
		self error: 'At least one die is required to initialize the game' ]
]

{ #category : 'validation' }
Game >> validateMinimumSpaceShips: someShips [

	someShips size < 2 ifTrue: [
		self error: 'Need 2 space ships or more to initialize the game' ]
]

{ #category : 'as yet unclassified' }
Game >> wantsToPassTurn: aShip [
	^ (wantsToPassTurn at: aShip ifAbsent: [ false ]).
]

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
