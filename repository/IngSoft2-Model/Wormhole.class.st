Class {
	#name : 'Wormhole',
	#superclass : 'Object',
	#instVars : [
		'positionA',
		'positionB',
		'entry',
		'exit'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'asserting' }
Wormhole class >> assertValidStateFrom: entry to: exit [

    (entry isInteger and: [ exit isInteger ]) ifFalse: [
        self error: 'Entry and exit must be integers'
    ].

    (entry > 0 and: [ exit > 0 ]) ifFalse: [
        self error: 'Entry and exit must be positive'
    ].

    entry = exit ifTrue: [
        self error: 'Wormhole cannot go to itself'
    ].
]

{ #category : 'initialize' }
Wormhole class >> connecting: aPosition and: anotherPosition [
	self validatePositionIsNotTheSame: aPosition and: anotherPosition.
	^ super new initializeConnecting: aPosition and: anotherPosition.
]

{ #category : 'initialize' }
Wormhole class >> from: entryPosition to: exitPosition [
	
	 self assertValidStateFrom: entryPosition to: exitPosition.
    ^ super new initializeFrom: entryPosition to: exitPosition.
]

{ #category : 'initialize' }
Wormhole class >> new [
    self error: 'Use Wormhole from:to: instead.'.
]

{ #category : 'initialize' }
Wormhole class >> validatePositionIsNotTheSame: aPosition and: anotherPosition [

	aPosition = anotherPosition ifTrue: [
		self error: 'Wormhole positions must be distinct'
	].
]

{ #category : 'validation' }
Wormhole >> exit [

    ^ exit.
]

{ #category : 'validation' }
Wormhole >> hasEntryAt: aPosition [

    ^ entry = aPosition.
]

{ #category : 'initialize' }
Wormhole >> initializeConnecting: aPosition and: anotherPosition [
	
	positionA := aPosition.
	positionB := anotherPosition.
	
]

{ #category : 'validation' }
Wormhole >> initializeFrom: entryPosition to: exitPosition [

    entry := entryPosition.
    exit := exitPosition.
]

{ #category : 'validation' }
Wormhole >> isValid [

	^ [
	  self class assertValidStateFrom: entry to: exit.
	  true ]
		  on: Error
		  do: [ false ]
]

{ #category : 'initialize' }
Wormhole >> positionA [

	^ positionA.
]

{ #category : 'initialize' }
Wormhole >> positionB [

	^ positionB.
]
