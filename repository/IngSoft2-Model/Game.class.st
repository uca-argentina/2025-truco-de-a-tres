Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'die',
		'spaceships',
		'currentPlayerIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Game >> currentTurn [

	^ turn
]

{ #category : 'initialize' }
Game >> initializeWithPlayers: playerNames cells: numberOfCells wormholes: wormholeDict [
	board := Board new initializeWithCells: numberOfCells wormholes: wormholeDict.
	die := Die new initializeWithSides: 6.
	spaceships := playerNames collect: [ :name | Spaceship new initializeWith: name ].
	currentPlayerIndex := 1.

]

{ #category : 'testing' }
Game >> isGameOver [

	^ winner notNil
]

{ #category : 'initialize' }
Game >> playTurn [
	| ship steps newPosition |
	ship := spaceships at: currentPlayerIndex.
	steps := die roll.
	newPosition := board newPositionFrom: ship position steps: steps.
	ship moveTo: newPosition.

]

{ #category : 'initialize' }
Game >> spaceships [
    ^ spaceships

]

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
