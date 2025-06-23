Class {
	#name : 'HyperJumpEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpEffectTest >> testAllowsEntryWithRollAlwaysTrue [
	| effect |
	effect := HyperJumpEffect withValues: #(3 7 12).

	self assert: (effect allowsEntryWithRoll: 1).
	self assert: (effect allowsEntryWithRoll: 6).
	self assert: (effect allowsEntryWithRoll: 100).
]

{ #category : 'tests' }
HyperJumpEffectTest >> testApplyToMovesShipForwardByCurrentJumpValue [
    | ship effect expected initialPosition board |

    board := Board of: 10 length: 10 andWormholeAt: #().
    effect := HyperJumpEffect withValues: #(3 5 2 4).
    expected := effect peekJumpValue.

    ship := Spaceship withName: 'Jumper'.
    initialPosition := 2.
    ship moveTo: initialPosition.

    effect applyTo: ship inBoard: board.

    self assert: ship position equals: (initialPosition + (board stepsFromParsecs: expected)).
]

{ #category : 'tests' }
HyperJumpEffectTest >> testHyperJumpCyclesThroughAllJumpValues [
    | ship effect positions initialPosition board |

    board := Board of: 10 length: 10 andWormholeAt: #().
    effect := HyperJumpEffect withValues: #(3 5 2 4).

    ship := Spaceship withName: 'Cycler'.
    initialPosition := 0.
    ship moveTo: initialPosition.

    positions := OrderedCollection new.
    4 timesRepeat: [
        effect applyTo: ship inBoard: board.
        positions add: ship position.
    ].

    self assert: positions asArray equals: #(3 8 10 14).
]

{ #category : 'tests' }
HyperJumpEffectTest >> testHyperJumpEffectWithValuesInitializesCorrectly [
	| values effect |
	values := #(1 3 5).
	effect := HyperJumpEffect withValues: values.

	self assert: (effect perform: #values) equals: values.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testNextJumpValueCyclesCorrectly [
    | effect |

    effect := HyperJumpEffect withValues: #(3 5 2 4).

    self assert: effect nextJumpValue equals: 3.
    self assert: effect nextJumpValue equals: 5.
    self assert: effect nextJumpValue equals: 2.
    self assert: effect nextJumpValue equals: 4.
    self assert: effect nextJumpValue equals: 3.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testResetJumpIndexRestartsSequence [
    | effect |

    effect := HyperJumpEffect withValues: #(3 5 2 4).

    effect nextJumpValue. "3"
    effect nextJumpValue. "5"

    effect resetJumpIndex.

    self assert: effect nextJumpValue equals: 3.
]
