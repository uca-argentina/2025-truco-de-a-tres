Class {
	#name : 'BlackHoleEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyToDoesNotGoBelowZero [

    | ship effect |

    ship := Spaceship withName: 'Boundary'.
    ship moveTo: 3.

    effect := BlackHoleEffect new.
    effect applyTo: ship.

    self assert: ship position equals: 0.
]

{ #category : 'tests' }
BlackHoleEffectTest >> testApplyToMovesShipBackBy4 [

    | ship effect |

    ship := Spaceship withName: 'Voyager'.
    ship moveTo: 6.

    effect := BlackHoleEffect new.
    effect applyTo: ship.

    self assert: ship position equals: 2.
]
