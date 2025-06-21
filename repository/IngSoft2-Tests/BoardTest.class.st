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

    ship := Spaceship withName: 'Ship' and: 4.
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

	| dice1 dicesGame effect ship1 ship2 ship3 allShips |
	
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	effect := AtomicBombEffect new.

	ship1 := Spaceship withName: 'Red' and: dicesGame maxRoll.
	ship2 := Spaceship withName: 'Blue' and: dicesGame maxRoll.
	ship3 := Spaceship withName: 'Green' and: dicesGame maxRoll.

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
BoardTest >> testBoardCellCountIsCorrect [
    | board size |

    size := 7.
    board := Board of: size andWormholeAt: #().

    self assert: board cells size equals: size.
]

{ #category : 'tests - instance' }
BoardTest >> testBoardCellsContainRecognizedEffects [
	| board validClasses |
	validClasses := { BlackHoleEffect. HyperGravityEffect }.

	board := Board of: 20 andWormholeAt: OrderedCollection new.

	self assert: (board cells allSatisfy: [:e |
		validClasses anySatisfy: [:c | e class = c ] ]).

]

{ #category : 'tests - instance' }
BoardTest >> testBoardInitializesCorrectNumberOfEffects [
	| board |
	board := Board of: 20 andWormholeAt: OrderedCollection new.

	self assert: board cells size equals: 20.

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
BoardTest >> testHyperGravityEffectHasCorrectDefaultRoll [
	| effect |
	effect := HyperGravityEffect new.
	self assert: effect requiredRoll equals: 4.

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

	ship := Spaceship withName: 'Lucas' and: 4.
	ship moveTo: 3.

	newPosition := board calculateNewPositionFrom: ship position after: 4 moves: ship.

	self assert: newPosition equals: 7.
	self assert: ship lap equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testLapIncrementsWhenPassingLastCell [
	| dice1 dicesGame board ship newPosition |
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	board := Board of: 10 andWormholeAt: OrderedCollection new.
	ship := Spaceship withName: 'Lucas' and: dicesGame maxRoll.
	ship moveTo: 8.

	newPosition := board calculateNewPositionFrom: ship position after: 3 moves: (LappedShip for: ship) .


	self assert: newPosition equals: 1.
	self assert: (LappedShip for: ship) lapCount equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testMoonWalkEffectMovesOtherSpaceshipsBackwards [
	| dice1 dicesGame effect ship1 ship2 ship3 allShips |

	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	effect := MoonWalkEffect new.

	ship1 := Spaceship withName: 'Player1' and: dicesGame maxRoll.
	ship2 := Spaceship withName: 'Player2' and: dicesGame maxRoll.
	ship3 := Spaceship withName: 'Player3' and: dicesGame maxRoll.

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
