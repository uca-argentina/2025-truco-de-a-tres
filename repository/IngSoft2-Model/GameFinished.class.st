Class {
	#name : 'GameFinished',
	#superclass : 'GameState',
	#instVars : [
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
GameFinished class >> withWinner: aShip [
    ^ self new initializeWithWinner: aShip.
]

{ #category : 'initialization' }
GameFinished >> initializeWithWinner: aShip [
    winner := aShip.
]

{ #category : 'initialization' }
GameFinished >> whenFinishedDo: finishedBlock whenInProgressDo: inProgressBlock [
    ^ finishedBlock value: winner.
]

{ #category : 'initialization' }
GameFinished >> winner [
    ^ winner.
]
