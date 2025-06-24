Class {
	#name : 'LappedShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LappedShipTest >> testAddLapIncrementsCount [

    | ship lapped |

    ship := Spaceship withName: 'TestShip'.
    lapped := LappedShip for: ship.
    
    lapped addLap.
    lapped addLap.
    
    self assert: lapped lapCount equals: 2.
]

{ #category : 'tests' }
LappedShipTest >> testHasWonReturnsFalseWhenLapsInsufficient [

    | ship lapped |

    ship := Spaceship withName: 'TestShip'.
    lapped := LappedShip for: ship.
    
    lapped addLap.
    
    self deny: (lapped hasWonWithTotalLaps: 2).
]

{ #category : 'tests' }
LappedShipTest >> testHasWonReturnsTrueWhenLapsEqualGoal [

    | ship lapped |

    ship := Spaceship withName: 'TestShip'.
    lapped := LappedShip for: ship.
    
    3 timesRepeat: [ lapped addLap ].
    
    self assert: (lapped hasWonWithTotalLaps: 3).
]

{ #category : 'tests' }
LappedShipTest >> testInitializationSetsZeroLaps [

    | ship lapped |

    ship := Spaceship withName: 'TestShip'.
    lapped := LappedShip for: ship.
    
    self assert: lapped lapCount equals: 0.
]

{ #category : 'tests' }
LappedShipTest >> testShipReturnsOriginalShip [

    | ship lapped |

    ship := Spaceship withName: 'TestShip'.
    lapped := LappedShip for: ship.
    
    self assert: lapped ship equals: ship.
]

{ #category : 'tests' }
LappedShipTest >> testPositionMatchesShipPosition [

    | ship lapped |

    ship := Spaceship withName: 'TestShip'.
    ship moveTo: 3.
    lapped := LappedShip for: ship.

    self assert: lapped position equals: ship position.
]
