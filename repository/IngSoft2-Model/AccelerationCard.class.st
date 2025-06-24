Class {
	#name : 'AccelerationCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AccelerationCard >> activateFor: aShip inGame: aGame [
	aShip addActiveCard: self.
]

{ #category : 'effects' }
AccelerationCard >> modifyRoll: aNumber forShip: aShip inGame: aGame [
	^ aNumber + 1
]
