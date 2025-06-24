Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'playerName',
		'maxFuel',
		'fuel',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Spaceship class >> withName: aName [

	^ self new initializeWith: aName.
]

{ #category : 'initialize' }
Spaceship >> hasReachedGoalOn: aBoard [

    ^ aBoard isGoalReachedAt: position.

]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName [

	aName isEmpty ifTrue: [ self error: 'Name cannot be empty' ].

	playerName := aName.
	position := 0.
	fuel := 0.
  	maxFuel := 0.
	lap := 0.
]

{ #category : 'initialize' }
Spaceship >> lap [

	^ lap.

]

{ #category : 'methods' }
Spaceship >> moveBack: steps [

    position := (position - steps) max: 0.

]

{ #category : 'methods' }
Spaceship >> moveForward: steps [

	position := position + steps.

]

{ #category : 'methods' }
Spaceship >> moveTo: aPosition [

    position := aPosition.

]

{ #category : 'initialize' }
Spaceship >> position [

    ^ position.
]

{ #category : 'accessing' }
Spaceship >> name [
    ^ playerName.
]

{ #category : 'methods' }
Spaceship >> restoreFuel [
	
	fuel := maxFuel.
]
