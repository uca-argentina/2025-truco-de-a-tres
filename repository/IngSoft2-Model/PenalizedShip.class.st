Class {
	#name : 'PenalizedShip',
	#superclass : 'Object',
	#instVars : [
		'ship',
		'turnsRemaining'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
PenalizedShip class >> for: aShip withTurns: aNumber [

	self validateTurns: aNumber.
	self validateShip: aShip.
	^ self new initializeFor: aShip withTurns: aNumber
]

{ #category : 'initialization' }
PenalizedShip class >> noPenaltyFor: aShip [

	self validateShip: aShip.
	^ self for: aShip withTurns: 0
]

{ #category : 'initialization' }
PenalizedShip class >> validateShip: aShip [

	(aShip isKindOf: Spaceship) ifFalse: [
		self error: 'Ship must be an instance of Spaceship' ]
]

{ #category : 'initialization' }
PenalizedShip class >> validateTurns: aNumber [

	(aNumber isInteger and: [ aNumber >= 0 ]) ifFalse: [
		self error: 'Turns must be a non-negative integer' ]
]

{ #category : 'initialize' }
PenalizedShip >> decreaseTurns [

	turnsRemaining := turnsRemaining - 1.
]

{ #category : 'testing' }
PenalizedShip >> hasPenalty [

	^ turnsRemaining > 0.
]

{ #category : 'initialize' }
PenalizedShip >> initializeFor: aShip withTurns: aNumber [

	ship := aShip.
	turnsRemaining := aNumber.
	
	^ self.
]

{ #category : 'accessing' }
PenalizedShip >> isFor: aShip [

	^ ship = aShip.
]

{ #category : 'accessing' }
PenalizedShip >> ship [

        ^ ship.
]

{ #category : 'accessing' }
PenalizedShip >> turnsRemaining [

        ^ turnsRemaining.
]

{ #category : 'accessing' }
PenalizedShip >> turnsRemaining: aNumber [
	turnsRemaining := aNumber.
]
