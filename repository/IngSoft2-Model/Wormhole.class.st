Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'positionA',
		'positionB'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Wormhole class >> connecting: aPosition and: anotherPosition [

	^ self new initializeConnecting: aPosition and: anotherPosition
]

{ #category : 'initialize' }
Wormhole >> initializeConnecting: aPosition and: anotherPosition [

	self validatePositionIsNotTheSame: aPosition and: anotherPosition.
	positionA := aPosition.
	positionB := anotherPosition.
	
]

{ #category : 'initialize' }
Wormhole >> positionA [

	^ positionA
]

{ #category : 'initialize' }
Wormhole >> positionB [

	^ positionB
]

{ #category : 'validation' }
Wormhole >> validatePositionIsNotTheSame: aPosition and: anotherPosition [

	aPosition = anotherPosition ifTrue: [
		self error: 'Wormhole positions must be distinct' ]
]
