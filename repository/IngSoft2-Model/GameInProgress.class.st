Class {
	#name : 'GameInProgress',
	#superclass : 'GameState',
	#instVars : [
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'enumerating' }
GameInProgress >> whenFinishedDo: finishedBlock whenInProgressDo: inProgressBlock [
    ^ inProgressBlock value.
]
