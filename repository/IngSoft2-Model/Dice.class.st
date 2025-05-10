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
Dice >> initialize [ 
	dado:= 6.
]

{ #category : 'initialize' }
Dice >> side [
	^ 6.
]

{ #category : 'instance creation' }
Dice >> throwTheDice [

	^ (1 to: (self side)) atRandom.
]
