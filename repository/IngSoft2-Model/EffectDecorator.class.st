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
    | board |
    board := NullBoard new.
    self applyEffectTo: aShip inBoard: board.
    wrapped ifNotNil: [ wrapped applyTo: aShip inBoard: board ].
]

{ #category : 'instance creation' }
EffectDecorator >> applyTo: aShip inBoard: aBoard [
    | board |
    board := aBoard ifNil: [ NullBoard new ] ifNotNil: [ aBoard ].
    self applyEffectTo: aShip inBoard: board.
    wrapped ifNotNil: [ wrapped applyTo: aShip inBoard: board ].
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
