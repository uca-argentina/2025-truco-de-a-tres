Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effects' }
Card >> modifyRoll: aNumber forShip: aShip inGame: aGame [
	^ aNumber
]

{ #category : 'playing' }
Card >> playOn: aShip inGame: aGame [
	self subclassResponsibility
]
