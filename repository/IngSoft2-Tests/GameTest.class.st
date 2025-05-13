Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage].
	


]

{ #category : 'tests' }
GameTest >> testMonito [

	| spaceShip1 spaceShip2 spaceShipsGame dicesGame boardGame |
	spaceShip1 := Spaceship new initializeWith: 'Ship Num1'.
	spaceShip2 := Spaceship new initializeWith: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dicesGame := OrderedCollection new.

	boardGame := Board new
		             initializeWithCells: 10
		             wormholes: Dictionary new.

	self
		should: [
		Game new withShips: spaceShipsGame board: boardGame dice: dicesGame ]
		raise: Error
		withMessageText: 'At least one die is required to initialize the game'
]

{ #category : 'tests' }
GameTest >> testWhenGameCorrectlyCreatedThenNotNil [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dice2 dicesGame boardGame game |
	spaceShip1 := Spaceship new initializeWith: 'Ship Num1'.
	spaceShip2 := Spaceship new initializeWith: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die new initializeWithSides: 1.
	dice2 := Die new initializeWithSides: 6.
	dicesGame := OrderedCollection with: dice1 with: dice2.

	boardGame := Board new
		             initializeWithCells: 10
		             wormholes: Dictionary new.

	game := Game new
		        withShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame.
	
	self assert: game notNil.
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedWithInvalidBoardThenIsInvalid [
	| spaceShip1 spaceShip2 spaceShipsGame dice1 dice2 dicesGame boardGame |
	
	spaceShip1 := Spaceship new initializeWith: 'Ship Num1'.
	spaceShip2 := Spaceship new initializeWith: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die new initializeWithSides: 1.
	dice2 := Die new initializeWithSides: 6.
	dicesGame := OrderedCollection with: dice1 with: dice2.

	boardGame := Board new initializeWithCells: 0 wormholes: nil.

	self
		should: [
			Game new withShips: spaceShipsGame board: boardGame dice: dicesGame
		]
		raise: Error
		withMessageText: 'Board must have more than 0 cells and a wormhole dictionary'.
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedWithoutADieThenIsInvalid [

	| spaceShip1 spaceShip2 spaceShipsGame dicesGame boardGame |
	spaceShip1 := Spaceship new initializeWith: 'Ship Num1'.
	spaceShip2 := Spaceship new initializeWith: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dicesGame := OrderedCollection new.

	boardGame := Board new
		             initializeWithCells: 10
		             wormholes: Dictionary new.

	self
		should: [
		Game new withShips: spaceShipsGame board: boardGame dice: dicesGame ]
		raise: Error
		withMessageText: 'At least one die is required to initialize the game'
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedWithoutTwoOrMoreShipsThenIsInvalid [

	| spaceShip1 spaceShipsGame dice1 dice2 dicesGame boardGame |
	spaceShip1 := Spaceship new initializeWith: 'Ship Num1'.
	spaceShipsGame := OrderedCollection with: spaceShip1.

	dice1 := Die new initializeWithSides: 1.
	dice2 := Die new initializeWithSides: 6.
	dicesGame := OrderedCollection with: dice1 with: dice2.

	boardGame := Board new
		             initializeWithCells: 10
		             wormholes: Dictionary new.


	self
		should: [
		Game new withShips: spaceShipsGame board: boardGame dice: dicesGame ]
		raise: Error
		withMessageText: 'Need 2 space ships or more to initialize the game'
]
