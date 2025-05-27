Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'position',
		'playerName',
		'penaltyTurns',
		'maxFuel',
		'fuel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Spaceship class >> new [
    self error: 'Use Spaceship withName: instead.'
]

{ #category : 'initialize' }
Spaceship class >> withName: aName and: aMaxRoll [

	^ super new initializeWith: aName and: aMaxRoll 
]

{ #category : 'initialize' }
Spaceship >> hasReachedGoalOn: aBoard [
    ^ aBoard isGoalReachedAt: position

]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName and: aMaxRoll [

	aName isEmpty ifTrue: [ self error: 'Name cannot be empty' ].

	playerName := aName.
	position := 0.
	maxFuel := aMaxRoll * 2.
	fuel := maxFuel.

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
