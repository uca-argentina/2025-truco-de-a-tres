Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
DieTest >> testDieSidesReturnsCorrectValue [
    | die |

    die := Die withSides: 6.
    
    self assert: die sides equals: 6.
]

{ #category : 'tests - instance' }
DieTest >> testDieWithZeroSidesRaisesError [
	self should: [ Die withSides: 0 ] raise: Error.

]

{ #category : 'tests - instance' }
DieTest >> testOneSidedDieAlwaysReturnsOne [
	| dice result |
	dice := Die withSides: 1.
	result := dice roll.

	self assert: result equals: 1.

]

{ #category : 'tests - instance' }
DieTest >> testRollReturnsValueWithinRange [
	| dice result |
	dice := Die withSides: 6.
	result := dice roll.

	self assert: (result between: 1 and: 6).

]
