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

{ #category : 'as yet unclassified' }
Game >> playTurnFor: aSpaceship [

	self isGameOver ifTrue: [ self error: 'Game is already over' ].

	dice do: [ :eachDie | aSpaceship advanceWith: eachDie on: board ].

	(aSpaceship hasReachedGoalOn: board) ifTrue: [ winner := aSpaceship ].

	turn := turn + 1
]
