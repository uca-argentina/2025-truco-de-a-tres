Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
PermanentCard >> activateFor: aShip inGame: aGame [
	self subclassResponsibility
]

{ #category : 'playing' }
PermanentCard >> playOn: aShip inGame: aGame [

	aGame currentShip = aShip
		ifTrue: [ self activateFor: aShip inGame: aGame ]
		ifFalse: [ self error: 'Not your turn' ]
]
