Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WormholeTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage].
	


]

{ #category : 'tests - instance' }
WormholeTest >> testExitRaisesIfNotEntry [

    | wormhole |

    wormhole := Wormhole from: 1 to: 3.

    self should: [ wormhole exit: 5 ] raise: Error.
]

{ #category : 'tests - instance' }
WormholeTest >> testHasEntryAtFalseReturnsFalse [

    | wormhole |

    wormhole := Wormhole from: 1 to: 3.

    self deny: (wormhole hasEntryAt: 5).
]

{ #category : 'tests - instance' }
WormholeTest >> testHasEntryAtReturnsTrueOnlyWhenMatched [

    | wormhole |

    wormhole := Wormhole from: 4 to: 9.

    self assert: (wormhole hasEntryAt: 4).
    self deny: (wormhole hasEntryAt: 3).
]

{ #category : 'tests - instance' }
WormholeTest >> testInitializeFromToFailsWhenEqual [

    self should: [ Wormhole from: 5 to: 5 ] raise: Error.
]

{ #category : 'tests - instance' }
WormholeTest >> testInitializeFromToFailsWithNegativeValues [

    self should: [ Wormhole from: -1 to: 3 ] raise: Error.
    self should: [ Wormhole from: 3 to: -1 ] raise: Error.
]

{ #category : 'tests - instance' }
WormholeTest >> testInitializeFromToFailsWithNonInteger [

    self should: [ Wormhole from: 'a' to: 5 ] raise: Error.
    self should: [ Wormhole from: 5 to: 'b' ] raise: Error.
]

{ #category : 'tests - instance' }
WormholeTest >> testInitializeFromToSetsEntryAndExit [

    | wormhole |

    wormhole := Wormhole from: 3 to: 8.

    self assert: (wormhole hasEntryAt: 3).
    self assert: wormhole exit equals: 8.
]

{ #category : 'tests - instance' }
WormholeTest >> testInvalidWormholeCreation [

	self
		should: [ Wormhole connecting: 7 and: 7]
		raise: Error 
		withMessageText: 'Wormhole positions must be distinct'.
]

{ #category : 'tests - instance' }
WormholeTest >> testIsValidReturnsFalseWhenInvalid [
    self should: [
        Wormhole from: 7 to: 7
    ] raise: Error.

]

{ #category : 'tests - instance' }
WormholeTest >> testIsValidReturnsTrueForValidWormhole [

    | wormhole |

    wormhole := Wormhole from: 1 to: 4.

    self assert: wormhole isValid.
]

{ #category : 'tests - instance' }
WormholeTest >> testValidWormholeCreation [

	| wormhole |
	wormhole := Wormhole connecting: 5 and: 10.

	self assert: wormhole entry equals: 5.
	self assert: wormhole exit equals: 10.
]
