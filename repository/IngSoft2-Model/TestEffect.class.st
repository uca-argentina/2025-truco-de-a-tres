Class {
	#name : 'TestEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
TestEffect >> applyTo: aSpaceship [
    aSpaceship incrementLap.
]
