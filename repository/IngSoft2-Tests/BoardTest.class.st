Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
BoardTest >> testApplyEffectToSpaceship [
	| board ship |
	board := Board withCells: 5 andWormholes: #().
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 3.

	board cells at: 4 put: TestEffect new.  "posición 3 → índice 4"

	board applyEffectTo: ship.

	self assert: ship lap equals: 1.

]

{ #category : 'tests - instance' }
BoardTest >> testBlackHoleEffectMovesSpaceshipBackwards [
	| board ship |
	board := Board withCells: 5 andWormholes: #().
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 3.

	board cells at: 4 put: BlackHoleEffect new.  "posición 3 → índice 4 (1-based)"
	board applyEffectTo: ship.

	self assert: ship position equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testBoardCellsContainRecognizedEffects [
	| board validEffects |
	validEffects := #('NoEffect' 'BlackHole' 'HyperGravity' 'MoonWalk' 'HyperJump' 'AtomicBomb').

	board := Board withCells: 20 andWormholes: OrderedCollection new.

	self assert: (board cells allSatisfy: [:e | validEffects includes: e ]).

]

{ #category : 'tests - instance' }
BoardTest >> testBoardInitializesCorrectNumberOfEffects [
	| board |
	board := Board withCells: 20 andWormholes: OrderedCollection new.

	self assert: board cells size equals: 20.

]

{ #category : 'tests - instance' }
BoardTest >> testIsGoalReached [
    | board |
    board := Board withCells: 10 andWormholes: #().

    self assert: (board isGoalReachedAt: 10).
    self assert: (board isGoalReachedAt: 11).
    self deny: (board isGoalReachedAt: 9).

]

{ #category : 'tests - instance' }
BoardTest >> testLapDoesNotIncrementWhenStayingWithinBounds [
	| board ship newPosition |
	board := Board withCells: 10 andWormholes: OrderedCollection new.
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 3.

	newPosition := board circularPositionFrom: ship position steps: 4 for: ship.

	self assert: newPosition equals: 7.
	self assert: ship lap equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testLapIncrementsWhenPassingLastCell [
	| board ship newPosition |
	board := Board withCells: 10 andWormholes: OrderedCollection new.
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 8.

	newPosition := board circularPositionFrom: ship position steps: 3 for: ship.

	self assert: newPosition equals: 1.
	self assert: ship lap equals: 1.

]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithWormhole [
	| board ship |
	board := Board withCells: 25 andWormholes: (OrderedCollection with: (Wormhole from: 6 to: 20)).
	ship := Spaceship withName: 'Test'.

	self assert: (board newPositionFrom: 2 steps: 4 for: ship) equals: 20.

]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithoutWormhole [
	| board ship |
	board := Board withCells: 25 andWormholes: #().
	ship := Spaceship withName: 'Test'.

	self assert: (board newPositionFrom: 2 steps: 2 for: ship) equals: 4.

]

{ #category : 'tests - instance' }
BoardTest >> testPositionWithoutWormholeReturnsSame [
    | board |
    board := Board withCells: 10 andWormholes: #().

    self assert: (board applyWormholeIfPresentAt: 5) equals: 5.

]

{ #category : 'tests - instance' }
BoardTest >> testWormholeTransportsCorrectly [
    | board |
    board := Board withCells: 20 andWormholes: (OrderedCollection withAll: {
        Wormhole from: 2 to: 10.
        Wormhole from: 10 to: 2.
    }).

    self assert: (board applyWormholeIfPresentAt: 2) equals: 10.
    self assert: (board applyWormholeIfPresentAt: 10) equals: 2.

]
