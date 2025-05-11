Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> testPositionWithoutWormholeReturnsSame [
	| board |
	board := Board new initializeWithCells: 10 wormholes: Dictionary new.

	self assert: (board applyWormholeIfPresentAt: 5) equals: 5.

]

{ #category : 'tests' }
BoardTest >> testWormholeTransportsCorrectly [
    | board wormholes |
    wormholes := Dictionary new.
    wormholes at: 2 put: 10; at: 10 put: 2.
    board := Board new initializeWithCells: 20 wormholes: wormholes.
    
    self assert: (board applyWormholeIfPresentAt: 2) equals: 10.
    self assert: (board applyWormholeIfPresentAt: 10) equals: 2.
]
