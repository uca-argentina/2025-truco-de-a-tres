Class {
	#name : 'Dice',
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
Dice >> initializeWith: aSide [ 
	side:= aSide.
]

{ #category : 'initialize' }
Dice >> initializeWithSides: aNumberOfSides [ 
	sides:= aNumberOfSides.
]

{ #category : 'initialize' }
Dice >> roll [
	^ (1 to: (self sides)) atRandom.
]

{ #category : 'initialize' }
Dice >> side [
	^ side .
]

{ #category : 'initialize' }
Dice >> sides [
	^ sides.
]

{ #category : 'instance creation' }
Dice >> throwTheDice [
	^ (1 to: (self side)) atRandom.
]
