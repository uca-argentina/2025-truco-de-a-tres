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
		'shipStatuses'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Game class >> startWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps [

	GameValidator validateMinimumSpaceShips: someShips.
	^ self new initializeWithShips: someShips board: aBoard dice: someDices laps: aNumberLaps.
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
]

{ #category : 'testing' }
Game >> isPenalized: aShip [
    ^ (self findPenaltyFor: aShip) hasPenalty



]

{ #category : 'testing' }
Game >> lapTrackerFor: aShip [

	^ shipStatuses at: aShip
]

{ #category : 'testing' }
Game >> markShipAsWantingToPassTurn: aShip to: aBoolean [

	wantsToPassTurn at: aShip put: aBoolean.
]

{ #category : 'process actions' }
Game >> passTurn [
	self currentShip restoreFuel.
	self advanceTurn.
]

{ #category : 'process actions' }
Game >> penalize: aShip forTurns: turns [
    penalizedShips add: (PenalizedShip for: aShip withTurns: turns).


]

{ #category : 'accessing' }
Game >> penaltyShip [

    ^ penalizedShips
]

{ #category : 'testing' }
Game >> penaltyTurnsRemainingFor: aShip [

        ^ (self findPenaltyFor: aShip) turnsRemaining.
]

{ #category : 'process actions' }
Game >> playTurn [

	GameValidator new
		validateIsCurrentPlayer: self currentShip
		forGame: self.
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

{ #category : 'testing' }
Game >> reducePenaltyFor: aShip [

	| penalty |
	
	penalty := self findPenaltyFor: aShip.
	penalty decreaseTurns.
	penalty hasPenalty ifFalse: [ penalizedShips remove: penalty ].

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
Game >> rewardForMaxRollTo: aShip [
    (Random new next <= 0.8)
        ifTrue: [ aShip increaseMaxFuelBy: 1 ]
        ifFalse: [ aShip decreaseFuelBy: 1 ].
]

{ #category : 'process actions' }
Game >> rollAndMoveCurrentShip [
    | steps newPosition |
    lastPreviousPosition := self currentShip position.
    steps := dice roll.
    steps = dice maxRoll ifTrue: [ self rewardForMaxRollTo: self currentShip ].
    newPosition := board determineNewPositionFrom: lastPreviousPosition after: steps.
    board moveShip: self currentShip to: newPosition.
    lastSteps := steps.
]

{ #category : 'accessing' }
Game >> spaceShips [

    ^ spaceShips.

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
