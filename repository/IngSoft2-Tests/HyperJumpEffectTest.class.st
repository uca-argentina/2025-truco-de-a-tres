Class {
	#name : 'HyperJumpEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
HyperJumpEffectTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

        self
                should: anErrorBlock
                raise: anErrorClass
                withExceptionDo: [ :error |
                self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
HyperJumpEffectTest >> testAllowsEntryWithRollAlwaysTrue [
	| effect |
	effect := HyperJumpEffect withValues: #(3 7 12).

	self assert: (effect allowsEntryWithRoll: 1).
	self assert: (effect allowsEntryWithRoll: 6).
	self assert: (effect allowsEntryWithRoll: 100).
]

{ #category : 'tests' }
HyperJumpEffectTest >> testApplyEffectToMovesShipForward [
    | effect ship board expected initial |
    board := Board of: 10 length: 10 andWormholeAt: #().
    effect := HyperJumpEffect withValues: #(2 4).
    expected := effect peekJumpValue.
    ship := Spaceship withName: 'Direct'.
    initial := 1.
    ship moveTo: initial.

    effect applyEffectTo: ship inBoard: board.

    self assert: ship position equals: (initial + (board stepsFromParsecs: expected)).
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
HyperJumpEffectTest >> testApplyToWithoutBoardRaisesError [
    | effect ship |
    ship := Spaceship withName: 'Error'.
    effect := HyperJumpEffect withValues: #(1 2).

    self
        should: [ effect applyTo: ship ]
        raise: Error
        withMessageText: 'Use applyTo:inBoard: instead.'
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

    self assert: positions asArray equals: #(5 9 12 14).
]

{ #category : 'tests' }
HyperJumpEffectTest >> testHyperJumpEffectWithValuesInitializesCorrectly [
        | values effect |
        values := #(1 3 5).
        effect := HyperJumpEffect withValues: values.

        self assert: (effect perform: #values) equals: #(5 3 1).
]

{ #category : 'tests' }
HyperJumpEffectTest >> testInitializeWithSetsJumpValuesAndIndex [

	| values effect |
        values := #(3 5 7).
        effect := HyperJumpEffect new initializeWith: values.

        self assert: (effect instVarNamed: 'jumpValues') equals: #(7 5 3).
        self assert: (effect instVarNamed: 'currentIndex') equals: 1.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testNextJumpValueCyclesCorrectly [
    | effect |

    effect := HyperJumpEffect withValues: #(3 5 2 4).

    self assert: effect nextJumpValue equals: 5.
    self assert: effect nextJumpValue equals: 4.
    self assert: effect nextJumpValue equals: 3.
    self assert: effect nextJumpValue equals: 2.
    self assert: effect nextJumpValue equals: 5.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testNextJumpValueReturnsValuesCyclically [

        | effect values |
        values := #(3 5 7).
        effect := HyperJumpEffect withValues: values.

        self assert: effect nextJumpValue equals: 7.
        self assert: effect nextJumpValue equals: 5.
        self assert: effect nextJumpValue equals: 3.
        self assert: effect nextJumpValue equals: 7.
        self assert: effect nextJumpValue equals: 5.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testPeekJumpValueReturnsCurrentValueWithoutAdvancing [

        | effect values |
        values := #(10 20 30).
        effect := HyperJumpEffect withValues: values.

        self assert: effect peekJumpValue equals: 30.
        self assert: effect peekJumpValue equals: 30.
        effect nextJumpValue.
        self assert: effect peekJumpValue equals: 20.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testResetJumpIndexRestartsSequence [
    | effect |

    effect := HyperJumpEffect withValues: #(3 5 2 4).

    effect nextJumpValue.
    effect nextJumpValue.

    effect resetJumpIndex.

    self assert: effect nextJumpValue equals: 5.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testResetJumpIndexSetsIndexBackToOne [

        | effect values |
        values := #(3 6 9).
        effect := HyperJumpEffect withValues: values.

        effect nextJumpValue.
        effect nextJumpValue.

        effect resetJumpIndex.

        self assert: effect peekJumpValue equals: 9.
]

{ #category : 'tests' }
HyperJumpEffectTest >> testWithLightYearValuesConvertsProperly [
    | effect board ship |
    board := Board of: 10 length: 10 andWormholeAt: #().
    effect := HyperJumpEffect withLightYearValues: #(3 6).
    ship := Spaceship withName: 'LY'.
    ship moveTo: 0.
    effect applyTo: ship inBoard: board.
    self assert: ship position equals: (board stepsFromParsecs: 2).
]
