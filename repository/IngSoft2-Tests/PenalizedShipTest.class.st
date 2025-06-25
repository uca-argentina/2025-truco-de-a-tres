Class {
	#name : 'PenalizedShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PenalizedShipTest >> testDecreaseTurn [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.

    penalized := PenalizedShip for: ship withTurns: 2.
    penalized decreaseTurns.
    penalized decreaseTurns.

    self deny: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipTest >> testInitializationWithPenalty [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShip for: ship withTurns: 3.

    self assert: (penalized isFor: ship).
    self assert: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipTest >> testInitializationWithoutPenalty [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShip noPenaltyFor: ship.

    self assert: (penalized isFor: ship).
    self deny: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipTest >> testIsForReturnsFalseForDifferentShip [

	| penalized ship1 ship2 |

    ship1 := Spaceship withName: 'Apollo'.
    ship2 := Spaceship withName: 'Challenger'.
    penalized := PenalizedShip for: ship1 withTurns: 1.

    self deny: (penalized isFor: ship2).
]

{ #category : 'tests' }
PenalizedShipTest >> testShipReference [

    | ship penalized |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShip for: ship withTurns: 1.

    self assert: penalized ship equals: ship.
]

{ #category : 'tests' }
PenalizedShipTest >> testTurnsRemainingAccessor [

	| penalized ship |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShip for: ship withTurns: 3.

    self assert: penalized turnsRemaining equals: 3.
]

{ #category : 'tests' }
PenalizedShipTest >> testTurnsRemainingSetter [
	| penalized ship |

    ship := Spaceship withName: 'Apollo'.
    penalized := PenalizedShip for: ship withTurns: 1.
    penalized turnsRemaining: 5.

    self assert: penalized turnsRemaining equals: 5.
]
