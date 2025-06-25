Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
RepeatCard >> applyEffectTo: aShip inGame: aGame [
	aGame repeatLastEffectOn: aShip
]
