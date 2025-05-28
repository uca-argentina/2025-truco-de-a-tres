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
		'penaltyTurns',
		'wantsToPassTurn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Game class >> new [
    self error: 'Use Game startWithShips:board:dice: instead.'
]

{ #category : 'initialize' }
Game class >> startWithShips: someShips board: aBoard dice: someDices [

	^ super new initializeWithShips: someShips board: aBoard dice: someDices
]

{ #category : 'process actions' }
Game >> advanceTurn [

	currentTurnIndex := currentTurnIndex + 1.
	currentTurnIndex > spaceShips size ifTrue: [ currentTurnIndex := 1 ].
	turn := turn + 1
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

{ #category : 'accessing' }
Game >> dice [
    ^ dice

]

{ #category : 'initialization' }
Game >> initializeWithShips: someShips board: aBoard dice: someDices [

	self validateMinimumSpaceShips: someShips.
	"self validateMinimumDice: someDices."
	self validateBoard: aBoard.

	spaceShips := someShips.
	board := aBoard.
	dice := someDices.
	turn := 1. "Amounts of turns played"
	currentTurnIndex := 1. "Es el indice del jugador que debe jugar" "Seria el indice de la ordered collection para saber de que nave es el turno. EJ: si currentTurnIndex es 1 entonces es el turno de la primer nave que esta en el orderedCollection"
	penaltyTurns := Dictionary new.
	spaceShips do: [ :ship | penaltyTurns at: ship put: 0 ]. "Basicamente me aseguro que todos arranquen sin penalizacion (hice un diccionario que la key sea la ship y el valor la cantidad de turnos penalizados que tiene"
	wantsToPassTurn := Dictionary new.
	winner := nil
]

{ #category : 'testing' }
Game >> isGameOver [

	^ winner notNil
]

{ #category : 'testing' }
Game >> isPenalized: aShip [
    ^ (penaltyTurns at: aShip) > 0

]

{ #category : 'process actions' }
Game >> passTurn [
	self currentShip restoreFuel.
	self advanceTurn.
]

{ #category : 'process actions' }
Game >> penalize: aShip forTurns: turns [
    penaltyTurns at: aShip put: turns.

]

{ #category : 'process actions' }
Game >> playTurn [

	| ship steps newPosition |
	self isGameOver ifTrue: [ self error: 'Game is already over' ].

	ship := self currentShip.

	(self isPenalized: ship) ifTrue: [
		self reducePenaltyFor: ship.
		^ self advanceTurn ].

	(self wantsToPassTurn: ship) ifTrue: [
		self setWantsToPassTurnFor: ship to: false.
		ship restoreFuel.
		^ self advanceTurn ].
	
	steps := dice normalRoll.
	
	(ship hasFuelFor: steps) ifFalse: [
		ship resetPosition.
		self penalize: ship forTurns: 2.
		ship restoreFuel.
		^ self advanceTurn ]. "Validacion suficiente combustible"
	
	newPosition := board newPositionFrom: ship position steps: steps.
	ship moveTo: newPosition.

	(ship hasReachedGoalOn: board) ifTrue: [ winner := ship ].

	self advanceTurn
]

{ #category : 'process actions' }
Game >> playUntilFinish [

	[ self isGameOver] whileFalse: [ self playTurn ]
]

{ #category : 'testing' }
Game >> reducePenaltyFor: aShip [
    | remainingTurns |
    remainingTurns := (penaltyTurns at: aShip) - 1.
    penaltyTurns at: aShip put: remainingTurns.
    aShip restoreFuel. "A implementar Tomi"


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
