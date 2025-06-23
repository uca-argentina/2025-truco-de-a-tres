Class {
	#name : 'HyperJumpEffect',
	#superclass : 'EffectDecorator',
	#instVars : [
		'jumpValues',
		'currentIndex'
	],
	#classVars : [
		'CurrentIndex',
		'JumpValues'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJumpEffect class >> withValues: aCollection [
    ^ self new
        initializeWith: aCollection;
        yourself.
]

{ #category : 'operations' }
HyperJumpEffect >> allowsEntryWithRoll: aRoll [
	^ true.
]

{ #category : 'operations' }
HyperJumpEffect >> applyTo: aSpaceship [
    self error: 'Use applyTo:inBoard: instead.'
]

{ #category : 'operations' }
HyperJumpEffect >> applyTo: aSpaceship inBoard: aBoard [
    | parsecs steps |
    parsecs := self nextJumpValue.
    steps := aBoard stepsFromParsecs: parsecs.
    aSpaceship moveForward: steps.
]

{ #category : 'operations' }
HyperJumpEffect >> initializeWith: aCollection [
    jumpValues := aCollection.
    currentIndex := 1.
]

{ #category : 'operations' }
HyperJumpEffect >> nextJumpValue [

	| value |
	
	value := jumpValues at: currentIndex.
	
	currentIndex := (currentIndex \\ jumpValues size) + 1.
	
	^ value.
]

{ #category : 'operations' }
HyperJumpEffect >> peekJumpValue [
    ^ jumpValues at: currentIndex.
]

{ #category : 'operations' }
HyperJumpEffect >> resetJumpIndex [

	currentIndex := 1.
]
