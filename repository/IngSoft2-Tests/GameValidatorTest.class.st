Class {
	#name : 'GameValidatorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameValidatorTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage].
	
]

{ #category : 'tests' }
GameValidatorTest >> testDefaultReturnsValidatorInstance [

	| validator |
	validator := GameValidator default.
	self assert: validator class equals: GameValidator.
	self assert: validator notNil
]

{ #category : 'tests' }
GameValidatorTest >> testValidateIsCurrentPlayerRaisesError [

	| ship1 ship2 board dice game validator |
	ship1 := Spaceship withName: 'First'.
	ship2 := Spaceship withName: 'Second'.
	board := Board of: 5 andWormholeAt: {  }.
	dice := DiceCup with: { (Die withSides: 6) }.

	game := Game
		        startWithShips: {
				        ship1.
				        ship2 }
		        board: board
		        dice: dice
		        laps: 1.
	validator := GameValidator new.

	self
		should: [ validator validateIsCurrentPlayer: ship2 forGame: game ]
		raise: Error
		withMessageText: 'It is not the turn of this spaceship'
]

{ #category : 'tests' }
GameValidatorTest >> testValidateMinimumSpaceShipsFailsWithOneShip [

	| dice board |
	dice := DiceCup new initializeWith: { (Die withSides: 6) }.
	board := Board of: 5 andWormholeAt: {  }.

	self
		should: [
			Game
				startWithShips: { (Spaceship withName: 'Solo') }
				board: board
				dice: dice
				laps: 1 ]
		raise: Error
		withMessageText: 'Need 2 space ships or more to initialize the game'
]

{ #category : 'tests' }
GameValidatorTest >> testWhenAShipTriesToPlayOutOfTurnThenError [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game validator |
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 25 andWormholeAt: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	game playTurn.
	validator := GameValidator new.

	self
		should: [ validator validateIsCurrentPlayer: spaceShip1 forGame: game ]
		raise: Error
		withMessageText: 'It is not the turn of this spaceship'
]
