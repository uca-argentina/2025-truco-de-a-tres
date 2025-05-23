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
Die class >> new [
    self error: 'Use Die withSides: instead.'
]

{ #category : 'initialize' }
Die class >> withSides: aNumberOfSides [

	^ super new initializeWithSides: aNumberOfSides
]

{ #category : 'initialize' }
Die >> initializeWithSides: aNumberOfSides [ 
	(aNumberOfSides isInteger and: [aNumberOfSides >= 1]) ifFalse: [
        self error: 'Die must have at least one side.'
    ].
    sides := aNumberOfSides.
]

{ #category : 'initialize' }
Die >> roll [
	^ (1 to: (self sides)) atRandom.
]

{ #category : 'initialize' }
Die >> sides [
	^ sides.
]
