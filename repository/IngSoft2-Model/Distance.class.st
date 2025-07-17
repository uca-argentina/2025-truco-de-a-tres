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
    ^ self new initializeWith: aNumber unit: LightYear new
]

{ #category : 'instance creation' }
Distance class >> parsecs: aNumber [
    ^ self new initializeWith: aNumber unit: Parsec new
]

{ #category : 'accessing' }
Distance >> asLightYears [
    ^ unit asLightYears: value
]

{ #category : 'accessing' }
Distance >> asParsecs [
    ^ unit asParsecs: value
]

{ #category : 'initialization' }
Distance >> initializeWith: aNumber unit: aUnit [
    value := aNumber.
    unit := aUnit.
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
