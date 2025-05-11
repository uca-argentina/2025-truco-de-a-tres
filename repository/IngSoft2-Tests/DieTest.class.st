Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
DieTest >> testDieWithZeroSidesRaisesError [
	self should: [ Die new initializeWithSides: 0 ] raise: Error.

]

{ #category : 'tests - instance' }
DieTest >> testOneSidedDieAlwaysReturnsOne [
	| dice result |
	dice := Die new initializeWithSides: 1.
	result := dice roll.

	self assert: result equals: 1.

]

{ #category : 'tests - instance' }
DieTest >> testRollReturnsValueWithinRange [
	| dice result |
	dice := Die new initializeWithSides: 6.
	result := dice roll.

	self assert: (result between: 1 and: 6).

]
