Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'board',
		'dice',
		'turn',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Game class >> withShips: someShips board: aBoard dice: someDices [

	^ self new withShips: someShips board: aBoard dice: someDices
]

{ #category : 'accessing' }
Game >> currentTurn [

	^ turn
]

{ #category : 'testing' }
Game >> isGameOver [

	^ winner notNil
]

{ #category : 'process actions' }
Game >> playTurnFor: aSpaceship [

	self isGameOver ifTrue: [ self error: 'Game is already over' ].

	dice do: [ :eachDie | aSpaceship advanceWith: eachDie on: board ].

	(aSpaceship hasReachedGoalOn: board) ifTrue: [ winner := aSpaceship ].

	turn := turn + 1
]

{ #category : 'process actions' }
Game >> spaceshipPositions [
	^ spaceShips collect: [ :ship | ship -> ship position ] as: Dictionary
]

{ #category : 'validation' }
Game >> validateBoard: aBoard [
	(aBoard cellCount <= 0 or: [ aBoard wormholes isNil ]) ifTrue: [
		self error: 'Board must have more than 0 cells and a wormhole dictionary'
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

{ #category : 'initialization' }
Game >> withShips: someShips board: aBoard dice: someDices [

	self validateMinimumSpaceShips: someShips .
	self validateMinimumDice: someDices.
	self validateBoard: aBoard.

	spaceShips := someShips.
	board := aBoard.
	dice := someDices.
	turn := 1.
	winner := nil.
]
