Class {
	#name : 'RepeatCardTestGame',
	#superclass : 'Object',
	#instVars : [
		'receivedShip'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
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
