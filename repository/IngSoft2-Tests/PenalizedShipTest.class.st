Class {
        #name : 'PenalizedShipStateTest',
        #superclass : 'TestCase',
        #category : 'IngSoft2-Tests',
        #package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PenalizedShipStateTest >> testDecreaseTurn [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.

    penalized := PenalizedShipState for: ship withTurns: 2.
    penalized decreaseTurns.
    penalized decreaseTurns.

    self deny: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipStateTest >> testInitializationWithPenalty [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShipState for: ship withTurns: 3.

    self assert: (penalized isFor: ship).
    self assert: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipStateTest >> testInitializationWithoutPenalty [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShipState noPenaltyFor: ship.

    self assert: (penalized isFor: ship).
    self deny: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipStateTest >> testIsForReturnsFalseForDifferentShip [

	| penalized ship1 ship2 |

    ship1 := Spaceship withName: 'Apollo'.
    ship2 := Spaceship withName: 'Challenger'.
    penalized := PenalizedShipState for: ship1 withTurns: 1.

    self deny: (penalized isFor: ship2).
]

{ #category : 'tests' }
PenalizedShipStateTest >> testShipReference [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShipState for: ship withTurns: 1.

    self assert: penalized ship equals: ship.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testTurnsRemainingAccessor [

	| penalized ship |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShipState for: ship withTurns: 3.

    self assert: penalized turnsRemaining equals: 3.
]

{ #category : 'tests' }
PenalizedShipStateTest >> testTurnsRemainingSetter [
	| penalized ship |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShipState for: ship withTurns: 1.
    penalized turnsRemaining: 5.

    self assert: penalized turnsRemaining equals: 5.
]
