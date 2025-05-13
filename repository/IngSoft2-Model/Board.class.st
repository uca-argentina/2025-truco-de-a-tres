Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'cellCount',
		'wormholes'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Board >> applyWormholeIfPresentAt: aPosition [
	^ wormholes at: aPosition ifAbsent: [aPosition]
]

{ #category : 'initialize' }
Board >> cellCount [
    ^ cellCount
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount wormholes: aDictionary [
	cellCount := aCount.
   wormholes := aDictionary.
]

{ #category : 'initialize' }
Board >> isGoalReachedAt: aPosition [
    ^ aPosition >= cellCount
]

{ #category : 'initialize' }
Board >> newPositionFrom: aPosition steps: steps [
	| tentativePosition finalPosition |
	tentativePosition := aPosition + steps.
	finalPosition := self applyWormholeIfPresentAt: tentativePosition.
	^ finalPosition

]

{ #category : 'initialize' }
Board >> wormholes [
	^ wormholes
]
