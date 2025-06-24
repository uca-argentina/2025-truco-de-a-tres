Class {
	#name : 'Board',
	#superclass : 'Object',
        #instVars : [
                'cellCount',
                'wormholes',
                'cells',
                'effects',
                'totalLengthInParsecs',
                'positionManager'
        ],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Board class >> of: anAmountOfCells andWormholeAt: positions [

	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.
	^ self new
		  initializeWithCells: anAmountOfCells
		  andWormholes: positions
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells length: parsecLength andWormholeAt: positions [
    self validateCellCount: anAmountOfCells.
    self validateWormholes: positions.
    ^ self new
        initializeWithCells: anAmountOfCells
        length: parsecLength
        andWormholes: positions.
]

{ #category : 'initialize' }
Board class >> validateCellCount: aCount [

	(aCount isInteger and: [ aCount > 0 ]) ifFalse: [
		self error: 'Board must have a positive number of cells' ]
]

{ #category : 'initialize' }
Board class >> validateWormholes: aCollection [

	(aCollection isCollection and: [
		 aCollection allSatisfy: [ :each | each isValid ] ]) ifFalse: [
		self error: 'All wormholes must be valid objects' ]
]

{ #category : 'initialize' }
Board >> applyEffectTo: aSpaceship [
    | effect |
    
    effect := self effectAt: (self positionOf: aSpaceship).
    effect ifNotNil: [ effect applyTo: aSpaceship inBoard: self ].
    positionManager ifNotNil: [
        positionManager moveShip: aSpaceship to: aSpaceship position ].

]

{ #category : 'initialize' }
Board >> applyWormholeIfPresentAt: aPosition [
    ^ (wormholes detect: [ :w | w hasEntryAt: aPosition ] ifNone: [ nil ])
        ifNil: [ aPosition ]
        ifNotNil: [ :w | w exit ]
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
    ^ cells size.
]

{ #category : 'initialize' }
Board >> cells [
	^ cells.

]

{ #category : 'moves' }
Board >> determineNewPositionFrom: aPosition after: steps [
    ^ self applyWormholeIfPresentAt: (aPosition + steps).
]

{ #category : 'initialize' }
Board >> effectAt: aPosition [
    ^ cells at: aPosition ifAbsent: [ NoEffect new ]
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount andWormholes: aCollection [
	cellCount := aCount.
	wormholes := aCollection.
	cells := Dictionary new.
	
0 to: aCount - 1 do: [ :i |
		cells at: i put: NoEffect new ].
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount length: aLengthInParsecs andWormholes: aCollection [
    cellCount := aCount.
    totalLengthInParsecs := aLengthInParsecs.
    wormholes := aCollection.
	 cells := Dictionary new.
	
	0 to: aCount - 1 do: [ :i |
		cells at: i put: NoEffect new ].
    
]

{ #category : 'initialize' }
Board >> isGoalReachedAt: aPosition [
    ^ aPosition >= cellCount.
]

{ #category : 'initialize' }
Board >> stepsFromParsecs: someParsecs [
    | ratio |
    ratio := someParsecs / totalLengthInParsecs.
    ^ (ratio * cellCount) rounded.
]

{ #category : 'spaceships' }
Board >> registerShips: someShips [
    positionManager := PositionManager forShips: someShips.
]

{ #category : 'spaceships' }
Board >> positionOf: aShip [
    positionManager ifNil: [ ^ aShip position ].
    ^ positionManager positionOf: aShip
]

{ #category : 'spaceships' }
Board >> moveShip: aShip to: aPosition [
    positionManager
        ifNil: [ aShip moveTo: aPosition ]
        ifNotNil: [ positionManager moveShip: aShip to: aPosition ].
]

{ #category : 'spaceships' }
Board >> moveShip: aShip forward: steps [
    positionManager
        ifNil: [ aShip moveForward: steps ]
        ifNotNil: [ positionManager moveShip: aShip forward: steps ].
]

{ #category : 'spaceships' }
Board >> moveShip: aShip backward: steps [
    positionManager
        ifNil: [ aShip moveBack: steps ]
        ifNotNil: [ positionManager moveShip: aShip backward: steps ].
]
