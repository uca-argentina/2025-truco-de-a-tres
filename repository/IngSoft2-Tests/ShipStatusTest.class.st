Class {
	#name : 'ShipStatusTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipStatusTest >> testInitializationSetsValuesCorrectly [

    | ship status |

    ship := Spaceship withName: 'Voyager'.
    status := ShipStatus for: ship position: 5 laps: 2 penalized: true.

    self assert: status ship equals: ship.
    self assert: status position equals: 5.
    self assert: status lapCount equals: 2.
    self assert: status isPenalized.
]

{ #category : 'tests' }
ShipStatusTest >> testIsPenalizedReturnsFalse [

    | ship status |

    ship := Spaceship withName: 'Enterprise'.
    status := ShipStatus for: ship position: 0 laps: 0 penalized: false.

    self deny: status isPenalized.
]
