Class {
        #name : 'PenalizedShipStateTest',
        #superclass : 'TestCase',
        #category : 'IngSoft2-Tests',
        #package : 'IngSoft2-Tests'
}

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
