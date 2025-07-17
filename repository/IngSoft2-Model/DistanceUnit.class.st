Class {
    #name : 'DistanceUnit',
    #superclass : 'Object',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'conversions' }
DistanceUnit >> asLightYears: aNumber [
    self subclassResponsibility
]

{ #category : 'conversions' }
DistanceUnit >> asParsecs: aNumber [
    self subclassResponsibility
]
