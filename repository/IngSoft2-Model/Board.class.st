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
Board >> initializeWithCells: aCount wormholes: aDictionary [
	cellCount := aCount.
   wormholes := aDictionary.
]

{ #category : 'initialize' }
Board >> isGoalReachedAt: aPosition [
    ^ aPosition >= cellCount
]
