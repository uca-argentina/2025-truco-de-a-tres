Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'cellCount',
		'wormholes',
		'cells',
		'totalLengthInParsecs',
		'positionManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Board class >> convertToParsecs: aLength [
    ^ (aLength isKindOf: Distance)
        ifTrue: [ aLength asParsecs ]
        ifFalse: [ aLength ].
]

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

	| lengthOnParsecs |
	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.
	lengthOnParsecs := self convertToParsecs: parsecLength.

	^ self new
		  initializeWithCells: anAmountOfCells
		  length: lengthOnParsecs
		  andWormholes: positions
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells length: parsecLength lengthLightYears: lightYears andWormholeAt: positions [

	self
		validateLengthConsistencyBetweenParsecs: parsecLength
		andLightYears: lightYears.
	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.

	parsecLength
		ifNil: [
			^ self
				  of: anAmountOfCells
				  lengthLightYears: lightYears
				  andWormholeAt: positions ]
		ifNotNil: [
			^ self
				  of: anAmountOfCells
				  length: parsecLength
				  andWormholeAt: positions ]
]

{ #category : 'initialize' }
Board class >> of: anAmountOfCells lengthLightYears: lightYears andWormholeAt: positions [

	self validateCellCount: anAmountOfCells.
	self validateWormholes: positions.

	^ self
		  of: anAmountOfCells
		  length: (Distance lightYears: lightYears) asParsecs
		  andWormholeAt: positions
]

{ #category : 'initialize' }
Board class >> validateCellCount: aCount [

	(aCount isInteger and: [ aCount > 0 ]) ifFalse: [
		self error: 'Board must have a positive number of cells' ]
]

{ #category : 'initialize' }
Board class >> validateLengthConsistencyBetweenParsecs: parsecLength andLightYears: lightYears [
    (parsecLength notNil and: [ lightYears notNil ]) ifTrue: [
        (Distance parsecs: parsecLength) asLightYears = lightYears ifFalse: [
            self error: 'Length mismatch between parsecs and light years'
        ]
    ]
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
]

{ #category : 'initialize' }
Board >> applyWormholeIfPresentAt: aPosition [
    ^ (wormholes detect: [ :w | w hasEntryAt: aPosition ] ifNone: [ nil ])
        ifNil: [ aPosition ]
        ifNotNil: [ :w | w exit ]
]

{ #category : 'initialize' }
Board >> calculateNewPositionFrom: current after: steps moves: aShipStatus [

	| newPosition |
	
	newPosition := (current + steps) \\ cellCount.

	(newPosition <= current) ifTrue: [ aShipStatus addLap ].

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

{ #category : 'deck' }
Board >> drawCard [
    "Return a random card from the deck"

    ^ CardDeck randomCard
]

{ #category : 'initialize' }
Board >> effectAt: aPosition [
    ^ cells at: aPosition ifAbsent: [ NoEffect new ]
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount andWormholes: aCollection [
    ^ self
        initializeWithCells: aCount
        length: aCount
        andWormholes: aCollection
]

{ #category : 'initialize' }
Board >> initializeWithCells: aCount length: aLengthInParsecs andWormholes: aCollection [
    cellCount := aCount.
    totalLengthInParsecs := aLengthInParsecs.
    wormholes := aCollection.
         cells := Dictionary new.

        0 to: aCount - 1 do: [ :i |
                cells at: i put: self randomEffect ].

    ^ self
]

{ #category : 'initialize' }
Board >> isPositionReachedAt: aPosition [

    ^ aPosition >= cellCount.
]

{ #category : 'spaceships' }
Board >> moveShip: aShip backward: steps [
    positionManager ifNil: [
        self error: 'Board has no registered ships'.
    ].
    positionManager moveShip: aShip backward: steps.
]

{ #category : 'spaceships' }
Board >> moveShip: aShip forward: steps [
    positionManager ifNil: [
        self error: 'Board has no registered ships'.
    ].
    positionManager moveShip: aShip forward: steps.
]

{ #category : 'spaceships' }
Board >> moveShip: aShip to: aPosition [
    positionManager ifNil: [
        self error: 'Board has no registered ships'.
    ].
    positionManager moveShip: aShip to: aPosition.
]

{ #category : 'spaceships' }
Board >> positionOf: aShip [

	positionManager ifNil: [ self error: 'Board has no registered ships' ].
	^ positionManager positionOf: aShip
]

{ #category : 'initialize' }
Board >> randomEffect [

	| randomNumber |
	randomNumber := (1 to: 100) atRandom.
	randomNumber <= 10 ifTrue: [ ^ CardEffect new ].
	randomNumber <= 48 ifTrue: [ ^ NoEffect new ].
	randomNumber <= 74 ifTrue: [ ^ BlackHoleEffect new ].
	^ HyperGravityEffect new
]

{ #category : 'spaceships' }
Board >> registerShips: someShips [
    positionManager := PositionManager forShips: someShips.
]

{ #category : 'initialize' }
Board >> stepsFromDistance: aDistance [

    ^ self stepsFromParsecs: aDistance asParsecs
]

{ #category : 'initialize' }
Board >> stepsFromLightYears: someLightYears [
    "Convert a distance expressed in light years to board steps"
    ^ self stepsFromParsecs: (Distance lightYears: someLightYears) asParsecs
]

{ #category : 'initialize' }
Board >> stepsFromParsecs: someParsecs [
    | ratio |
    ratio := someParsecs / totalLengthInParsecs.
    ^ (ratio * cellCount) rounded.
]
