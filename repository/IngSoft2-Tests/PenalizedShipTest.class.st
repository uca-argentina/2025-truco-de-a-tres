Class {
        #name : 'PenalizedShipStateTest',
        #superclass : 'TestCase',
        #category : 'IngSoft2-Tests',
        #package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PenalizedShipStateTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: error messageText equals: errorMessage ].
]

{ #category : 'tests' }
PenalizedShipStateTest >> testDecreaseTurn [

    | penalized |

    penalized := PenalizedShipState forTurns: 2.
    penalized decreaseTurns.
    penalized decreaseTurns.

    self deny: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipStateTest >> testInitializationWithPenalty [

    | penalized |

    penalized := PenalizedShipState forTurns: 3.

    self assert: (penalized hasPenalty).
    self assert: penalized turnsRemaining equals: 3.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testInitializationWithoutPenalty [

    | penalized |

    penalized := PenalizedShipState forTurns: 0.

    self deny: (penalized hasPenalty).
    self assert: penalized turnsRemaining equals: 0.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testReducePenaltyTransitionsToNormalState [

    | penalized newState |

    penalized := PenalizedShipState forTurns: 1.
    newState := penalized reducePenalty.

    self assert: newState class equals: NormalShipState.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testPenalizeForSetsTurns [

    | penalized |

    penalized := PenalizedShipState forTurns: 1.
    penalized penalizeFor: 5.

    self assert: penalized turnsRemaining equals: 5.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testTurnsRemainingAccessor [

    | penalized |

    penalized := PenalizedShipState forTurns: 3.

    self assert: penalized turnsRemaining equals: 3.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testTurnsRemainingSetter [
    | penalized |

    penalized := PenalizedShipState forTurns: 1.
    penalized turnsRemaining: 5.

    self assert: penalized turnsRemaining equals: 5.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testWhenPenalizedDoEvaluatesPenalizedBlock [

    | penalized executed |

    executed := false.
    penalized := PenalizedShipState forTurns: 1.
    penalized
        whenPenalizedDo: [ executed := true ]
        whenNormalDo: [ executed := false ].

    self assert: executed.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testIsPenalizedReturnsTrue [

    | penalized |

    penalized := PenalizedShipState forTurns: 1.

    self assert: penalized isPenalized.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testReducePenaltyReturnsSelfWhenStillPenalized [

    | penalized newState |

    penalized := PenalizedShipState forTurns: 2.
    newState := penalized reducePenalty.

    self assert: newState == penalized.
    self assert: penalized turnsRemaining equals: 1.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testForTurnsRaisesErrorWhenInvalid [

    self
        should: [ PenalizedShipState forTurns: -1 ]
        raise: Error
        withMessageText: 'Turns must be a non-negative integer'.
    self
        should: [ PenalizedShipState forTurns: 'a' ]
        raise: Error
        withMessageText: 'Turns must be a non-negative integer'.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testPenalizeForRaisesErrorWhenInvalid [

    | penalized |

    penalized := PenalizedShipState forTurns: 1.

    self
        should: [ penalized penalizeFor: -2 ]
        raise: Error
        withMessageText: 'Turns must be a non-negative integer'.
    self
        should: [ penalized penalizeFor: 'b' ]
        raise: Error
        withMessageText: 'Turns must be a non-negative integer'.
]
