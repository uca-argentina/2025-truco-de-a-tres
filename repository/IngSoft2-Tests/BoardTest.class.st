Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
BoardTest >> testIsGoalReached [
    | board |
    board := Board withCells: 10 andWormholes: #().

    self assert: (board isGoalReachedAt: 10).
    self assert: (board isGoalReachedAt: 11).
    self deny: (board isGoalReachedAt: 9).

]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithWormhole [
    | board |
    board := Board withCells: 25 andWormholes: (OrderedCollection with: (Wormhole from: 6 to: 20)).

    self assert: (board newPositionFrom: 2 steps: 4) equals: 20.

]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithoutWormhole [
    | board |
    board := Board withCells: 25 andWormholes: #().

    self assert: (board newPositionFrom: 2 steps: 2) equals: 4.

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
