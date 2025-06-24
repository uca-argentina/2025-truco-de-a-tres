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

    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    ship3 := Spaceship withName: 'Three'.

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

    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    dice := DiceCup with: { Die withSides: 1 }.
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

    ship1 := Spaceship withName: 'First'.
    ship2 := Spaceship withName: 'Second'.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    self assert: game currentShip equals: ship1.
    game advanceTurn.
    self assert: game currentShip equals: ship2.
]

{ #category : 'tests' }
GameTest >> testEnsureGameIsNotOverRaisesErrorIfGameFinished [
	| ship1 ship2 dice board game |

	ship1 := Spaceship withName: 'Alpha'.
	ship2 := Spaceship withName: 'Beta'.

	dice := DiceCup with: { Die withSides: 100 }.
	board := Board of: 5 andWormholeAt: #().

	ship1 moveTo: 4.
	ship2 moveTo: 0.

	game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
	game playTurn.
	game checkWinCondition.

	self should: [ game ensureGameIsNotOver ] raise: Error.
]

{ #category : 'tests' }
GameTest >> testFindPenaltyForReturnsExistingPenalty [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Penalized'.
    ship2 := Spaceship withName: 'Unpunished'.
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

	game playUntilFinish.

	game whenFinishedDo: [ :w | self assert: true ] whenInProgressDo: [ self fail: 'Expected game to be finished' ].
]

{ #category : 'tests' }
GameTest >> testGameReturnsAllStatuses [
    | ship1 ship2 board dice game statuses |
    
    ship1 := Spaceship withName: 'A'.
    ship2 := Spaceship withName: 'B'.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    statuses := game allStatuses.

    self assert: statuses size equals: 2.
    self assert: (statuses allSatisfy: [ :status | status ship isNotNil ]).
]

{ #category : 'tests' }
GameTest >> testGameReturnsFinalPositionsOfSpaceships [
	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game positions finalPositionShip1 finalPositionShip2 pos1 pos2 |

dice1 := Die withSides: 100.
dicesGame := DiceCup with: (OrderedCollection with: dice1).

spaceShip1 := Spaceship withName: 'Ship Num1'.
spaceShip2 := Spaceship withName: 'Ship Num2'.
spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

boardGame := Board of: 10 andWormholeAt: #().

game := Game
	startWithShips: spaceShipsGame
	board: boardGame
	dice: dicesGame
	laps: 1.

[ game whenFinishedDo: [ :w | false ] whenInProgressDo: [ true ] ]
	whileTrue: [ game playTurn ].

positions := game spaceshipPositions.
finalPositionShip1 := spaceShip1 position.
finalPositionShip2 := spaceShip2 position.

pos1 := positions detect: [ :each | each ship = spaceShip1 ].
pos2 := positions detect: [ :each | each ship = spaceShip2 ].

self assert: pos1 position equals: finalPositionShip1.
self assert: pos2 position equals: finalPositionShip2.
]

{ #category : 'tests' }
GameTest >> testHandlePenaltyOrPassIfNeededReturnsFalseWhenNoPenaltyAndNoPass [
	| ship dice board game result |

	ship := Spaceship withName: 'Neutral'.
	dice := DiceCup with: { Die withSides: 6 }.
	board := Board of: 5 andWormholeAt: #().
	game := Game startWithShips: { ship. (Spaceship withName: 'Other') } board: board dice: dice laps: 1.

	result := game handlePenaltyOrPassIfNeeded.

	self assert: result equals: false.
]

{ #category : 'tests' }
GameTest >> testHandlePenaltyOrPassIfNeededReturnsTrueWhenPenalized [
	| ship dice board game result |

	ship := Spaceship withName: 'Penalized'.
	dice := DiceCup with: { Die withSides: 6 }.
	board := Board of: 5 andWormholeAt: #().
	game := Game startWithShips: { ship. (Spaceship withName: 'Other') } board: board dice: dice laps: 1.

	game penalize: ship forTurns: 1.

	result := game handlePenaltyOrPassIfNeeded.

	self assert: result equals: true.
]

{ #category : 'tests' }
GameTest >> testHandlePenaltyOrPassIfNeededReturnsTrueWhenShipWantsToPassTurn [
	| ship dice board game result |

	ship := Spaceship withName: 'Pasante'.
	dice := DiceCup with: { Die withSides: 6 }.
	board := Board of: 5 andWormholeAt: #().
	game := Game startWithShips: { ship. (Spaceship withName: 'Other') } board: board dice: dice laps: 1.

	game markShipAsWantingToPassTurn: ship to: true.

	result := game handlePenaltyOrPassIfNeeded.

	self assert: result equals: true.
]

{ #category : 'accessing' }
GameTest >> testHasWonByLapsReturnsFalseIfNotEnoughLaps [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Almost'.
    ship2 := Spaceship withName: 'Filler'.
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

    ship1 := Spaceship withName: 'Winner'.
    ship2 := Spaceship withName: 'Loser'.
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

ship1 := Spaceship withName: 'Closer'.
ship2 := Spaceship withName: 'Later'.
board := Board of: 5 andWormholeAt: #().
dice := DiceCup with: { Die withSides: 6 }.

game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
game playUntilFinish.

game whenFinishedDo: [ :w | self assert: true ] 
     whenInProgressDo: [ self fail: 'Expected the game to be over' ].
]

{ #category : 'tests' }
GameTest >> testIsPenalizedDetectsPenalizedShip [

    | ship1 ship2 game dice |

    ship1 := Spaceship withName: 'P1'.
    ship2 := Spaceship withName: 'P2'.
    dice := DiceCup with: { Die withSides: 1 }.
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

    ship1 := Spaceship withName: 'Skip'.
    ship2 := Spaceship withName: 'Other'.
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

    ship1 := Spaceship withName: 'Solo'.
    ship2 := Spaceship withName: 'Dummy'.
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
GameTest >> testPenaltyTurnsRemainingFor [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Penalized'.
    ship2 := Spaceship withName: 'Other'.
    board := Board of: 10 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    game penalize: ship1 forTurns: 2.

    self assert: (game penaltyTurnsRemainingFor: ship1) equals: 2.

    game reducePenaltyFor: ship1.

    self assert: (game penaltyTurnsRemainingFor: ship1) equals: 1.
]

{ #category : 'tests' }
GameTest >> testPlayTurnHandlesPassTurnCorrectly [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Passing'.
    ship2 := Spaceship withName: 'Next'.
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

    ship1 := Spaceship withName: 'Player1'.
    ship2 := Spaceship withName: 'Player2'.
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

ship1 := Spaceship withName: 'One'.
ship2 := Spaceship withName: 'Two'.
board := Board of: 2 andWormholeAt: #().
dice := DiceCup with: { Die withSides: 1 }.

game := Game
	startWithShips: { ship1. ship2 }
	board: board
	dice: dice
	laps: 1.

ship1 moveTo: 1.
game playTurn.

game whenFinishedDo: [ :w | self assert: true ]
     whenInProgressDo: [ self fail: 'Expected game to be over' ].

self should: [ game playTurn ] raise: Error.

]

{ #category : 'tests' }
GameTest >> testPlayTurnSkipsPenalizedShip [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Penalized'.
    ship2 := Spaceship withName: 'Next'.
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

	ship1 := Spaceship withName: 'Fast'.
	ship2 := Spaceship withName: 'Slow'.
	board := Board of: 5 andWormholeAt: {}.
	dice := DiceCup with: { Die withSides: 6 }.

	game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
	game playUntilFinish.

	self assert: game winner isNotNil.
]

{ #category : 'accessing' }
GameTest >> testPlayUntilFinishEndsWhenWinnerIsFound [
    | ship1 ship2 game dice |

ship1 := Spaceship withName: 'Rápida'.
ship2 := Spaceship withName: 'Lenta'.
dice := DiceCup with: { Die withSides: 6 }.

game := Game
	startWithShips: { ship1. ship2 }
	board: (Board of: 2 andWormholeAt: #())
	dice: dice
	laps: 1.

game playUntilFinish.

game whenFinishedDo: [ :w | self assert: true ]
     whenInProgressDo: [ self fail: 'Expected game to be finished' ].
]

{ #category : 'tests' }
GameTest >> testRankingReturnsShipsOrderedByLapsAndPosition [

        | spaceShip1 spaceShip2 spaceShip3 spaceShipsGame  dice1  dicesGame boardGame game ranking |
  
  	dice1 := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
  	spaceShip3 := Spaceship withName: 'Ship Num3'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2 with: spaceShip3.

	boardGame := Board of: 3 andWormholeAt: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 2.

	game playUntilFinish.

        ranking := game ranking.

        self assert: ranking size equals: 3.

        self assert: ranking first ship equals: spaceShip1.
        self assert: ranking second ship equals: spaceShip2.
        self assert: ranking third ship equals: spaceShip3
]

{ #category : 'accessing' }
GameTest >> testReducePenaltyDecreasesTurnCount [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'PenaltyShip'.
    ship2 := Spaceship withName: 'Other'.
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

    ship := Spaceship withName: 'Penalized'.
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game
        startWithShips: { ship. Spaceship withName: 'Other' }
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

    ship1 := Spaceship withName: 'Runner'.
    ship2 := Spaceship withName: 'Other'.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    ship1 moveTo: 9.
    game registerLapFor: ship1 from: 9 after: 2.

    self assert: ((game lapTrackerFor: ship1) lapCount) equals: 1.
]

{ #category : 'tests' }
GameTest >> testRewardOnMaxRollChangesFuel [
    | ship otherShip dice board game initialMax initialFuel |
    ship := Spaceship withName: 'Reward'.
    otherShip := Spaceship withName: 'Other'.
    dice := DiceCup with: { Die withSides: 1 }.
    board := Board of: 5 andWormholeAt: #().
    ship instVarNamed: 'maxFuel' put: 5.
    ship instVarNamed: 'fuel' put: 5.
    game := Game startWithShips: { ship. otherShip } board: board dice: dice laps: 1.
    initialMax := ship instVarNamed: 'maxFuel'.
    initialFuel := ship instVarNamed: 'fuel'.
    game rollAndMoveCurrentShip.
    self assert: ((ship instVarNamed: 'maxFuel') = (initialMax + 1)
        or: [ (ship instVarNamed: 'fuel') = (initialFuel - 1) ]).
]

{ #category : 'tests' }
GameTest >> testRollAndMoveCurrentShipMovesShipCorrectly [
	| ship otherShip dice board game originalPosition |

	ship := Spaceship withName: 'Mover'.
	otherShip := Spaceship withName: 'Otro'.
	dice := DiceCup with: { Die withSides: 1 }.
	board := Board of: 10 andWormholeAt: #().
	game := Game startWithShips: { ship. otherShip } board: board dice: dice laps: 1.

	originalPosition := ship position.

	game rollAndMoveCurrentShip.

        self assert: ship position equals: originalPosition + 1.
]

{ #category : 'accessing' }
GameTest >> testSetAndQueryWantsToPassTurn [

    | ship1 ship2 board dice game |

    ship1 := Spaceship withName: 'Picky'.
    ship2 := Spaceship withName: 'Spare'.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    self deny: (game wantsToPassTurn: ship1).

    game markShipAsWantingToPassTurn: ship1 to: true.
    self assert: (game wantsToPassTurn: ship1).
]

{ #category : 'tests' }
GameTest >> testShipPositionsReflectCurrentPositionsOfAllShips [

    | ship1 ship2 board dice game positions pos1 pos2 |

ship1 := Spaceship withName: 'Alpha'.
ship2 := Spaceship withName: 'Beta'.
board := Board of: 10 andWormholeAt: #().
dice := DiceCup with: { Die withSides: 1 }.

game := Game
    startWithShips: { ship1. ship2 }
    board: board
    dice: dice
    laps: 1.

positions := game spaceshipPositions.

pos1 := positions detect: [ :each | each ship = ship1 ].
pos2 := positions detect: [ :each | each ship = ship2 ].

self assert: pos1 position equals: 0.
self assert: pos2 position equals: 0.
]

{ #category : 'accessing' }
GameTest >> testShipStatusReturnsCorrectValues [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game status |
	dice1 := Die withSides: 2.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
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

        | spaceShip1 spaceShip2  spaceShipsGame die dicesGame boardGame game status1 status2 |
	
	die := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: die).
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection
		                  with: spaceShip1
		                  with: spaceShip2.

	boardGame := Board of: 2 andWormholeAt: #(  ).

        game := Game
                        startWithShips: spaceShipsGame
                        board: boardGame
                        dice: dicesGame
                        laps: 2.
	
        game playTurn.
        game playTurn.
        game playTurn.

        status1 := game statusFor: spaceShip1.
        status2 := game statusFor: spaceShip2.

	self assert: status1 lapCount equals: 1.
	self assert: status2 lapCount equals: 0.
]

{ #category : 'tests' }
GameTest >> testShipStatusReturnsCurrentPosition [

        | spaceShip1 spaceShip2  spaceShipsGame die dicesGame boardGame game status1 status2 |
	
	die := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: die).
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection
		                  with: spaceShip1
		                  with: spaceShip2.

	boardGame := Board of: 2 andWormholeAt: #(  ).

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

        game playUntilFinish.

        status1 := game statusFor: spaceShip1.
        status2 := game statusFor: spaceShip2.

	self assert: status1 position equals: 2.
	self assert: status2 position equals: 1.

]

{ #category : 'tests' }
GameTest >> testShipsStartWithTwoCards [
	| ship1 ship2 board dice game |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    self assert: ship1 cards size equals: 2.
    self assert: ship2 cards size equals: 2.
]

{ #category : 'tests' }
GameTest >> testSpaceshipPositionsReturnsCorrectMapping [

    | ship1 ship2 game board dice positions pos1 pos2 |

    ship1 := Spaceship withName: 'MapOne'.
    ship2 := Spaceship withName: 'MapTwo'.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    ship1 moveTo: 3.
    ship2 moveTo: 7.

    positions := game spaceshipPositions.

    pos1 := positions detect: [ :each | each ship = ship1 ].
    pos2 := positions detect: [ :each | each ship = ship2 ].

    self assert: pos1 position equals: 3.
    self assert: pos2 position equals: 7.
]

{ #category : 'tests' }
GameTest >> testSpaceshipPositionsReturnsCorrectPositions [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game positions pos1 pos2 |

	dice1 := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 10 andWormholeAt: #().

	game := Game
		        startWithShips: spaceShipsGame
		        board: boardGame
		        dice: dicesGame
		        laps: 1.

	game playTurn.

	positions := game spaceshipPositions.

	pos1 := positions detect: [ :each | each ship = spaceShip1 ].
	pos2 := positions detect: [ :each | each ship = spaceShip2 ].

	self assert: pos1 position equals: 1.
	self assert: pos2 position equals: 0.
]

{ #category : 'tests' }
GameTest >> testStatusForReturnsCorrectInfo [

    | ship1 ship2 board dice game status |

    ship1 := Spaceship withName: 'StatusShip'.
    ship2 := Spaceship withName: 'Dummy'.
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

    ship1 := Spaceship withName: 'Alpha'.
    ship2 := Spaceship withName: 'Beta'.
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.

    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    status := game statusFor: ship1.

    self assert: status ship equals: ship1.
    self assert: status position equals: 0.
]

{ #category : 'tests' }
GameTest >> testWhenGameCorrectlyCreatedThenNotNil [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dice2 dicesGame boardGame game |
	
	dice1 := Die withSides: 1.
	dice2 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1 with: dice2).
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
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
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
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
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
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
	
	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
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

	self deny: originalPosition equals: newPosition.
]

{ #category : 'tests' }
GameTest >> testWhenShipDecidesToPassTurnThenSkipTurn [

        | spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |

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
        game playTurn.
        game markShipAsWantingToPassTurn: spaceShip1 to: true.
        game playTurn.

        self assert: game currentShip equals: spaceShip2.

	game playUntilFinish.
]

{ #category : 'tests' }
GameTest >> testWhenShipIsPenalizedThenSkipsTurnAndReducesPenalty [

        | spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |
	
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

        game penalize: spaceShip1 forTurns: 2.
        game playTurn.

        self assert: game currentShip equals: spaceShip2.

	game playTurn.
	game playTurn.
	game playTurn.

        self assert: (game isPenalized: spaceShip1) not.
        self assert: game currentShip equals: spaceShip1.

	game playTurn.
	game playUntilFinish
]

{ #category : 'tests' }
GameTest >> testWhenShipReachesGoalThenGameEnds [
| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |

dice1 := Die withSides: 100.
dicesGame := DiceCup with: (OrderedCollection with: dice1).

spaceShip1 := Spaceship withName: 'Ship Num1'.
spaceShip2 := Spaceship withName: 'Ship Num2'.
spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

boardGame := Board of: 1 andWormholeAt: #().

game := Game
	startWithShips: spaceShipsGame
	board: boardGame
	dice: dicesGame
	laps: 1.

game playTurn.

game whenFinishedDo: [ :w | self assert: true ]
     whenInProgressDo: [ self fail: 'Expected game to be finished' ].
]

{ #category : 'tests' }
GameTest >> testWhenShipWinsByCompletingRequiredLapsThenEndsGame [


        | spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame totalLaps game |
	dice1 := Die withSides: 1.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
	spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

	boardGame := Board of: 3 andWormholeAt: #(  ).

        totalLaps := 3.


        game := Game
                        startWithShips: spaceShipsGame
                        board: boardGame
                        dice: dicesGame
                        laps: totalLaps.

        game playUntilFinish.
        self assert: (game lapTrackerFor: spaceShip1) lapCount equals: 3.
        self assert: (game hasWonByLaps: spaceShip1)
]

{ #category : 'tests' }
GameTest >> testWhenSpaceShipEndsTurnThenRotatesPlayerTurn [
| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game expectedSequence actualSequence |

dice1 := Die withSides: 1.
dicesGame := DiceCup with: (OrderedCollection with: dice1).

spaceShip1 := Spaceship withName: 'Ship Num1'.
spaceShip2 := Spaceship withName: 'Ship Num2'.
spaceShipsGame := OrderedCollection with: spaceShip1 with: spaceShip2.

boardGame := Board of: 5 andWormholeAt: #().

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

[ actualSequence size < expectedSequence size and: (
	game whenFinishedDo: [ :w | false ]
	     whenInProgressDo: [ true ]) ]
	whileTrue: [
		actualSequence add: game currentShip.
		game playTurn
	].

self assert: actualSequence equals: expectedSequence.
]

{ #category : 'tests' }
GameTest >> testWhenWinnerSpaceShipIsCorrectWhenGameEnds [

	| spaceShip1 spaceShip2 spaceShipsGame dice1 dicesGame boardGame game |
	
	dice1 := Die withSides: 100.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	spaceShip1 := Spaceship withName: 'Ship Num1'.
	spaceShip2 := Spaceship withName: 'Ship Num2'.
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
