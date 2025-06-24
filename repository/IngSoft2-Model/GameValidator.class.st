Class {
	#name : 'GameValidator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
GameValidator class >> default [

	^ self new
]

{ #category : 'initialize' }
GameValidator class >> validateMinimumSpaceShips: someShips [

	someShips size < 2 ifTrue: [
		self error: 'Need 2 space ships or more to initialize the game' ]
]

{ #category : 'as yet unclassified' }
GameValidator >> validateIsCurrentPlayer: aSpaceship forGame: aGame [

	aGame currentShip = aSpaceship ifFalse: [
		self error: 'It is not the turn of this spaceship' ]
]
