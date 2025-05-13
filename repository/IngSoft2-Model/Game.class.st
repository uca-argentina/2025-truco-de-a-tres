Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'die',
		'spaceships',
		'currentPlayerIndex',
		'playerName',
		'gameOver',
		'currentPlayer',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Game >> currentPlayer [
	^ spaceships at: currentPlayerIndex

]

{ #category : 'initialize' }
Game >> initializeWithPlayers: playerNames cells: numberOfCells wormholes: wormholeDict [
	board := Board new initializeWithCells: numberOfCells wormholes: wormholeDict.
	die := Die new initializeWithSides: 6.
	spaceships := playerNames collect: [ :name | Spaceship new initializeWith: name ].
	currentPlayerIndex := 1.

]

{ #category : 'initialize' }
Game >> isOver [
    ^ gameOver

]

{ #category : 'initialize' }
Game >> playTurn [
	| ship steps newPosition |
	ship := spaceships at: currentPlayerIndex.
	steps := die roll.
	newPosition := board newPositionFrom: ship position steps: steps.
	ship moveTo: newPosition.

	(ship hasReachedGoalOn: board)
		ifTrue: [
			gameOver := true.
			winner := ship.
			^self
		].

	currentPlayerIndex := currentPlayerIndex \\ spaceships size + 1.

]

{ #category : 'initialize' }
Game >> spaceships [
    ^ spaceships

]

{ #category : 'initialize' }
Game >> winner [
    ^ winner

]
