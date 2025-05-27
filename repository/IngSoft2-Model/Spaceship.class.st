Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'position',
		'playerName',
		'penaltyTurns',
		'lap'
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
	position := 0.
	lap := 0.

]

{ #category : 'initialize' }
Spaceship >> lap [
	^ lap

]

{ #category : 'initialize' }
Spaceship >> moveBack: steps [
    position := (position - steps) max: 0.

]

{ #category : 'initialize' }
Spaceship >> moveForward: steps [
	position := position + steps.

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

{ #category : 'as yet unclassified' }
Spaceship >> restoreFuel [
]
