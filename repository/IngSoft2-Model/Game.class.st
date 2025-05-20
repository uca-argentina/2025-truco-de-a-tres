Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'board',
		'dice',
		'turn',
		'winner',
		'currentTurnIndex'
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

{ #category : 'initialization' }
Game >> initializeWithShips: someShips board: aBoard dice: someDices [

	self validateMinimumSpaceShips: someShips.
	self validateMinimumDice: someDices.
	self validateBoard: aBoard.

	spaceShips := someShips.
	board := aBoard.
	dice := someDices.
	turn := 1. "Amounts of turns played"
	currentTurnIndex := 1. "Es el indice del jugador que debe jugar" "Seria el indice de la ordered collection para saber de que nave es el turno. EJ: si currentTurnIndex es 1 entonces es el turno de la primer nave que esta en el orderedCollection"

	winner := nil
]

{ #category : 'testing' }
Game >> isGameOver [

	^ winner notNil
]

{ #category : 'process actions' }
Game >> playTurn [

	| ship |
	self isGameOver ifTrue: [ self error: 'Game is already over' ].
	

	ship := self currentShip.
	self validateIsCurrentPlayer: ship.
	dice do: [ :eachDie | ship advanceWith: eachDie on: board ].

	(ship hasReachedGoalOn: board) ifTrue: [ winner := ship ].

	self advanceTurn
]

{ #category : 'process actions' }
Game >> playTurnFor: aSpaceship [
	|currentShip|
	self isGameOver ifTrue: [ self error: 'Game is already over' ].

	currentShip := spaceShips at: currentTurnIndex.
	dice do: [ :eachDie | currentShip advanceWith: eachDie on: board ].

	(aSpaceship hasReachedGoalOn: board) ifTrue: [ winner := aSpaceship ].

	self advanceTurn.
	
"No lo estamos usando"
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

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
