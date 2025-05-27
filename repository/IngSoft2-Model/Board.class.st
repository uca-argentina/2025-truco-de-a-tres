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
    self error: 'Use Board withCells:andWormholes: instead'.
]

{ #category : 'initialize' }
Board class >> withCells: aCount [
    ^ self withCells: aCount andWormholes: OrderedCollection new.
]

{ #category : 'initialize' }
Board class >> withCells: aCount and: aWormhole [

	^ self new initializeWithCells: aCount wormholes: aWormhole.
]

{ #category : 'initialize' }
Board class >> withCells: aCount andWormholes: aCollection [
    ^ super new initializeWithCells: aCount andWormholes: aCollection.

]

{ #category : 'initialize' }
Board class >> withEmptyCells: aCount andWormholes: aCollection [
	| board |
	board := self new.
	board initializeWithoutEffectsWithCells: aCount wormholes: aCollection.
	^ board.
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
        self error: 'Board must have a positive number of cells'
    ].

    (wormholes isCollection and: [
        wormholes allSatisfy: [ :each | each isValid ]
    ]) ifFalse: [
        self error: 'All wormholes must be valid objects'
    ].
]

{ #category : 'initialize' }
Board >> canEnterPosition: aPosition withRoll: roll [
	| effect |
	effect := self effectAt: aPosition.
	^ effect allowsEntryWithRoll: roll.


]

{ #category : 'initialize' }
Board >> cellCount [
    ^ cellCount
]

{ #category : 'initialize' }
Board >> cells [
	^ cells

]

{ #category : 'initialize' }
Board >> circularPositionFrom: current steps: steps for: aLappedSpaceship [
	| newPosition |
	newPosition := (current + steps) \\ cellCount.

	(newPosition <= current) ifTrue: [ aLappedSpaceship addLap ].

	^ newPosition
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
Board >> initializeWithCells: aCount and: aWormhole [
	cellCount := aCount.
   wormholes := aWormhole.
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount andWormholes: aCollection [
    cellCount := aCount.
    wormholes := aCollection.
    self assertValidState.
	 self initializeCells.
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount wormholes: aDictionary [
	cellCount := aCount.
   wormholes := aDictionary.  "NO USAR MAS, AHORA USAMOS initializeWithCells: aCount and: aWormhole"
]

{ #category : 'initialize' }
Board >> initializeWithoutEffectsWithCells: aCount wormholes: aCollection [
	cellCount := aCount.
	wormholes := aCollection.
	cells := (1 to: cellCount) collect: [:i | nil ].
]

{ #category : 'initialize' }
Board >> isBoardValid [
    [ self assertValidState. true ] on: Error do: [ false ].
]

{ #category : 'initialize' }
Board >> isGoalReachedAt: aPosition [
    ^ aPosition >= cellCount
]

{ #category : 'initialize' }
Board >> isValid [
    ^ [ self assertValidState. true ] on: Error do: [ false ].
]

{ #category : 'initialize' }
Board >> newPositionFrom: aPosition steps: steps [
    ^ self applyWormholeIfPresentAt: (aPosition + steps).
]

{ #category : 'initialize' }
Board >> newPositionFrom: aPosition steps: steps for: aLappedSpaceship [
    | position |
    position := (aPosition + steps) \\ cellCount.
    
    (position <= aPosition) ifTrue: [  aLappedSpaceship addLap ].
    
    ^ self applyWormholeIfPresentAt: position

]

{ #category : 'initialize' }
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
	^ (effects atRandom) new

]

{ #category : 'initialize' }
Board >> wormholes [
	^ wormholes
]
