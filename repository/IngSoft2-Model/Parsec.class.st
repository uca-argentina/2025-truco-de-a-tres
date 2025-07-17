Class {
    #name : 'Parsec',
    #superclass : 'DistanceUnit',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'conversions' }
Parsec >> asLightYears: aNumber [
    ^ aNumber * Parsec lightYearsPerParsec
]

{ #category : 'conversions' }
Parsec >> asParsecs: aNumber [
    ^ aNumber
]

{ #category : 'constants' }
Parsec class >> lightYearsPerParsec [
    ^ 3
]
