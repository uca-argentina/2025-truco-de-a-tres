Class {
	#name : 'AtomicBombEffect',
	#superclass : 'EffectDecorator',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship [
	^ self

]

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship inContextOf: allSpaceships [
	allSpaceships do: [:ship | ship moveTo: 0 ].

]
