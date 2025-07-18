Class {
    #name : 'NormalShipStateTest',
    #superclass : 'TestCase',
    #category : 'IngSoft2-Tests',
    #package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
NormalShipStateTest >> testIsPenalizedReturnsFalse [
    | state |
    state := NormalShipState new.
    self deny: (state isPenalized).
]

{ #category : 'tests' }
NormalShipStateTest >> testPenalizeForReturnsPenalizedState [
    | state penalized |
    state := NormalShipState new.
    penalized := state penalizeFor: 3.
    self assert: penalized class equals: PenalizedShipState.
    self assert: penalized turnsRemaining equals: 3.
]

{ #category : 'tests' }
NormalShipStateTest >> testReducePenaltyReturnsSelf [
    | state |
    state := NormalShipState new.
    self assert: (state reducePenalty) == state.
]

{ #category : 'tests' }
NormalShipStateTest >> testTurnsRemainingIsZero [
    | state |
    state := NormalShipState new.
    self assert: state turnsRemaining equals: 0.
]

{ #category : 'tests' }
NormalShipStateTest >> testWhenPenalizedDoWhenNormalDoExecutesNormalBlock [
    | state flag result |
    state := NormalShipState new.
    flag := false.
    result := state
        whenPenalizedDo: [ flag := true ]
        whenNormalDo: [ 42 ].
    self assert: result equals: 42.
    self deny: flag.
]
