Class {
	#name : 'HyperGravityEffect',
	#superclass : 'Effect',
	#instVars : [
		'requiredRoll'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperGravityEffect >> allowsEntryWithRoll: aNumber [
	^ aNumber >= requiredRoll
]

{ #category : 'operations' }
HyperGravityEffect >> applyTo: aSpaceship inGame: aGame [
	"HyperGravityEffect only restricts entry; it does nothing on apply"
	^ self

]

{ #category : 'initialization' }
HyperGravityEffect >> initialize [
	super initialize.
	requiredRoll := 4. "Podés ajustarlo o parametrizarlo después"
]

{ #category : 'initialization' }
HyperGravityEffect >> requiredRoll [
	^ requiredRoll

]

{ #category : 'initialization' }
HyperGravityEffect >> requiredRoll: aNumber [
	requiredRoll := aNumber.

]
