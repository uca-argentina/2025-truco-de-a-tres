Class {
    #name : 'Parsec',
    #superclass : 'DistanceUnit',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'conversions' }
Parsec >> asLightYears: aNumber [
    ^ aNumber * 3
]

{ #category : 'conversions' }
Parsec >> asParsecs: aNumber [
    ^ aNumber
]
