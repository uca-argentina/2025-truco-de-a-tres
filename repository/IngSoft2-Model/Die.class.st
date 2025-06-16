Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'sides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Die class >> withSides: aNumberOfSides [

	(aNumberOfSides isInteger and: [ aNumberOfSides >= 1 ]) ifFalse: [
		self error: 'Die must have at least one side.' ].

	^ self new initializeWithSides: aNumberOfSides
]

{ #category : 'initialize' }
Die >> initializeWithSides: aNumberOfSides [ 

    sides := aNumberOfSides.
]

{ #category : 'method' }
Die >> roll [

	^ sides atRandom
]

{ #category : 'initialize' }
Die >> sides [

	^ sides
]
