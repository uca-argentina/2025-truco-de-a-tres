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

{ #category : 'initialize' }
Game >> initializeWithPlayers: playerNames cells: numberOfCells wormholes: wormholeDict [
	board := Board new initializeWithCells: numberOfCells wormholes: wormholeDict.
	die := Die new initializeWithSides: 6.
	spaceships := playerNames collect: [ :name | Spaceship new initializeWith: name ].
	currentPlayerIndex := 1.

]

{ #category : 'initialize' }
Game >> spaceships [
    ^ spaceships

]
