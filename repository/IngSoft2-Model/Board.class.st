Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'cellCount',
		'wormholes'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Board class >> new [
    self error: 'Use Board withCells:andWormholes: instead'.
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
Board >> cellCount [
    ^ cellCount
]

{ #category : 'initialize' }
Board >> circularPositionFrom: current steps: steps for: aSpaceship [
	| newPosition |
	newPosition := (current + steps) \\ cellCount.

	(newPosition <= current) ifTrue: [ aSpaceship incrementLap ].

	^ newPosition
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
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount wormholes: aDictionary [
	cellCount := aCount.
   wormholes := aDictionary.  "NO USAR MAS, AHORA USAMOS initializeWithCells: aCount and: aWormhole"
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
Board >> newPositionFrom: aPosition steps: steps for: spaceship [
    | position |
    position := (aPosition + steps) \\ cellCount.
    
    (position <= aPosition) ifTrue: [ spaceship incrementLap ].
    
    ^ self applyWormholeIfPresentAt: position

]

{ #category : 'initialize' }
Board >> wormholes [
	^ wormholes
]
