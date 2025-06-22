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
		'totalLaps',
		'previousPosition',
		'lastSteps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Game class >> startWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps [

	self validateMinimumSpaceShips: someShips.
	self validateBoard: aBoard.
	^ self new initializeWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps.
]

{ #category : 'initialize' }
Game class >> validateBoard: aBoard [

    aBoard isValid ifFalse: [ self error: 'Board is invalid' ].
]

{ #category : 'initialize' }
Game class >> validateMinimumSpaceShips: someShips [

	someShips size < 2 ifTrue: [
		self error: 'Need 2 space ships or more to initialize the game' 
	].
]

{ #category : 'process actions' }
Game >> advanceTurn [

	currentTurnIndex := currentTurnIndex + 1.
	currentTurnIndex > spaceShips size ifTrue: [ currentTurnIndex := 1 ].
	turn := turn + 1
]

{ #category : 'process actions' }
Game >> allStatuses [

	^ self spaceShips collect: [ :ship | self statusFor: ship ]
]

{ #category : 'as yet unclassified' }
Game >> checkWinCondition [

	| ship |
	ship := self currentShip.
	(ship hasReachedGoalOn: board) ifTrue: [
		(self hasWonByLaps: ship) ifTrue: [ winner := ship ] ]
]

{ #category : 'accessing' }
Game >> currentShip [

	^ spaceShips at: currentTurnIndex
]

{ #category : 'accessing' }
Game >> currentTurnIndex [

	^ currentTurnIndex
]

{ #category : 'as yet unclassified' }
Game >> ensureGameIsNotOver [

	self isGameOver ifTrue: [ self error: 'Game is already over' ]
]

{ #category : 'testing' }
Game >> findPenaltyFor: aShip [

	^ penalizedShips
		  detect: [ :penalty | penalty isFor: aShip ]
		  ifNone: [ PenalizedShip noPenaltyFor: aShip ]
]

{ #category : 'as yet unclassified' }
Game >> handlePenaltyOrPassIfNeeded [

	| ship |
	ship := self currentShip.

	(self isPenalized: ship) ifTrue: [
		self reducePenaltyFor: ship.
		self advanceTurn.
		^ true ].

	(self wantsToPassTurn: ship) ifTrue: [
		self markShipAsWantingToPassTurn: ship to: false.
		ship restoreFuel.
		self advanceTurn.
		^ true ].

	^ false
]

{ #category : 'testing' }
Game >> hasWonByLaps: aShip [

	^ (self lapTrackerFor: aShip) hasWonWithTotalLaps: totalLaps
]

{ #category : 'initialization' }
Game >> initializeWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps [

	spaceShips := someShips.
	board := aBoard.
	dice := someDices.
	totalLaps := aNumberLaps.
	turn := 1. "Amounts of turns played"
	currentTurnIndex := 1. "Es el indice del jugador que debe jugar" "Seria el indice de la ordered collection para saber de que nave es el turno. EJ: si currentTurnIndex es 1 entonces es el turno de la primer nave que esta en el orderedCollection"
	penalizedShips := OrderedCollection new.
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

{ #category : 'testing' }
Game >> lapTrackerFor: aShip [

	^ lappedShips detect: [ :lap | lap ship = aShip ]
]

{ #category : 'testing' }
Game >> markShipAsWantingToPassTurn: aShip to: aBoolean [

	wantsToPassTurn at: aShip put: aBoolean.
]

{ #category : 'process actions' }
Game >> passTurn [

	self currentShip restoreFuel.
	self advanceTurn
]

{ #category : 'process actions' }
Game >> penalize: aShip forTurns: turns [

	penalizedShips add: (PenalizedShip for: aShip withTurns: turns)
]

{ #category : 'process actions' }
Game >> playTurn [

	self ensureGameIsNotOver.
	self handlePenaltyOrPassIfNeeded ifTrue: [ ^ self ].
	self rollAndMoveCurrentShip.
	self
		registerLapFor: self currentShip
		from: previousPosition
		after: lastSteps.
	self checkWinCondition.
	self advanceTurn
]

{ #category : 'process actions' }
Game >> playUntilFinish [

	[ self isGameOver ] whileFalse: [ self playTurn ]
]

{ #category : 'process actions' }
Game >> ranking [

	^ self allStatuses sort: [ :a :b |
		  | sameLaps samePosition aIndex bIndex |
		  sameLaps := a lapCount = b lapCount.
		  samePosition := a position = b position.

		  sameLaps
			  ifTrue: [
				  samePosition
					  ifTrue: [
						  aIndex := self spaceShips indexOf: a ship.
						  bIndex := self spaceShips indexOf: b ship.
						  aIndex < bIndex ]
					  ifFalse: [ a position > b position ] ]
			  ifFalse: [ a lapCount > b lapCount ] ]
]

{ #category : 'testing' }
Game >> reducePenaltyFor: aShip [

	| penalty |
	penalty := self findPenaltyFor: aShip.
	penalty decreaseTurns.
	penalty hasPenalty ifFalse: [ penalizedShips remove: penalty ].

	aShip restoreFuel
]

{ #category : 'testing' }
Game >> registerLapFor: aShip from: oldPosition after: someSteps [

	| cellCount lap |
	
	cellCount := board cellCount.

	(oldPosition + someSteps) < cellCount ifTrue: [ ^ self ].
	
	lap := self lapTrackerFor: aShip.
	lap addLap.
]

{ #category : 'as yet unclassified' }
Game >> rollAndMoveCurrentShip [

	| ship steps newPosition |
	ship := self currentShip.
	steps := dice roll.
	previousPosition := ship position.
	newPosition := board
		               determineNewPositionFrom: previousPosition
		               after: steps.
	ship moveTo: newPosition.
	lastSteps := steps
]

{ #category : 'accessing' }
Game >> spaceShips [

    ^ spaceShips.

]

{ #category : 'process actions' }
Game >> spaceshipPositions [

	^ spaceShips
		  collect: [ :ship | ship -> ship position ]
		  as: Dictionary
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
Game >> validateIsCurrentPlayer: aSpaceship [

	self currentShip = aSpaceship ifFalse: [
		self error: 'It is not the turn of this spaceship' ]
]

{ #category : 'process actions' }
Game >> wantsToPassTurn: aShip [

	^ wantsToPassTurn at: aShip ifAbsent: [ false ]
]

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
