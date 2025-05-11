Class {
	#name : 'DummyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DummyTest >> testDieWithZeroSidesRaisesError [
	self should: [ Die new initializeWithSides: 0 ] raise: Error.
]

{ #category : 'tests' }
DummyTest >> testOneSidedDieAlwaysReturnsOne [
	| dice result |
    dice := Die new initializeWithSides: 1.
    result := dice roll.
    
    self assert: result equals: 1.
]

{ #category : 'tests' }
DummyTest >> testPositionWithoutWormholeReturnsSame [
	| board |
    board := Board new initializeWithCells: 10 wormholes: Dictionary new.
    
    self assert: (board applyWormholeIfPresentAt: 5) equals: 5.
]

{ #category : 'tests' }
DummyTest >> testRollReturnsValueWithinRange [
	| dice result |
    dice := Die new initializeWithSides: 6.
    result := dice roll.
    
    self assert: (result between: 1 and: 6)
]
