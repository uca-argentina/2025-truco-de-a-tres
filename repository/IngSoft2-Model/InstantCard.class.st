Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
InstantCard >> applyEffectTo: aShip inGame: aGame [

	self subclassResponsibility
]

{ #category : 'playing' }
InstantCard >> playOn: aShip inGame: aGame [

	self applyEffectTo: aShip inGame: aGame
]
