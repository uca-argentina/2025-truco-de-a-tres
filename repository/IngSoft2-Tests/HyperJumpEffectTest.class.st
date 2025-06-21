Class {
	#name : 'HyperJumpEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpEffectTest >> testApplyToMovesShipForwardBy3 [

    | ship effect |

    ship := Spaceship named: 'Jumper' and: 4.
    ship moveTo: 2.

    effect := HyperJumpEffect new.
    effect applyTo: ship.

    self assert: ship position equals: 5.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testNextJumpValueCyclesCorrectly [

    HyperJumpEffect resetJumpIndex.

    self assert: HyperJumpEffect nextJumpValue equals: 3.
    self assert: HyperJumpEffect nextJumpValue equals: 5.
    self assert: HyperJumpEffect nextJumpValue equals: 2.
    self assert: HyperJumpEffect nextJumpValue equals: 4.
    self assert: HyperJumpEffect nextJumpValue equals: 3.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testResetJumpIndexRestartsSequence [

    HyperJumpEffect resetJumpIndex.
    HyperJumpEffect nextJumpValue.
    HyperJumpEffect nextJumpValue.
    HyperJumpEffect resetJumpIndex.

    self assert: HyperJumpEffect nextJumpValue equals: 3.
]
