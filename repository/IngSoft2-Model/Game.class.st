Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dice',
		'turn',
		'winner',
		'board',
		'spaceShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
Game >> validateMinimumDice: someDices [

	someDices ifEmpty: [
		self error: 'At least one die is required to initialize the game' ]
]

{ #category : 'validation' }
Game >> validateMinimumSpaceShips: someShips [

	someShips size < 2 ifTrue: [ 
		self error:'Need 2 space ships or more to initialize the game']
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
