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
