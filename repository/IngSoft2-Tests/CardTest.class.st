Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> testModifyRollReturnsSameNumber [
	| card result |
	card := Card new.
	result := card modifyRoll: 5 forShip: nil inGame: nil.
	self assert: result equals: 5.
]

{ #category : 'tests' }
CardTest >> testPlayOnRaisesSubclassResponsibilityError [
	self should: [ Card new playOn: nil inGame: nil ] raise: Error.
]
