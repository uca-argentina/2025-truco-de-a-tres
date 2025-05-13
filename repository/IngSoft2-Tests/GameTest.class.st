Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
GameTest >> testGameEndsWhenPlayerReachesGoal [
    | game ship |
    game := Game new initializeWithPlayers: #('Ada') cells: 1 wormholes: Dictionary new.
    ship := game currentPlayer.

    game playTurn.

    self assert: game isOver.
    self assert: game winner equals: ship.

]

{ #category : 'tests - instance' }
GameTest >> testGameEndsWhenPlayerWins [
	| game |
	game := Game new initializeWithPlayers: #('Red') cells: 1 wormholes: Dictionary new.
	game playTurn.

	self assert: game isOver.

]

{ #category : 'tests - instance' }
GameTest >> testGameInitializesWithCorrectCurrentPlayer [
	| game |
	game := Game new initializeWithPlayers: #('Red' 'Blue') cells: 10 wormholes: Dictionary new.
	self assert: (game currentPlayer playerName) equals: 'Red'.

]

{ #category : 'tests - instance' }
GameTest >> testGameStartsNotOver [
	| game |
	game := Game new initializeWithPlayers: #('Red' 'Blue') cells: 10 wormholes: Dictionary new.
	
	self deny: game isOver.
	self assert: game winner isNil.

]

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
	| game position |
	game := Game new initializeWithPlayers: #('Red') cells: 10 wormholes: Dictionary new.
	game playTurn.
	position := game currentPlayer position.
	self assert: (position between: 1 and: 6).

]

{ #category : 'tests - instance' }
GameTest >> testPlayTurnWrapsAround [
	| game |
	game := Game new initializeWithPlayers: #('Red' 'Blue') cells: 10 wormholes: Dictionary new.
	game playTurn.
	game playTurn.
	self assert: (game currentPlayer playerName) equals: 'Red'.

]
