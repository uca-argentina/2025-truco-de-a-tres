Class {
	#name : 'GameStateTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameStateTest >> testGameFinishedWithWinnerInitializesCorrectly [
	| ship finishedGame |
	ship := Spaceship withName: 'Winner'.
	finishedGame := GameFinished withWinner: ship.

	self assert: finishedGame winner equals: ship.
]

{ #category : 'tests' }
GameStateTest >> testInitializeWithWinnerSetsWinner [
	| ship finishedGame |
	ship := Spaceship withName: 'Winner'.
	finishedGame := GameFinished new initializeWithWinner: ship.

	self assert: finishedGame winner equals: ship.
]
