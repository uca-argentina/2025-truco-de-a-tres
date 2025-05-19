Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WormholeTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage].
	


]

{ #category : 'tests - instance' }
WormholeTest >> testInvalidWormholeCreation [

	self
		should: [ Wormhole connecting: 7 and: 7]
		raise: Error 
		withMessageText: 'Wormhole positions must be distinct'.
]

{ #category : 'tests - instance' }
WormholeTest >> testValidWormholeCreation [

	| wormhole |
	wormhole := Wormhole connecting: 5 and: 10.

	self assert: wormhole positionA equals: 5.
	self assert: wormhole positionB equals: 10.
]
