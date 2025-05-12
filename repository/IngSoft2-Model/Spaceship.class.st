Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'position',
		'playerName'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Spaceship >> advanceWith: aDie on: aBoard [
    | steps newPosition |
    steps := aDie roll.
    newPosition := aBoard newPositionFrom: position steps: steps.
    self moveTo: newPosition.

]

{ #category : 'instance creation' }
Spaceship >> hasReachedGoalOn: aBoard [
    ^ aBoard isGoalReachedAt: position

]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName [

	aName isEmpty ifTrue: [ self error: 'El nombre no puede estar vacío' ].

	playerName := aName.
	position := 0
]

{ #category : 'instance creation' }
Spaceship >> moveTo: aPosition [
    position := aPosition

]

{ #category : 'instance creation' }
Spaceship >> playerName [
    ^ playerName
]

{ #category : 'instance creation' }
Spaceship >> position [
    ^ position
]
