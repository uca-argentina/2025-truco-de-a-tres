Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
GameTest >> testInitializeCreatesGameWithAllPlayers [
	| game |
	game := Game new
		initializeWithPlayers: #('Neil' 'Buzz' 'Michael')
		cells: 20
		wormholes: Dictionary new.

	self assert: game spaceships size equals: 3.
	self assert: (game spaceships allSatisfy: [ :s | s class = Spaceship ]).

]

{ #category : 'tests - instance' }
GameTest >> testPlayTurnMovesCurrentPlayer [
	| game ship |
	game := Game new
		initializeWithPlayers: #('Javi')
		cells: 10
		wormholes: Dictionary new.

	ship := game spaceships first.
	self assert: ship position equals: 0.

	game playTurn.

	self assert: ship position > 0.

]
