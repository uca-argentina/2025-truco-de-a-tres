Class {
	#name : 'MockInstantCard',
	#superclass : 'InstantCard',
	#instVars : [
		'applied'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
MockInstantCard >> applied [
    ^ applied
]

{ #category : 'playing' }
MockInstantCard >> applyEffectTo: aShip inGame: aGame [
    applied := true.
]
