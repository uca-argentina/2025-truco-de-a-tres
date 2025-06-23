Class {
	#name : 'GameState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'enumerating' }
GameState >> whenFinishedDo: finishedBlock whenInProgressDo: inProgressBlock [
    self subclassResponsibility.
]
