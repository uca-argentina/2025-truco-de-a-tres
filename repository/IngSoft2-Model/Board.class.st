Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'cellCount',
		'wormholes',
		'cells',
		'effects'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Board class >> new [
    self error: 'Use Board of:andWormholeAt: instead'.
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells andWormholeAt: positions [

	^ super new initializeWithCells: anAmountOfCells andWormholes: positions.
]

{ #category : 'initialize' }
Board >> applyEffectTo: aSpaceship [
	| effect |
	
	effect := self effectAt: aSpaceship position.
	effect ifNotNil: [ effect applyTo: aSpaceship ].

]

{ #category : 'initialize' }
Board >> applyEffectsTo: aSpaceship [

    | currentCell |

    currentCell := cells at: aSpaceship position.
    currentCell applyEffectTo: aSpaceship.

]

{ #category : 'initialize' }
Board >> applyWormholeIfPresentAt: aPosition [
    | matches |

    matches := wormholes select: [ :w | w hasEntryAt: aPosition ].

    ^ matches
        ifEmpty: [ aPosition ]
        ifNotEmpty: [ matches first exit ].
]

{ #category : 'initialize' }
Board >> assertValidState [
    (cellCount isInteger and: [ cellCount > 0 ]) ifFalse: [
        self error: 'Board must have a positive number of cells'.
    ].

    (wormholes isCollection and: [
        wormholes allSatisfy: [ :each | each isValid ].
    ]) ifFalse: [
        self error: 'All wormholes must be valid objects'.
    ].
]

{ #category : 'initialize' }
Board >> calculateNewPositionFrom: current after: steps moves: aLappedSpaceship [
	| newPosition |
	
	newPosition := (current + steps) \\ cellCount.

	(newPosition <= current) ifTrue: [ aLappedSpaceship addLap ].

	^ newPosition.
]

{ #category : 'initialize' }
Board >> cellCount [
    ^ cellCount.
]

{ #category : 'initialize' }
Board >> cells [
	^ cells.

]

{ #category : 'initialize' }
Board >> effectAt: aPosition [
	^ cells at: aPosition + 1

]

{ #category : 'initialize' }
Board >> initializeCells [
	cells := (1 to: cellCount) collect: [:i | self randomEffect ].

]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount andWormholes: aCollection [
	cellCount := aCount.
	wormholes := aCollection.
	
	self assertValidState.
	self initializeCells.
]

{ #category : 'initialize' }
Board >> initializeWithoutEffectsWithCells: aCount wormholes: aCollection [
	cellCount := aCount.
	wormholes := aCollection.
	
	cells := (1 to: cellCount) collect: [:i | nil ].
]

{ #category : 'validation' }
Board >> isBoardValid [
    [ self assertValidState. true ] on: Error do: [ false ].
]

{ #category : 'initialize' }
Board >> isGoalReachedAt: aPosition [
    ^ aPosition >= cellCount.
]

{ #category : 'initialize' }
Board >> isPossibleToReach: aPosition after: roll [
	| effect |
	
	effect := self effectAt: aPosition.
	
	^ effect allowsEntryWithRoll: roll.


]

{ #category : 'validation' }
Board >> isValid [
    ^ [ self assertValidState. true ] on: Error do: [ false ].
]

{ #category : 'moves' }
Board >> newPositionFrom: aPosition steps: steps [
    ^ self applyWormholeIfPresentAt: (aPosition + steps).
]

{ #category : 'moves' }
Board >> newPositionFrom: aPosition steps: steps for: aLappedSpaceship [
    | position |

    position := (aPosition + steps) \\ cellCount.
    
    (position <= aPosition) ifTrue: [  aLappedSpaceship addLap ].
    
    ^ self applyWormholeIfPresentAt: position.

]

{ #category : 'moves' }
Board >> newPositionFrom: aPosition steps: steps for: aLappedSpaceship withRoll: roll [
	| position effect |
	
	position := (aPosition + steps) \\ cellCount.

	(position <= aPosition) ifTrue: [  aLappedSpaceship addLap ].

	effect := cells at: position + 1.
	
	(effect allowsEntryWithRoll: roll)
		ifTrue: [ ^ position ]
		ifFalse: [ ^ aPosition ].

]

{ #category : 'initialize' }
Board >> randomEffect [
	effects := { BlackHoleEffect. HyperGravityEffect }.
	
	^ (effects atRandom) new.

]
