Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'side',
		'dado',
		'sides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Die >> initializeWithSides: aNumberOfSides [ 
	sides:= aNumberOfSides.
]

{ #category : 'initialize' }
Die >> roll [
	^ (1 to: (self sides)) atRandom.
]

{ #category : 'initialize' }
Die >> sides [
	^ sides.
]
