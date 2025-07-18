Class {
	#name : 'OverloadCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'targetShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
OverloadCard class >> forShip: aShip [
	^ self new initializeForShip: aShip
]

{ #category : 'playing' }
OverloadCard >> activateFor: aShip inGame: aGame [

	targetShip addActiveCard: self
]

{ #category : 'initialization' }
OverloadCard >> initializeForShip: aShip [

	targetShip := aShip.
	^ self
]

{ #category : 'effects' }
OverloadCard >> modifyRoll: aNumber forShip: aShip inGame: aGame [

	aShip = targetShip ifTrue: [ ^ aNumber - 2 ].
	^ aNumber
]
