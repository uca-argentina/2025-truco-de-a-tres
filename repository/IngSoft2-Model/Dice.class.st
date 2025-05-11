Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'side',
		'dado'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Dice >> initializeWith: aSide [ 
	side:= aSide.
]

{ #category : 'initialize' }
Dice >> side [
	^ side .
]

{ #category : 'instance creation' }
Dice >> throwTheDice [
	^ (1 to: (self side)) atRandom.
]
