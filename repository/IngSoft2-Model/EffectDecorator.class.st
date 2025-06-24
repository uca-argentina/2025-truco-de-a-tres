Class {
	#name : 'EffectDecorator',
	#superclass : 'Object',
	#instVars : [
		'wrapped'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
EffectDecorator >> applyEffectTo: aShip inBoard: aBoard [
    "Subclasses implement specific behavior"
]

{ #category : 'instance creation' }
EffectDecorator >> applyTo: aShip [
    self applyEffectTo: aShip inBoard: nil.
    wrapped ifNotNil: [ wrapped applyTo: aShip ].
]

{ #category : 'instance creation' }
EffectDecorator >> applyTo: aShip inBoard: aBoard [
    self applyEffectTo: aShip inBoard: aBoard.
    wrapped ifNotNil: [ wrapped applyTo: aShip inBoard: aBoard ].
]

{ #category : 'instance creation' }
EffectDecorator >> decorate: anEffect [

    wrapped := anEffect.

    ^ self.
]

{ #category : 'instance creation' }
EffectDecorator >> wrapped [
	^ wrapped
]
