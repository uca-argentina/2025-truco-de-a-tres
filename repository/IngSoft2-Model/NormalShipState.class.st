Class {
	#name : 'NormalShipState',
	#superclass : 'ShipState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'penalty' }
NormalShipState >> isPenalized [
    ^ false.
]

{ #category : 'penalty' }
NormalShipState >> penalizeFor: aNumber [
    ^ PenalizedShipState forTurns: aNumber.
]

{ #category : 'penalty' }
NormalShipState >> reducePenalty [
    ^ self.
]

{ #category : 'penalty' }
NormalShipState >> turnsRemaining [
    ^ 0.
]

{ #category : 'enumerating' }
NormalShipState >> whenPenalizedDo: penalizedBlock whenNormalDo: normalBlock [
    ^ normalBlock value.
]
