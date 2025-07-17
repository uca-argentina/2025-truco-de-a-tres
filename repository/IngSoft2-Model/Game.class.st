Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceShips',
		'board',
		'dice',
		'winner',
		'turnManager',
		'wantsToPassTurn',
		'penalizedShips',
		'lappedShips',
		'totalLaps',
		'state',
		'lastSteps',
		'lastPreviousPosition',
		'shipStatuses',
		'lastCardPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Game class >> minimunShipValidation: someShips [

	someShips size < 2 ifTrue: [
		self error: 'Need 2 space ships or more to initialize the game' ]
]

{ #category : 'initialize' }
Game class >> startWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps [

	self minimunShipValidation: someShips.
	^ self new
		  initializeWithShips: someShips
		  board: aBoard
		  dice: someDices
		  laps: aNumberLaps
]

{ #category : 'process actions' }
Game >> activeCards [
	| collection |
    collection := OrderedCollection new.
    spaceShips do: [ :ship | collection addAll: ship activeCards ].
    ^ collection
]

{ #category : 'process actions' }
Game >> advanceTurn [

        turnManager advanceTurn
]

{ #category : 'process actions' }
Game >> allStatuses [
	^ self spaceShips collect: [ :ship | self statusFor: ship ]
]

{ #category : 'accessing' }
Game >> board [
	^ board
]

{ #category : 'validation' }
Game >> checkWinCondition [
    (self currentShip hasReachedGoalOn: board) ifTrue: [
        (self hasWonByLaps: self currentShip) ifTrue: [
            winner := self currentShip.
            state := GameFinished withWinner: winner
        ]
    ].
]

{ #category : 'accessing' }
Game >> currentPlayerIndex [

    ^ self currentTurnIndex
]

{ #category : 'accessing' }
Game >> currentShip [
    ^ turnManager currentShip
]

{ #category : 'accessing' }
Game >> currentTurnIndex [

        ^ turnManager currentTurnIndex
]

{ #category : 'accessing' }
Game >> die [

    ^ dice
]

{ #category : 'process actions' }
Game >> ensureGameIsNotOver [
    self whenFinishedDo: [ :aWinner | self error: 'Game is already over' ]
        whenInProgressDo: [ ].
]

{ #category : 'testing' }
Game >> findPenaltyFor: aShip [
    ^ penalizedShips detect: [ :penalty | penalty isFor: aShip ] ifNone: [ PenalizedShip noPenaltyFor: aShip ]



]

{ #category : 'process actions' }
Game >> handlePenaltyOrPassIfNeeded [
	| ship |
	ship := self currentShip.

	(self isPenalized: ship) ifTrue: [
		self reducePenaltyFor: ship.
		self advanceTurn.
		^ true ].

	(self wantsToPassTurn: ship) ifTrue: [
		self markShipAsWantingToPassTurn: ship to: false.
		ship restoreFuel.
		self advanceTurn.
		^ true ].

	^ false
]

{ #category : 'testing' }
Game >> hasWonByLaps: aShip [
	^ (self lapTrackerFor: aShip) hasWonWithTotalLaps: totalLaps
]

{ #category : 'initialization' }
Game >> initializeWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps [

        spaceShips := someShips.
        board := aBoard.
        board registerShips: someShips.
        dice := someDices.
        totalLaps := aNumberLaps.
	
        turnManager := TurnManager withShips: someShips.
	
	penalizedShips := OrderedCollection new.
        wantsToPassTurn := Dictionary new.

        shipStatuses := Dictionary new.
       spaceShips do: [ :ship |
                shipStatuses at: ship put: (ShipStatus for: ship position: 0 laps: 0 penalized: false).
                2 timesRepeat: [ ship addCard: CardDeck randomCard ] ].
        state := GameInProgress new.
	
	lastSteps := 0.
       lastPreviousPosition := 0.
        lastCardPlayed := nil.
]

{ #category : 'testing' }
Game >> isPenalized: aShip [
    ^ (self findPenaltyFor: aShip) hasPenalty



]

{ #category : 'testing' }
Game >> lapTrackerFor: aShip [

	^ shipStatuses at: aShip
]

{ #category : 'accessing' }
Game >> lastCardPlayed [
	^ lastCardPlayed
]

{ #category : 'accessing' }
Game >> lastCardPlayed: aCard [
	lastCardPlayed := aCard
]

{ #category : 'testing' }
Game >> markShipAsWantingToPassTurn: aShip to: aBoolean [

	wantsToPassTurn at: aShip put: aBoolean.
]

{ #category : 'process actions' }
Game >> modifyRoll: aNumber forShip: aShip [
	| value |
    value := aNumber.
    self activeCards do: [ :card | value := card modifyRoll: value forShip: aShip inGame: self ].
    ^ value
]

{ #category : 'process actions' }
Game >> passTurn [
	self currentShip restoreFuel.
	self advanceTurn.
]

{ #category : 'process actions' }
Game >> penalize: aShip forTurns: turns [
    | existing |
    existing := penalizedShips
        detect: [ :penalty | penalty isFor: aShip ]
        ifNone: [ nil ].
    existing
        ifNil: [ penalizedShips add: (PenalizedShip for: aShip withTurns: turns) ]
        ifNotNil: [ existing turnsRemaining: turns ].
    (self lapTrackerFor: aShip) penalized: true.


]

{ #category : 'testing' }
Game >> penalizedTurnsRemainingFor: aShip [

        ^ (self findPenaltyFor: aShip) turnsRemaining.
]

{ #category : 'accessing' }
Game >> penaltyShip [

    ^ penalizedShips
]

{ #category : 'process actions' }
Game >> playTurn [

	self ensureGameIsNotOver.

	self handlePenaltyOrPassIfNeeded ifTrue: [ ^ self ].

	self rollAndMoveCurrentShip.

	self
		registerLapFor: self currentShip
		from: lastPreviousPosition
		after: lastSteps.

	self checkWinCondition.

	self advanceTurn
]

{ #category : 'process actions' }
Game >> playUntilFinish [

	self whenFinishedDo: [ :aWinner | ] whenInProgressDo: [
    [ self whenFinishedDo: [ :aWinner | false ] whenInProgressDo: [ true ] ]
        whileTrue: [ self playTurn ].
].
]

{ #category : 'process actions' }
Game >> ranking [

^ self allStatuses sort: [ :a :b |
                | sameLaps samePosition |

                sameLaps := a lapCount = b lapCount.
                samePosition := a position = b position.

                sameLaps
                        ifTrue: [
                                samePosition
                                        ifTrue: [ a ship name < b ship name ]
                                        ifFalse: [ a position > b position ]
                        ]
                        ifFalse: [ a lapCount > b lapCount ]
        ].

]

{ #category : 'process actions' }
Game >> redoLastCardOn: aShip [
	lastCardPlayed ifNotNil: [ lastCardPlayed playOn: aShip inGame: self ]
]

{ #category : 'testing' }
Game >> reducePenaltyFor: aShip [

	| penalty |

        penalty := self findPenaltyFor: aShip.
        penalty decreaseTurns.
        penalty hasPenalty ifFalse: [ penalizedShips remove: penalty ].
        (self lapTrackerFor: aShip) penalized: penalty hasPenalty.

	aShip restoreFuel.

]

{ #category : 'testing' }
Game >> registerLapFor: aShip from: oldPosition after: someSteps [

	| cellCount status |
	
	cellCount := board cellCount.

	(oldPosition + someSteps) < cellCount ifTrue: [ ^ self ].
	
	status := self lapTrackerFor: aShip.
	status addLap.
]

{ #category : 'process actions' }
Game >> removeActiveCard: aCard [
	spaceShips do: [ :ship | ship activeCards remove: aCard ifAbsent: [ ] ]
]

{ #category : 'process actions' }
Game >> repeatLastEffectOn: aShip [
	"Placeholder for board effects".
]

{ #category : 'process actions' }
Game >> rewardForMaxRollTo: aShip [
    (Random new next <= 0.8)
        ifTrue: [ aShip increaseMaxFuelBy: 1 ]
        ifFalse: [ aShip decreaseFuelBy: 1 ].
]

{ #category : 'process actions' }
Game >> rollAndMoveCurrentShip [
    | steps newPosition modified |
    lastPreviousPosition := self currentShip position.
    steps := dice roll.
    steps = dice maxRoll ifTrue: [ self rewardForMaxRollTo: self currentShip ].
    modified := self modifyRoll: steps forShip: self currentShip.
    modified >= 0 ifTrue: [
        newPosition := board determineNewPositionFrom: lastPreviousPosition after: modified.
        board moveShip: self currentShip to: newPosition.
    ] ifFalse: [
        board moveShip: self currentShip backward: modified abs.
    ].
    lastSteps := modified.
]

{ #category : 'accessing' }
Game >> spaceShips [

    ^ spaceShips asOrderedCollection.

]

{ #category : 'process actions' }
Game >> spaceshipPositions [
    ^ spaceShips collect: [ :ship | ShipPosition for: ship ]
]

{ #category : 'process actions' }
Game >> statusFor: aShip [

        | status |
        status := self lapTrackerFor: aShip.
        status position: (board positionOf: aShip).
        status penalized: (self isPenalized: aShip).
        ^ status
]

{ #category : 'validation' }
Game >> validateIsCurrentPlayer: aSpaceship [

	self currentShip = aSpaceship ifFalse: [
		self error: 'It is not the turn of this spaceship' ]
]

{ #category : 'process actions' }
Game >> wantsToPassTurn: aShip [

	^ (wantsToPassTurn at: aShip ifAbsent: [ false ]).
]

{ #category : 'testing' }
Game >> whenFinishedDo: finishedBlock whenInProgressDo: inProgressBlock [
    ^ state whenFinishedDo: finishedBlock whenInProgressDo: inProgressBlock.
]

{ #category : 'accessing' }
Game >> winner [
    ^ state whenFinishedDo: [ :w | w ] whenInProgressDo: [ nil ].
]
