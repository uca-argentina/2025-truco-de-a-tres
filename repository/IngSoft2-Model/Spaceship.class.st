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

{ #category : 'initialize' }
Spaceship class >> new [
    self error: 'Use Spaceship withName: instead.'
]

{ #category : 'initialize' }
Spaceship class >> withName: aName [

	^ super new initializeWith: aName
]

{ #category : 'initialize' }
Spaceship >> hasReachedGoalOn: aBoard [
    ^ aBoard isGoalReachedAt: position

]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName [

	aName isEmpty ifTrue: [ self error: 'Name cannot be empty' ].

	playerName := aName.
	position := 0

]

{ #category : 'initialize' }
Spaceship >> moveTo: aPosition [
    position := aPosition

]

{ #category : 'initialize' }
Spaceship >> playerName [
    ^ playerName
]

{ #category : 'initialize' }
Spaceship >> position [
    ^ position
]
