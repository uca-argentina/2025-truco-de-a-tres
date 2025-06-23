Class {
	#name : 'PenalizedShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PenalizedShipTest >> testDecreaseTurn [

    | ship penalized |

    ship := Spaceship withName: 'Apollo' and: 4.

    penalized := PenalizedShip for: ship withTurns: 2.
    penalized decreaseTurns.
    penalized decreaseTurns.

    self deny: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipTest >> testInitializationWithPenalty [

    | ship penalized |

    ship := Spaceship withName: 'Apollo' and: 4.
    penalized := PenalizedShip for: ship withTurns: 3.

    self assert: (penalized isFor: ship).
    self assert: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipTest >> testInitializationWithoutPenalty [

    | ship penalized |

    ship := Spaceship withName: 'Apollo' and: 4.
    penalized := PenalizedShip noPenaltyFor: ship.

    self assert: (penalized isFor: ship).
    self deny: (penalized hasPenalty).
]

{ #category : 'tests' }
PenalizedShipTest >> testShipReference [

    | ship penalized |

    ship := Spaceship withName: 'Apollo' and: 4.
    penalized := PenalizedShip for: ship withTurns: 1.

    self assert: penalized ship equals: ship.
]
