Class {
	#name : 'DiceCup',
	#superclass : 'Object',
	#instVars : [
		'dice',
		'diceCup',
		'diceCollection'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initalize' }
DiceCup class >> with: someDice [

	^ super new initializeWith: someDice 
]

{ #category : 'accessing' }
DiceCup >> diceCollection [

	^ diceCollection
]

{ #category : 'initialize' }
DiceCup >> initializeWith: someDice [

	self validateMinimumDice: someDice.
	diceCollection := someDice
]

{ #category : 'process actions' }
DiceCup >> maxRoll [

	^ diceCollection sum: [ :die | die sides ]
]

{ #category : 'process actions' }
DiceCup >> normalRoll [

	^ diceCollection sum: [ :die | die roll ]
]

{ #category : 'validation' }
DiceCup >> validateMinimumDice: someDice [

	someDice ifNil: [
		self error: 'At least one die is required to initialize the game' ]
]
