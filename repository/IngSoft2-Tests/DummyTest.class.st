Class {
	#name : 'DummyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DummyTest >> testDummy [

	self assert: Dummy new isDummy
]

{ #category : 'tests' }
DummyTest >> testDummy2 [

	self assert: Dummy new isDummy
]

{ #category : 'tests' }
DummyTest >> testDummy3 [

	self assert: Dummy new isDummy
]

{ #category : 'tests' }
DummyTest >> testRollReturnsValueWithinRange [
	| dice result |
    dice := Dice new initializeWithSides: 6.
    result := dice roll.
    
    self assert: (result between: 1 and: 6)
]
