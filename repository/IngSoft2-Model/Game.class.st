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

{ #category : 'accessing' }
Game >> currentTurn [

	^ turn
]

{ #category : 'testing' }
Game >> isGameOver [

	^ winner notNil
]

{ #category : 'validation' }
Game >> validateMinimumDice: arg1 [

	arg1 ifEmpty: [
		self error: 'At least one die is required to initialize the game' ]
]

{ #category : 'validation' }
Game >> validateMinimumSpaceShips: arg1 [

	arg1 size < 2 ifTrue: [
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

	spaceShips := someShips.
	board := aBoard.
	dice := someDices.
	turn := 1.
	winner := nil.
]
