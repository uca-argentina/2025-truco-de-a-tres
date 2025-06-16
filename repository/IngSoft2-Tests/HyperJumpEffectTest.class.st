Class {
	#name : 'HyperJumpEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpEffectTest >> testApplyToMovesShipForwardBy3 [

    | ship effect |

    ship := Spaceship withName: 'Jumper' and: 4.
    ship moveTo: 2.

    effect := HyperJumpEffect new.
    effect applyTo: ship.

    self assert: ship position equals: 5.
]
