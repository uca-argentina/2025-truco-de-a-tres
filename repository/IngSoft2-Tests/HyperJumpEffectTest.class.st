Class {
	#name : 'HyperJumpEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpEffectTest >> testApplyToMovesShipForwardByCurrentJumpValue [
    | ship effect expected initialPosition |

    HyperJumpEffect resetJumpIndex.
    expected := HyperJumpEffect peekJumpValue.

    ship := Spaceship withName: 'Jumper' and: 4.
    initialPosition := 2.
    ship moveTo: initialPosition.

    effect := HyperJumpEffect new.
    effect applyTo: ship.

    self assert: ship position equals: (initialPosition + expected).
]

{ #category : 'tests' }
HyperJumpEffectTest >> testHyperJumpCyclesThroughAllJumpValues [
    | ship effect positions initialPosition |

    HyperJumpEffect resetJumpIndex.

    ship := Spaceship withName: 'Cycler' and: 10.
    initialPosition := 0.
    ship moveTo: initialPosition.

    effect := HyperJumpEffect new.

    positions := OrderedCollection new.
    4 timesRepeat: [
        effect applyTo: ship.
        positions add: ship position.
    ].

    self assert: positions asArray equals: #(3 8 10 14).
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
