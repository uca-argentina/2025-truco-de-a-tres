Class {
	#name : 'EffectDecorator',
	#superclass : 'Object',
	#instVars : [
		'wrapped'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
EffectDecorator >> applyTo: aShip [
    wrapped ifNotNil: [ wrapped applyTo: aShip ].
]

{ #category : 'instance creation' }
EffectDecorator >> decorate: anEffect [
    wrapped := anEffect.
    ^ self
]
