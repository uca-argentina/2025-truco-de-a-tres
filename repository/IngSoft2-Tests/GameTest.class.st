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
GameTest >> testAdvanceTurnCyclesCorrectly [

    | ship1 ship2 ship3 board dice game |

    ship1 := Spaceship withName: 'One' and: 4.
    ship2 := Spaceship withName: 'Two' and: 4.
    ship3 := Spaceship withName: 'Three' and: 4.

    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2. ship3 }
        board: board
        dice: dice
        laps: 1.

    game advanceTurn.
    self assert: game currentTurnIndex equals: 2.

    game advanceTurn.
    self assert: game currentTurnIndex equals: 3.

    game advanceTurn.
    self assert: game currentTurnIndex equals: 1.
]

{ #category : 'tests' }
GameTest >> testAdvanceTurnRotatesToNextShip [

    | ship1 ship2 game dice |

    ship1 := Spaceship withName: 'One' and: 4.
    ship2 := Spaceship withName: 'Two' and: 4.
    dice := DiceCup new initializeWith: 1.
    game := Game
        startWithShips: { ship1. ship2 }
        board: (Board of: 5 andWormholeAt: {})
        dice: dice
        laps: 1.

    self assert: (game currentShip == ship1).
    game advanceTurn.
    self assert: (game currentShip == ship2).

]

{ #category : 'accessing' }
GameTest >> testCurrentShipReturnsCorrectShip [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'First' and: 4.
    ship2 := Spaceship withName: 'Second' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    self assert: game currentShip equals: ship1.
    game advanceTurn.
    self assert: game currentShip equals: ship2.
]

{ #category : 'tests' }
GameTest >> testFindPenaltyForReturnsExistingPenalty [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Penalized' and: 4.
    ship2 := Spaceship withName: 'Unpunished' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    game penalize: ship1 forTurns: 2.

    self assert: (game findPenaltyFor: ship1) notNil.

]

{ #category : 'tests' }
GameTest >> testGameEndsWithPlayUntilFinish [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |

	dice1 := Die withSides: 6.
	"dicesGame := OrderedCollection with: dice1."
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.


	boardGame := Board of: 25 andWormholeAt: #(  ).

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

	dice1 := Die withSides: 100.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.


	boardGame := Board of: 10 andWormholeAt: #(  ).



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
GameTest >> testHasWonByLapsReturnsFalseIfNotEnoughLaps [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Almost' and: 4.
    ship2 := Spaceship withName: 'Filler' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 2.

    ship1 moveTo: 10.
    game registerLapFor: ship1 from: 9 after: 1.

    self deny: (game hasWonByLaps: ship1).
]

{ #category : 'accessing' }
GameTest >> testHasWonByLapsReturnsTrueWhenEnoughLaps [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Winner' and: 4.
    ship2 := Spaceship withName: 'Loser' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    ship1 moveTo: 10.
    game registerLapFor: ship1 from: 9 after: 1.

    self assert: (game hasWonByLaps: ship1).
]

{ #category : 'tests' }
GameTest >> testIsGameOverReturnsTrueWhenWinnerExists [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Closer' and: 4.
    ship2 := Spaceship withName: 'Later' and: 4.
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 6 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    game playUntilFinish.

    self assert: game isGameOver.
]

{ #category : 'tests' }
GameTest >> testIsPenalizedDetectsPenalizedShip [

    | ship1 ship2 game dice |

    ship1 := Spaceship withName: 'P1' and: 4.
    ship2 := Spaceship withName: 'P2' and: 4.
    dice := DiceCup new initializeWith: 1.
    game := Game
        startWithShips: { ship1. ship2 }
        board: (Board of: 5 andWormholeAt: {})
        dice: dice
        laps: 1.

    game penalize: ship1 forTurns: 2.

    self assert: (game isPenalized: ship1).
    self deny: (game isPenalized: ship2).
]

{ #category : 'tests' }
GameTest >> testPassTurnAdvancesIndex [

    | ship1 ship2 game board dice |

    ship1 := Spaceship withName: 'Skip' and: 4.
    ship2 := Spaceship withName: 'Other' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    self assert: game currentShip equals: ship1.
    game passTurn.
    self assert: game currentShip equals: ship2.
]

{ #category : 'tests' }
GameTest >> testPenalizeAddsPenalizedShip [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Solo' and: 4.
    ship2 := Spaceship withName: 'Dummy' and: 4.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    game penalize: ship1 forTurns: 2.

    self assert: (game isPenalized: ship1).
]

{ #category : 'tests' }
GameTest >> testPlayTurnHandlesPassTurnCorrectly [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Passing' and: 4.
    ship2 := Spaceship withName: 'Next' and: 4.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    game markShipAsWantingToPassTurn: ship1 to: true.
    game playTurn.

    self assert: game currentShip equals: ship2.
    self deny: (game wantsToPassTurn: ship1).

]

{ #category : 'tests' }
GameTest >> testPlayTurnMovesShipAndAdvancesTurn [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Player1' and: 4.
    ship2 := Spaceship withName: 'Player2' and: 4.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    game playTurn.

    self assert: ship1 position equals: 1.
    self assert: game currentShip equals: ship2.

]

{ #category : 'tests' }
GameTest >> testPlayTurnRaisesErrorWhenGameIsOver [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'One' and: 4.
    ship2 := Spaceship withName: 'Two' and: 4.
    board := Board of: 2 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    ship1 moveTo: 1.
    game playTurn.

    self assert: (game isGameOver).
    self should: [ game playTurn ] raise: Error.

]

{ #category : 'tests' }
GameTest >> testPlayTurnSkipsPenalizedShip [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Penalized' and: 4.
    ship2 := Spaceship withName: 'Next' and: 4.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    game penalize: ship1 forTurns: 1.
    game playTurn.

    self assert: game currentShip equals: ship2.

]

{ #category : 'tests' }
GameTest >> testPlayUntilFinishDeclaresWinner [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Fast' and: 4.
    ship2 := Spaceship withName: 'Slow' and: 4.
    board := Board of: 1 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 6 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    game playUntilFinish.

    self assert: (game winner) equals: ship1.
]

{ #category : 'accessing' }
GameTest >> testPlayUntilFinishEndsWhenWinnerIsFound [
    | ship1 ship2 game dice |
    ship1 := Spaceship withName: 'Rápida' and: 4.
    ship2 := Spaceship withName: 'Lenta' and: 4.
	 dice := DiceCup new initializeWith: { Die withSides: 6 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: (Board of: 2 andWormholeAt: {})
        dice: dice
        laps: 1.

    game playUntilFinish.

    self assert: game isGameOver.
]

{ #category : 'tests' }
GameTest >> testRankingReturnsShipsOrderedByLapsAndPosition [

	| spaceShip1 spaceShip2 spaceShip3 spaceShipsGame  dice1  dicesGame boardGame game ranking realShip1 realShip2 realShip3 |
  
  dice1 := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
  spaceShip3 := Spaceship withName: 'Ship Num3' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2 with: spaceShip3.
  


	boardGame := Board of: 3 andWormholeAt: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 2.

	game playUntilFinish.

	ranking := game ranking.

	realShip1 := game spaceShips first.
	realShip2 := game spaceShips second.
	realShip3 := game spaceShips third.

	self assert: ranking size equals: 3.

	"Todos juegan una vez y hacen 1 salto en la jugada entonces el orden quedaria igual por igualaciones"
	self assert: ranking first ship equals: realShip1.
	self assert: ranking second ship equals: realShip2.
	self assert: ranking third ship equals: realShip3
]

{ #category : 'accessing' }
GameTest >> testReducePenaltyDecreasesTurnCount [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'PenaltyShip' and: 4.
    ship2 := Spaceship withName: 'Other' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    game penalize: ship1 forTurns: 2.
    game reducePenaltyFor: ship1.
    game reducePenaltyFor: ship1.

    self deny: (game isPenalized: ship1).
]

{ #category : 'tests' }
GameTest >> testReducePenaltyRemovesPenaltyEventually [

    | ship game dice penalty |

    ship := Spaceship withName: 'Penalized' and: 4.
    dice := DiceCup new initializeWith: 1.
    game := Game
        startWithShips: { ship. Spaceship withName: 'Other' and: 4 }
        board: (Board of: 5 andWormholeAt: {})
        dice: dice
        laps: 1.

    game penalize: ship forTurns: 1.
    penalty := game findPenaltyFor: ship.
    
    self assert: (penalty hasPenalty).
    
    game reducePenaltyFor: ship.

    self deny: (penalty hasPenalty).

]

{ #category : 'accessing' }
GameTest >> testRegisterLapWhenCrossesFinishLine [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Runner' and: 4.
    ship2 := Spaceship withName: 'Other' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    ship1 moveTo: 9.
    game registerLapFor: ship1 from: 9 after: 2.

    self assert: ((game lapTrackerFor: ship1) lapCount) equals: 1.
]

{ #category : 'accessing' }
GameTest >> testSetAndQueryWantsToPassTurn [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Picky' and: 4.
    ship2 := Spaceship withName: 'Spare' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    self deny: (game wantsToPassTurn: ship1).

    game markShipAsWantingToPassTurn: ship1 to: true.
    self assert: (game wantsToPassTurn: ship1).
]

{ #category : 'accessing' }
GameTest >> testShipStatusReturnsCorrectValues [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game status |
	dice1 := Die withSides: 2.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.


	boardGame := Board of: 25 andWormholeAt: #(  ).

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
GameTest >> testShipStatusReturnsCurrentLap [

	| spaceShip1 spaceShip2  spaceShipsGame die dicesGame boardGame game status1 status2 realShip1 realShip2 |
	die := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: die).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection
		                  with: spaceShip1
		                  with: spaceShip2.


	boardGame := Board of: 2 andWormholeAt: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 2.

	realShip1 := game spaceShips first.
	realShip2 := game spaceShips second.
	
	game playTurn.
	game playTurn.
	game playTurn.
	
	status1 := game statusFor: realShip1.
	status2 := game statusFor: realShip2.


	self assert: status1 lapCount equals: 1.
	self assert: status2 lapCount equals: 0.

]

{ #category : 'tests' }
GameTest >> testShipStatusReturnsCurrentPosition [

	| spaceShip1 spaceShip2  spaceShipsGame die dicesGame boardGame game status1 status2 realShip1 realShip2 |
	
	die := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: die).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection
		                  with: spaceShip1
		                  with: spaceShip2.


	boardGame := Board of: 2 andWormholeAt: #(  ).


	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	realShip1 := game spaceShips first.
	realShip2 := game spaceShips second.
	
	game playUntilFinish.
	
	status1 := game statusFor: realShip1.
	status2 := game statusFor: realShip2.

	self assert: status1 position equals: 2.
	self assert: status2 position equals: 1.

]

{ #category : 'tests' }
GameTest >> testSpaceshipPositionsReturnsCorrectDict [

    | ship1 ship2 board dice game positions |

    ship1 := Spaceship withName: 'Alpha' and: 4.
    ship2 := Spaceship withName: 'Beta' and: 4.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    positions := game spaceshipPositions.

    self assert: (positions at: ship1) equals: 0.
    self assert: (positions at: ship2) equals: 0.
]

{ #category : 'tests' }
GameTest >> testSpaceshipPositionsReturnsCorrectMapping [

    | ship1 ship2 game board dice positions |

    ship1 := Spaceship withName: 'MapOne' and: 4.
    ship2 := Spaceship withName: 'MapTwo' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    ship1 moveTo: 3.
    ship2 moveTo: 7.

    positions := game spaceshipPositions.

    self assert: (positions at: ship1) equals: 3.
    self assert: (positions at: ship2) equals: 7.
]

{ #category : 'tests' }
GameTest >> testSpaceshipPositionsReturnsCorrectPositions [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game positions |


	dice1 := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.


	boardGame := Board of: 10 andWormholeAt: #(  ).



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
GameTest >> testStatusForReturnsCorrectInfo [

    | ship1 ship2 board dice game status |

    ship1 := Spaceship withName: 'StatusShip' and: 4.
    ship2 := Spaceship withName: 'Dummy' and: 4.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    status := game statusFor: ship1.

    self assert: status ship equals: ship1.
    self assert: status position equals: 0.
    self assert: status lapCount equals: 0.
    self deny: status isPenalized.
]

{ #category : 'tests' }
GameTest >> testStatusForReturnsCorrectShipStatus [

    | ship1 ship2 game board dice status |

    ship1 := Spaceship withName: 'Alpha' and: 4.
    ship2 := Spaceship withName: 'Beta' and: 4.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    status := game statusFor: ship1.

    self assert: status ship equals: ship1.
    self assert: status position equals: 0.
]

{ #category : 'tests' }
GameTest >> testValidateIsCurrentPlayerRaisesError [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'First' and: 4.
    ship2 := Spaceship withName: 'Second' and: 4.
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 6 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    self should: [ game validateIsCurrentPlayer: ship2 ] raise: Error.
]

{ #category : 'tests' }
GameTest >> testValidateMinimumSpaceShipsFailsWithOneShip [

    | dice board |

    dice := DiceCup new initializeWith: { Die withSides: 6 }.
    board := Board of: 5 andWormholeAt: {}.

    self should: [
        Game startWithShips: { Spaceship withName: 'Solo' and: 3 } board: board dice: dice laps: 1.
    ] raise: Error.

]

{ #category : 'tests' }
GameTest >> testWhenAShipTriesToPlayOutOfTurnThenError [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |

	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.


	boardGame := Board of: 25 andWormholeAt: #(  ).


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
	
	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1 with: dice2).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.




	boardGame := Board of: 10 andWormholeAt: #(  ).



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
	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1 with: dice2).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	self
		should: [
			| boardGame |

			boardGame := Board of: 0 andWormholeAt: #(  ).

			Game
				startWithShips: spaceShipsGame
				board: boardGame
				dice: dicesGame 
				laps: 1]
		raise: Error
		withMessageText: 'Board must have a positive number of cells'.
]

{ #category : 'tests' }
GameTest >> testWhenGameCreatedWithoutTwoOrMoreShipsThenIsInvalid [

	| spaceShip1 spaceShipsGame dice1 dice2 dicesGame boardGame |
	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1 with: dice2).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1.


	boardGame := Board of: 10 andWormholeAt: #(  ).




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

	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1 with: dice2).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.


	boardGame := Board of: 10 andWormholeAt: #(  ).



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

	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 25 andWormholeAt: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	realShip1 := game spaceShips first.
	
	game playTurn.
	game playTurn.
	game markShipAsWantingToPassTurn: realShip1 to: true.
	game playTurn.
	
	self assert: game currentShip equals: game spaceShips second.

	game playUntilFinish.
]

{ #category : 'tests' }
GameTest >> testWhenShipIsPenalizedThenSkipsTurnAndReducesPenalty [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game realShip1 realShip2 |
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).


	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 25 andWormholeAt: #(  ).

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

	dice1 := Die withSides: 100.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.


	boardGame := Board of: 1 andWormholeAt: #(  ).



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
	dice1 := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 3 andWormholeAt: #(  ).

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

	dice1 := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 5 andWormholeAt: #(  ).

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


	[ actualSequence size < expectedSequence size and: game isGameOver not ]
		whileTrue: [
			actualSequence add: game currentShip.
			game playTurn 
		].

	self assert: actualSequence equals: expectedSequence
]

{ #category : 'tests' }
GameTest >> testWhenWinnerSpaceShipIsCorrectWhenGameEnds [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |
	
	dice1 := Die withSides: 100.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	spaceShip1 := Spaceship withName: 'Ship Num1' and: dicesGame maxRoll.
	spaceShip2 := Spaceship withName: 'Ship Num2' and: dicesGame maxRoll.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 1 andWormholeAt: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.
		
	game playTurn.

	self assert: game winner equals: spaceShip1
]
