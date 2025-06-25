Class {
	#name : 'RepeatCardTestGame',
	#superclass : 'Object',
	#instVars : [
		'receivedShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
RepeatCardTestGame >> receivedShip [
    ^ receivedShip
]

{ #category : 'testing' }
RepeatCardTestGame >> repeatLastEffectOn: aShip [
    receivedShip := aShip.
]

{ #category : 'testing' }
RepeatCardTestGame >> whenFinishedDo: finishedBlock whenInProgressDo: inProgressBlock [
    ^ inProgressBlock value
]
