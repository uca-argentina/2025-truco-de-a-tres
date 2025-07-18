Class {
	#name : 'PenalizedShipState',
	#superclass : 'ShipState',
	#instVars : [
		'turnsRemaining'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
PenalizedShipState class >> forTurns: aNumber [
    self validateTurns: aNumber.
    ^ self new initializeForTurns: aNumber.
]

{ #category : 'initialization' }
PenalizedShipState class >> validateTurns: aNumber [
    (aNumber isInteger and: [ aNumber >= 0 ]) ifFalse: [
        self error: 'Turns must be a non-negative integer' ].
]

{ #category : 'penalty' }
PenalizedShipState >> decreaseTurns [

	turnsRemaining := turnsRemaining - 1
]

{ #category : 'penalty' }
PenalizedShipState >> hasPenalty [

	^ turnsRemaining > 0
]

{ #category : 'initialization' }
PenalizedShipState >> initializeForTurns: aNumber [

	turnsRemaining := aNumber.
	^ self
]

{ #category : 'penalty' }
PenalizedShipState >> isPenalized [

	^ true
]

{ #category : 'penalty' }
PenalizedShipState >> penalizeFor: aNumber [

	self class validateTurns: aNumber.
	turnsRemaining := aNumber.
	^ self
]

{ #category : 'penalty' }
PenalizedShipState >> reducePenalty [
    self decreaseTurns.
    ^ self hasPenalty
        ifTrue: [ self ]
        ifFalse: [ NormalShipState new ].
]

{ #category : 'penalty' }
PenalizedShipState >> turnsRemaining [

	^ turnsRemaining
]

{ #category : 'penalty' }
PenalizedShipState >> turnsRemaining: aNumber [

	turnsRemaining := aNumber
]

{ #category : 'enumerating' }
PenalizedShipState >> whenPenalizedDo: penalizedBlock whenNormalDo: normalBlock [

	^ penalizedBlock value
]

{ #category : 'enumerating' }
PenalizedShipState >> whenPenalizedDo: penalizedBlock whenNormalDo: normalBlock [
    ^ penalizedBlock value.
]
