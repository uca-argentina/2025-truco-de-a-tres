Class {
	#name : 'DistanceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
DistanceTest >> testAsLightYearsFromLightYearsReturnsValue [
    | distance |
    distance := Distance lightYears: 5.
    self assert: distance asLightYears equals: 5.
]

{ #category : 'tests - instance' }
DistanceTest >> testAsLightYearsFromParsecsConvertsValue [
    | distance |
    distance := Distance parsecs: 2.
    self assert: distance asLightYears equals: 6.
]

{ #category : 'tests - instance' }
DistanceTest >> testAsParsecsFromLightYearsConvertsValue [
    | distance |
    distance := Distance lightYears: 6.
    self assert: distance asParsecs equals: 2.
]

{ #category : 'tests - instance' }
DistanceTest >> testAsParsecsFromParsecsReturnsValue [
    | distance |
    distance := Distance parsecs: 4.
    self assert: distance asParsecs equals: 4.
]

{ #category : 'tests - instance' }
DistanceTest >> testInitializationSetsValueAndUnit [
    | distance |
    distance := Distance new initializeWith: 7 unit: Parsec new.
    self assert: distance value equals: 7.
    self assert: distance unit class equals: Parsec.
]

{ #category : 'tests - instance' }
DistanceTest >> testLightYearsClassMethodCreatesLightYearsDistance [
    | distance |
    distance := Distance lightYears: 3.
    self assert: distance value equals: 3.
    self assert: distance unit class equals: LightYear.
]

{ #category : 'tests - instance' }
DistanceTest >> testParsecsClassMethodCreatesParsecsDistance [
    | distance |
    distance := Distance parsecs: 8.
    self assert: distance value equals: 8.
    self assert: distance unit class equals: Parsec.
]
