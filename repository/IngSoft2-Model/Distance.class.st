Class {
	#name : 'Distance',
	#superclass : 'Object',
	#instVars : [
		'value',
		'unit'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Distance class >> lightYears: aNumber [
    ^ self new initializeWith: aNumber unit: #lightYears
]

{ #category : 'instance creation' }
Distance class >> parsecs: aNumber [
    ^ self new initializeWith: aNumber unit: #parsecs
]

{ #category : 'accessing' }
Distance >> asLightYears [
    unit = #lightYears ifTrue: [ ^ value ].
    ^ value * 3
]

{ #category : 'accessing' }
Distance >> asParsecs [
    unit = #parsecs ifTrue: [ ^ value ].
    ^ value / 3
]

{ #category : 'initialization' }
Distance >> initializeWith: aNumber unit: aSymbol [
    value := aNumber.
    unit := aSymbol.
    ^ self
]

{ #category : 'accessing' }
Distance >> unit [
    ^ unit
]

{ #category : 'accessing' }
Distance >> value [
    ^ value
]
