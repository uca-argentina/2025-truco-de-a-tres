Class {
	#name : 'DummyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DummyTest >> testOneSidedDieAlwaysReturnsOne [
	| dice result |
    dice := Die new initializeWithSides: 1.
    result := dice roll.
    
    self assert: result equals: 1.
]

{ #category : 'tests' }
DummyTest >> testRollReturnsValueWithinRange [
	| dice result |
    dice := Die new initializeWithSides: 6.
    result := dice roll.
    
    self assert: (result between: 1 and: 6)
]
