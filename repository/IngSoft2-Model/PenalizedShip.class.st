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

	^ self new initializeFor: aShip withTurns: aNumber.
]

{ #category : 'initialization' }
PenalizedShip class >> noPenaltyFor: aShip [
    ^ self for: aShip withTurns: 0.
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
