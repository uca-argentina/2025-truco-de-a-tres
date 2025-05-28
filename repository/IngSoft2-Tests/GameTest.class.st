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
GameTest >> testGameEndsWithPlayUntilFinish [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 25 andWormholes: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	game playUntilFinish.

	self assert: game isGameOver
]

{ #category : 'tests' }
GameTest >> testGameReturnsFinalPositionsOfSpaceships [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game positions finalPositionShip1 finalPositionShip2 |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 100. "Al ser 10 cells con un dado de 100 termina en una tirada"
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 10 andWormholes: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	[ game isGameOver ] whileFalse: [ game playTurn ].

	positions := game spaceshipPositions.
	finalPositionShip1 := spaceShip1 position.
	finalPositionShip2 := spaceShip2 position.

	self assert: (positions at: spaceShip1) equals: finalPositionShip1.
	self assert: (positions at: spaceShip2) equals: finalPositionShip2
]

{ #category : 'accessing' }
GameTest >> testShipStatusReturnsCorrectValues [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game status |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 2.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 25 andWormholes: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 2.

	game playTurn.
	game playTurn.

	status := game statusFor: spaceShip1.

	self assert: status ship equals: spaceShip1.
	self assert: status position equals: spaceShip1 position.
	self assert: status lapCount equals: 0.
	self assert: status isPenalized equals: false
]

{ #category : 'tests' }
GameTest >> testSpaceshipPositionsReturnsCorrectPositions [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game positions |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 1.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 10 andWormholes: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	game playTurn.

	positions := game spaceshipPositions.

	self assert: (positions at: spaceShip1) equals: 1.
	self assert: (positions at: spaceShip2) equals: 0
]

{ #category : 'tests' }
GameTest >> testWhenAShipTriesToPlayOutOfTurnThenError [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 25 andWormholes: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	game playTurn.

	self
		should: [ game validateIsCurrentPlayer: spaceShip1 ]
		raise: Error
		withMessageText: 'It is not the turn of this spaceship'
]

{ #category : 'tests' }
GameTest >> testWhenGameCorrectlyCreatedThenNotNil [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dice2 dicesGame boardGame game |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1 with: dice2.

	boardGame := Board withCells: 10 andWormholes: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	self assert: game notNil
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedWithInvalidBoardThenIsInvalid [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dice2 dicesGame |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1 with: dice2.

	self
		should: [
			| boardGame |
			boardGame := Board withCells: 0 andWormholes: #(  ).
			Game
				startWithShips: spaceShipsGame
				board: boardGame
				dice: dicesGame ]
		raise: Error
		withMessageText: 'Board must have a positive number of cells'
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedWithoutADieThenIsInvalid [

	| spaceShip1 spaceShip2 spaceShipsGame dicesGame boardGame |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dicesGame := OrderedCollection new.

	boardGame := Board withCells: 10 andWormholes: #(  ).


	self
		should: [
			Game
				startWithShips: spaceShipsGame
				board: boardGame
				dice: dicesGame
				laps: 1 ]
		raise: Error
		withMessageText:
		'At least one die is required to initialize the game'
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedWithoutTwoOrMoreShipsThenIsInvalid [

	| spaceShip1 spaceShipsGame dice1 dice2 dicesGame boardGame |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShipsGame := OrderedCollection with: spaceShip1.

	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1 with: dice2.

	boardGame := Board withCells: 10 andWormholes: #(  ).



	self
		should: [
			Game
				startWithShips: spaceShipsGame
				board: boardGame
				dice: dicesGame
				laps: 1 ]
		raise: Error
		withMessageText: 'Need 2 space ships or more to initialize the game'
]

{ #category : 'tests' }
GameTest >> testWhenPlayTurnThenAdvancesShip [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dice2 dicesGame boardGame game originalPosition newPosition |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1 with: dice2.

	boardGame := Board withCells: 10 andWormholes: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	originalPosition := spaceShip1 position.
	game playTurn.
	newPosition := spaceShip1 position.

	self deny: originalPosition equals: newPosition
]

{ #category : 'tests' }
GameTest >> testWhenShipDecidesToPassTurnThenSkipTurn [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game realShip1 |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 25 andWormholes: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	realShip1 := game spaceShips first.
	game playTurn. "RealShip1 plays turn"
	game playTurn. "RealShip2 plays turn"

	game setWantsToPassTurnFor: realShip1 to: true.
	game playTurn. "RealShip2 decides not to play"
	self assert: game currentShip equals: game spaceShips second.



	game playUntilFinish
]

{ #category : 'tests' }
GameTest >> testWhenShipIsPenalizedThenSkipsTurnAndReducesPenalty [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game realShip1 realShip2 |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 6.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 25 andWormholes: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	realShip1 := game spaceShips first.
	realShip2 := game spaceShips second.

	game penalize: realShip1 forTurns: 2.
	game playTurn. "RealShip1 losees turn"

	self assert: game currentShip equals: realShip2.

	game playTurn. "RealShip2 plays turn"
	game playTurn. "Penalty returns to 0 for realShip1"
	game playTurn. "RealShip2 plays turn"

	self assert: (game isPenalized: realShip1) not.
	self assert: game currentShip equals: realShip1.

	game playTurn. "RealShip1 plays turn, it is not penalized"

	game playUntilFinish
]

{ #category : 'tests' }
GameTest >> testWhenShipReachesGoalThenGameEnds [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 100.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 1 andWormholes: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	game playTurn.

	self assert: game isGameOver
]

{ #category : 'tests' }
GameTest >> testWhenShipWinsByCompletingRequiredLapsThenEndsGame [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame totalLaps game realShip1 |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 1.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 3 andWormholes: #(  ).

	totalLaps := 3.

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: totalLaps.

	realShip1 := game spaceShips first.

	game playUntilFinish.
	self assert: (game lapTrackerFor: realShip1) lapCount equals: 3.
	self assert: (game hasWonByLaps: realShip1)
]

{ #category : 'tests' }
GameTest >> testWhenSpaceShipEndsTurnThenRotatesPlayerTurn [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game expectedSequence actualSequence |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 1.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 5 andWormholes: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	expectedSequence := OrderedCollection withAll: {
			                    spaceShip1.
			                    spaceShip2.
			                    spaceShip1.
			                    spaceShip2.
			                    spaceShip1 }.

	actualSequence := OrderedCollection new.


	[
	actualSequence size < expectedSequence size and: game isGameOver not ]
		whileTrue: [
			actualSequence add: game currentShip.
			game playTurn ].

	self assert: actualSequence equals: expectedSequence
]

{ #category : 'tests' }
GameTest >> testWhenWinnerSpaceShipIsCorrectWhenGameEnds [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	dice1 := Die withSides: 100.
	dicesGame := OrderedCollection with: dice1.

	boardGame := Board withCells: 1 andWormholes: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	game playTurn.

	self assert: game winner equals: spaceShip1
]
