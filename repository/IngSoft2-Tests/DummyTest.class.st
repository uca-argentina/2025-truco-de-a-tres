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
DummyTest >> testRollReturnsValueWithinRange [
	| die result |
    die := Die new initializeWithSides: 6.
    result := die roll.
    
    self assert: (result between: 1 and: 6)
]
