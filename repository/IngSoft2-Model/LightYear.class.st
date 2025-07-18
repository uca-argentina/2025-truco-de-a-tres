Class {
	#name : 'LightYear',
	#superclass : 'DistanceUnit',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'conversions' }
LightYear >> asLightYears: aNumber [
    ^ aNumber
]

{ #category : 'conversions' }
LightYear >> asParsecs: aNumber [
    ^ aNumber / Parsec lightYearsPerParsec
]
