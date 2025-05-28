Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'position',
		'playerName',
		'penaltyTurns',
		'maxFuel',
		'fuel',
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
Spaceship class >> withName: aName and: aMaxRoll [

	^ super new initializeWith: aName and: aMaxRoll 
]

{ #category : 'process actions' }
Spaceship >> consumeFuel: amount [

	fuel := fuel - amount max: 0
]

{ #category : 'accessing' }
Spaceship >> fuel [

	^ fuel
]

{ #category : 'process actions' }
Spaceship >> hasFuelFor: steps [
    ^ fuel >= steps
]

{ #category : 'initialize' }
Spaceship >> hasReachedGoalOn: aBoard [
    ^ aBoard isGoalReachedAt: position

]

{ #category : 'initialize' }
Spaceship >> incrementLap [
	lap := lap + 1.
]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName and: aMaxRoll [

	aName isEmpty ifTrue: [ self error: 'Name cannot be empty' ].

	playerName := aName.
	position := 0.
	maxFuel := aMaxRoll * 2.
	fuel := maxFuel.
	lap := 0
]

{ #category : 'initialize' }
Spaceship >> lap [
	^ lap

]

{ #category : 'initialize' }
Spaceship >> moveBack: steps [

	| newPosition distance |
	newPosition := position - steps max: 0.
	distance := (position - newPosition) abs.
	self consumeFuel: distance.
	position := newPosition
]

{ #category : 'initialize' }
Spaceship >> moveForward: steps [

	| newPosition distance |
	newPosition := position + steps.
	distance := (newPosition - position) abs.
	self consumeFuel: distance.
	position := newPosition
]

{ #category : 'initialize' }
Spaceship >> moveTo: aPosition [

	| distance |
	distance := (aPosition - position) abs. "abs hace que devuelva el valor absoluto"
	self consumeFuel: distance.
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

{ #category : 'process actions' }
Spaceship >> resetPosition [
    position := 0.
]

{ #category : 'process actions' }
Spaceship >> restoreFuel [
    fuel := maxFuel.

]
