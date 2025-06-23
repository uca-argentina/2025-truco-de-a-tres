Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests - instance' }
BoardTest >> testApplyEffectToDoesNothingIfNoEffect [

    | board ship cells |

    ship := Spaceship withName: 'Ship'.
    ship moveTo: 2.

    board := Board of: 5 andWormholeAt: {}.

    cells := (1 to: 5) collect: [:i | nil].
    board instVarNamed: 'cells' put: cells asArray.

    board applyEffectTo: ship.

    self assert: ship position equals: 2.

]

{ #category : 'tests - instance' }
BoardTest >> testApplyWormholeIfPresentReturnsExit [

    | board wormhole |

    wormhole := Wormhole from: 2 to: 7.
    board := Board of: 10 andWormholeAt: { wormhole }.

    self assert: (board applyWormholeIfPresentAt: 2) equals: 7.
]

{ #category : 'tests - instance' }
BoardTest >> testApplyWormholeIfPresentReturnsSameWhenAbsent [

    | board |

    board := Board of: 10 andWormholeAt: {}.

    self assert: (board applyWormholeIfPresentAt: 3) equals: 3.
]

{ #category : 'tests - instance' }
BoardTest >> testAtomicBombEffectResetsPositionsButKeepsLaps [

	| dice1 effect ship1 ship2 ship3 allShips |
	
	dice1 := Die withSides: 6.

	effect := AtomicBombEffect new.

	ship1 := Spaceship withName: 'Red'.
	ship2 := Spaceship withName: 'Blue'.
	ship3 := Spaceship withName: 'Green'.

	ship1 moveTo: 6.
	ship2 moveTo: 3.
	ship3 moveTo: 9.

	allShips := {
		ship1.
		ship2.
		ship3.
	}.

	effect applyTo: ship2 inContextOf: allShips.

	self assert: (LappedShip for: ship1) lapCount equals: 0.
	self assert: (LappedShip for: ship2) lapCount equals: 0.
	self assert: (LappedShip for: ship3) lapCount equals: 0.
]

{ #category : 'tests - instance' }
BoardTest >> testBlackHoleEffectMovesSpaceshipBackwards [
	| board ship |

	board := Board of: 5 andWormholeAt: #().

	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 4.

	board cells at: 4 put: BlackHoleEffect new.
	board applyEffectTo: ship.

	self assert: ship position equals: 0.
]

{ #category : 'tests - instance' }
BoardTest >> testBoardCellCountIsCorrect [
	| board size |

	size := 7.
	board := Board of: size andWormholeAt: #().

	self assert: board cellCount equals: size.
]

{ #category : 'tests - instance' }
BoardTest >> testBoardCellsContainRecognizedEffects [
	| board validClasses |

	validClasses := { BlackHoleEffect. HyperGravityEffect. NoEffect }.

	board := Board of: 20 andWormholeAt: OrderedCollection new.

	self assert: (board cells values allSatisfy: [:e |
		validClasses anySatisfy: [:c | e class = c ] ]).
]

{ #category : 'tests - instance' }
BoardTest >> testBoardInitializesCorrectNumberOfEffects [
	| board |
	board := Board of: 20 andWormholeAt: OrderedCollection new.

	self assert: board cells size equals: 20.

]

{ #category : 'tests - instance' }
BoardTest >> testBoardPreventsEntryToHyperGravityCellWithLowRoll [
	| dice1 board ship lappedShip effect newPosition |
	dice1 := Die withSides: 6.

	board := Board of: 5 andWormholeAt: #().

	
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 2.
	lappedShip := LappedShip for: ship.

	effect := HyperGravityEffect new.
	effect requiredRoll: 4.
	board cells at: 4 put: effect.

	newPosition := board 
		determineNewPositionFrom: ship position 
		after: 1.

	self assert: newPosition equals: 3.
	self assert: ship position equals: 2.
	
	self assert: lappedShip lapCount equals: 0.
]

{ #category : 'tests - instance' }
BoardTest >> testCanEnterHyperGravityCellWithSufficientRoll [
	| board effect |
	board := Board of: 5 andWormholeAt: #().
	effect := HyperGravityEffect new.
	board cells at: 3 put: effect.

	self assert: (effect allowsEntryWithRoll: 5).

]

{ #category : 'tests - instance' }
BoardTest >> testCannotEnterHyperGravityCellWithLowRoll [
	| board effect |
	board := Board of: 5 andWormholeAt: #().
	effect := HyperGravityEffect new.
	board cells at: 3 put: effect.

	self deny: (effect allowsEntryWithRoll: 2).

]

{ #category : 'tests - instance' }
BoardTest >> testEffectAtHandlesAllCases [
    | board customEffect |

    board := Board of: 10 andWormholeAt: {}.
    customEffect := BlackHoleEffect new.
    board cells at: 5 put: customEffect.

    self assert: (board effectAt: 5) equals: customEffect.
    self assert: (board effectAt: 8) class equals: NoEffect.
    self assert: (board effectAt: -1) class equals: NoEffect.
    self assert: (board effectAt: 100) class equals: NoEffect.
]

{ #category : 'tests - instance' }
BoardTest >> testEffectAtReturnsCorrectEffect [
    | board customEffect |

    board := Board of: 10 andWormholeAt: {}.
    customEffect := BlackHoleEffect new.
    board cells at: 5 put: customEffect.

    self assert: (board effectAt: 5) equals: customEffect.
    self assert: (board effectAt: 8) class equals: NoEffect.
]

{ #category : 'tests - instance' }
BoardTest >> testHyperGravityAllowsEntryWhenRollIsSufficient [

	| board ship effect newPosition |

	board := Board of: 5 andWormholeAt: #().

	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 2.

	effect := HyperGravityEffect new.
	effect requiredRoll: 4.
	board cells at: 4 put: effect.

	newPosition := board determineNewPositionFrom: ship position after: 1.
	self assert: newPosition equals: 3.

	ship moveTo: newPosition.
	board applyEffectTo: ship.

	self assert: ship position equals: 3.
]

{ #category : 'tests - instance' }
BoardTest >> testHyperGravityEffectHasCorrectDefaultRoll [
	| effect |
	effect := HyperGravityEffect new.
	self assert: effect requiredRoll equals: 4.

]

{ #category : 'tests - instance' }
BoardTest >> testHyperJumpEffectJumpsShipForward [
	| dice1 dicesGame board ship1 ship2 lappedShip1 effect newPosition game |

	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	board := Board of: 10 length: 10 andWormholeAt: #().

	effect := HyperJumpEffect withValues: #(3 5 2 4).
	board cells at: 7 put: effect.

	ship1 := Spaceship withName: 'Apollo'.
	ship1 restoreFuel.
	ship2 := Spaceship withName: 'Gemini'.
	ship2 restoreFuel.

	lappedShip1 := LappedShip for: ship1.

	ship1 moveTo: 5.
	self assert: ship1 position equals: 5.

	newPosition := board 
		determineNewPositionFrom: ship1 position 
		after: 1.
	self assert: newPosition equals: 6.

	ship1 moveTo: newPosition.
	self assert: ship1 position equals: 6.

	game := Game 
		startWithShips: {ship1. ship2}
		board: board 
		dice: dicesGame 
		laps: 1.

	effect applyTo: ship1 inBoard: board.

	self assert: ship1 position equals: 9.
]

{ #category : 'tests - instance' }
BoardTest >> testInvalidBoardCellCountRaisesError [

	self
		should: [Board of: 0 andWormholeAt: #(). ]
		raise: Error
		withMessageText: 'Board must have a positive number of cells'
]

{ #category : 'tests - instance' }
BoardTest >> testInvalidBoardWithInvalidWormholeRaisesError [

	| fakeWormhole |
	fakeWormhole := Object new.

	self
		should: [ Board of: 10 andWormholeAt: fakeWormhole ]
		raise: Error
		withMessageText: 'All wormholes must be valid objects'
]

{ #category : 'tests - instance' }
BoardTest >> testIsGoalReached [
    | board |
    board := Board of: 10 andWormholeAt: #().

    self assert: (board isGoalReachedAt: 10).
    self assert: (board isGoalReachedAt: 11).
    self deny: (board isGoalReachedAt: 9).

]

{ #category : 'tests - instance' }
BoardTest >> testIsGoalReachedAtReturnsFalseIfPositionLower [

    | board |

    board := Board of: 5 andWormholeAt: {}.

    self deny: (board isGoalReachedAt: 4).
]

{ #category : 'tests - instance' }
BoardTest >> testIsGoalReachedAtReturnsTrueIfPositionEqual [

    | board |

    board := Board of: 5 andWormholeAt: {}.

    self assert: (board isGoalReachedAt: 5).
]

{ #category : 'tests - instance' }
BoardTest >> testIsGoalReachedAtReturnsTrueIfPositionGreater [

    | board |

    board := Board of: 5 andWormholeAt: {}.

    self assert: (board isGoalReachedAt: 7).
]

{ #category : 'tests - instance' }
BoardTest >> testLapDoesNotIncrementWhenStayingWithinBounds [

	| board ship newPosition |

	board := Board of: 10 andWormholeAt: OrderedCollection new.

	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 3.

	newPosition := board calculateNewPositionFrom: ship position after: 4 moves: ship.

	self assert: newPosition equals: 7.
	self assert: ship lap equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testLapIncrementsWhenPassingLastCell [

	| dice1 board ship newPosition |
	
	dice1 := Die withSides: 6.

	board := Board of: 10 andWormholeAt: OrderedCollection new.
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 8.

	newPosition := board calculateNewPositionFrom: ship position after: 3 moves: (LappedShip for: ship) .

	self assert: newPosition equals: 1.
	self assert: (LappedShip for: ship) lapCount equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testMoonWalkEffectMovesOtherSpaceshipsBackwards [

	| dice1 effect ship1 ship2 ship3 allShips |

	dice1 := Die withSides: 6.
	
	effect := MoonWalkEffect new.

	ship1 := Spaceship withName: 'Player1'.
	ship2 := Spaceship withName: 'Player2'.
	ship3 := Spaceship withName: 'Player3'.

	ship1 moveTo: 5.
	ship2 moveTo: 7.
	ship3 moveTo: 3.

	allShips := { ship1. ship2. ship3 }.

	effect applyTo: ship2 inContextOf: allShips.

	self assert: ship2 position equals: 7.
	self assert: ship1 position equals: 3.
	self assert: ship3 position equals: 1.
]

{ #category : 'tests - instance' }
BoardTest >> testPositionWithoutWormholeReturnsSame [
    | board |
    board := Board of: 10 andWormholeAt: #().

    self assert: (board applyWormholeIfPresentAt: 5) equals: 5.

]

{ #category : 'tests - instance' }
BoardTest >> testWormholeTransportsCorrectly [
    | board |
    board := Board of: 20 andWormholeAt: (OrderedCollection withAll: {
        Wormhole from: 2 to: 10.
        Wormhole from: 10 to: 2.
    }).

    self assert: (board applyWormholeIfPresentAt: 2) equals: 10.
    self assert: (board applyWormholeIfPresentAt: 10) equals: 2.

]
