Class {
	#name : 'DiceCup',
	#superclass : 'Object',
	#instVars : [

		'diceCollection'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}


{ #category : 'validation' }
DiceCup class >> validateMinimumDice: someDice [


	(someDice isCollection and: [ someDice notEmpty ]) ifFalse: [
		self error: 'At least one die is required to initialize the game' ].

	"someDice ifNil: [
		self error: 'At least one die is required to initialize the game' ]"
]

{ #category : 'initalize' }
DiceCup class >> with: someDice [

	self validateMinimumDice: someDice.
	
	^ self new initializeWith: someDice 

]

{ #category : 'initialize' }
DiceCup >> initializeWith: someDice [


	diceCollection := someDice
]

{ #category : 'process actions' }
DiceCup >> maxRoll [

	^ diceCollection sum: [ :die | die sides ]
]

{ #category : 'process actions' }

DiceCup >> roll [

	^ diceCollection sum: [ :die | die roll ]
]

