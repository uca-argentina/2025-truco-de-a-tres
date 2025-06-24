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
	aGame whenFinishedDo: [ :winner | self error: 'Game is already over' ] whenInProgressDo: [
        self applyEffectTo: aShip inGame: aGame
    ].
]
