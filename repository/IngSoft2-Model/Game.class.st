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
		'lastPreviousPosition'
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
Game >> currentShip [
    ^ turnManager currentShip
]

{ #category : 'accessing' }
Game >> currentTurnIndex [

        ^ turnManager currentTurnIndex
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
	
	lappedShips := spaceShips collect: [ :ship | LappedShip for: ship ].
	state := GameInProgress new.
	
	lastSteps := 0.
	lastPreviousPosition := 0.
]

{ #category : 'testing' }
Game >> isPenalized: aShip [
    ^ (self findPenaltyFor: aShip) hasPenalty



]

{ #category : 'testing' }
Game >> penaltyTurnsRemainingFor: aShip [

        ^ (self findPenaltyFor: aShip) turnsRemaining.
]

{ #category : 'testing' }
Game >> lapTrackerFor: aShip [

	^ lappedShips detect: [ :lap | lap ship = aShip ]
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

	| cellCount lap |
	
	cellCount := board cellCount.

	(oldPosition + someSteps) < cellCount ifTrue: [ ^ self ].
	
	lap := self lapTrackerFor: aShip.
	lap addLap.
]

{ #category : 'process actions' }
Game >> rollAndMoveCurrentShip [
    | steps newPosition |
    lastPreviousPosition := self currentShip position.
    steps := dice roll.
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

        ^ ShipStatus
                for: aShip
                position: (board positionOf: aShip)
                laps: (self lapTrackerFor: aShip) lapCount
                penalized: (self isPenalized: aShip).
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

{ #category : 'accessing' }
Game >> currentPlayerIndex [

    ^ self currentTurnIndex
]

{ #category : 'accessing' }
Game >> die [

    ^ dice
]

{ #category : 'accessing' }
Game >> penaltyShip [

    ^ penalizedShips
]
