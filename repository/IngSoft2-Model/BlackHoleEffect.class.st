Class {
	#name : 'BlackHoleEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
BlackHoleEffect >> applyTo: aSpaceship [
    aSpaceship moveBack: 4.

]
