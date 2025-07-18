Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'playerName',
		'maxFuel',
		'fuel',
		'lap',
		'cards',
		'activeCards',
		'state'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Spaceship class >> validatingName: aName [
	
	aName isEmpty ifTrue: [ self error: 'A name cannot be empty' ].
]

{ #category : 'initialize' }
Spaceship class >> withName: aName [

	self validatingName: aName.
	^ self new initializeWith: aName
]

{ #category : 'methods' }
Spaceship >> activeCards [
	^ activeCards
]

{ #category : 'methods' }
Spaceship >> addActiveCard: aCard [
	activeCards add: aCard.
]

{ #category : 'methods' }
Spaceship >> addCard: aCard [
	cards add: aCard.
]

{ #category : 'methods' }
Spaceship >> cards [
	^ cards
]

{ #category : 'fuel' }
Spaceship >> decreaseFuelBy: anAmount [
    fuel := (fuel - anAmount) max: 0.
]

{ #category : 'initialize' }
Spaceship >> hasReachedGoalOn: aBoard [

    ^ aBoard isPositionReachedAt: position.

]

{ #category : 'fuel' }
Spaceship >> increaseMaxFuelBy: anAmount [
    maxFuel := maxFuel + anAmount.
]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName [

	playerName := aName.
	position := 0.
	fuel := 0.
	maxFuel := 0.
        lap := 0.
        cards := OrderedCollection new.
        activeCards := OrderedCollection new.
        state := NormalShipState new
]

{ #category : 'state' }
Spaceship >> isPenalized [

	^ state isPenalized

]

{ #category : 'initialize' }
Spaceship >> lap [

	^ lap
]

{ #category : 'methods' }
Spaceship >> moveBack: steps [

	position := position - steps max: 0
]

{ #category : 'methods' }
Spaceship >> moveForward: steps [

	position := position + steps
]

{ #category : 'methods' }
Spaceship >> moveTo: aPosition [

    position := aPosition.

]

{ #category : 'accessing' }
Spaceship >> name [

	^ playerName
]

{ #category : 'state' }
Spaceship >> penalizeFor: aNumber [

	state := state penalizeFor: aNumber
]

{ #category : 'state' }
Spaceship >> penaltyTurnsRemaining [

	^ state turnsRemaining
]

{ #category : 'state' }
Spaceship >> penalizeFor: aNumber [
    state := state penalizeFor: aNumber.
]

{ #category : 'state' }
Spaceship >> penaltyTurnsRemaining [
    ^ state turnsRemaining.
]

{ #category : 'cards' }
Spaceship >> playCard: aCard inGame: aGame [

	aGame ensureGameIsNotOver.
	(cards includes: aCard) ifFalse: [ self error: 'Card not in hand' ].
	aCard playOn: self inGame: aGame.
	self removeCard: aCard.
	aGame lastCardPlayed: aCard
]

{ #category : 'initialize' }
Spaceship >> position [

    ^ position.
]

{ #category : 'state' }
Spaceship >> reducePenalty [

	state := state reducePenalty

]

{ #category : 'cards' }
Spaceship >> removeCard: aCard [

	cards remove: aCard ifAbsent: [  ]
]

{ #category : 'methods' }
Spaceship >> restoreFuel [

        fuel := maxFuel.
]

{ #category : 'state' }
Spaceship >> state [

	^ state
]

{ #category : 'state' }
Spaceship >> state: aState [

	state := aState
]
