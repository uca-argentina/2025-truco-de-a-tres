Class {
	#name : 'MoonWalkEffect',
	#superclass : 'EffectDecorator',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
MoonWalkEffect >> applyTo: aSpaceship [

	"By default, this does nothing. Real logic is in applyTo:inContextOf:"
	^ self.

]

{ #category : 'operations' }
MoonWalkEffect >> applyTo: aSpaceship inContextOf: allSpaceships [

	allSpaceships do: [:ship | ship = aSpaceship ifFalse: [ ship moveBack: 2 ]].
]
