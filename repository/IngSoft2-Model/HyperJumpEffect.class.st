Class {
	#name : 'HyperJumpEffect',
	#superclass : 'Effect',
	#classVars : [
		'CurrentIndex',
		'JumpValues'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'class initialization' }
HyperJumpEffect class >> initialize [
	JumpValues := #(3 5 2 4).
	CurrentIndex := 1.
]

{ #category : 'class initialization' }
HyperJumpEffect class >> nextJumpValue [
	| value |
	value := JumpValues at: CurrentIndex.
	CurrentIndex := (CurrentIndex \\ JumpValues size) + 1.
	^ value
]

{ #category : 'class initialization' }
HyperJumpEffect class >> resetJumpIndex [
	CurrentIndex := 1.
]

{ #category : 'operations' }
HyperJumpEffect >> allowsEntryWithRoll: aRoll [
	^ true.
]

{ #category : 'operations' }
HyperJumpEffect >> applyTo: aSpaceship [
	aSpaceship moveForward: 3.
]

{ #category : 'operations' }
HyperJumpEffect >> applyTo: aSpaceship inGame: aGame [
    | jumpValue requiredFuel |
    jumpValue := 3.
    requiredFuel := jumpValue.
    
    (aSpaceship hasFuelFor: requiredFuel)
        ifTrue: [ 
            aSpaceship moveForward: jumpValue 
        ]
        ifFalse: [ 
            aSpaceship resetPosition.
            aGame penalize: aSpaceship forTurns: 2.
        ]
]
