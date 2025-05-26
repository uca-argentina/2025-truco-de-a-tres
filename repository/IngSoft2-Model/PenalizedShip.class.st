Class {
	#name : 'PenalizedShip',
	#superclass : 'Object',
	#instVars : [
		'ship',
		'turnsRemaining',
		'penalizedShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
PenalizedShip class >> for: aShip withTurns: aNumber [
^self new initializeFor: aShip withTurns: aNumber.
]

{ #category : 'as yet unclassified' }
PenalizedShip class >> noPenaltyFor: aShip [
    ^ self for: aShip withTurns: 0.
]

{ #category : 'testing' }
PenalizedShip >> hasPenalty [
	^ turnsRemaining > 0
]

{ #category : 'initialize' }
PenalizedShip >> initializeFor: aShip withTurns: aNumber [

	ship := aShip.
	turnsRemaining := aNumber.
	^self
]

{ #category : 'accessing' }
PenalizedShip >> isFor: aShip [

	^ ship = aShip
]

{ #category : 'process actions' }
PenalizedShip >> reduceTurn [

	turnsRemaining := turnsRemaining - 1
]

{ #category : 'accessing' }
PenalizedShip >> ship [

	^ ship
]
