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
                'activeCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Spaceship class >> withName: aName [

	^ self new initializeWith: aName.
]

{ #category : 'initialize' }
Spaceship >> hasReachedGoalOn: aBoard [

    ^ aBoard isPositionReachedAt: position.

]

{ #category : 'initialize' }
Spaceship >> initializeWith: aName [

	aName isEmpty ifTrue: [ self error: 'Name cannot be empty' ].

	playerName := aName.
	position := 0.
	fuel := 0.
        maxFuel := 0.
        lap := 0.
        cards := OrderedCollection new.
        activeCards := OrderedCollection new.
]

{ #category : 'initialize' }
Spaceship >> lap [

	^ lap.

]

{ #category : 'methods' }
Spaceship >> moveBack: steps [

    position := (position - steps) max: 0.

]

{ #category : 'methods' }
Spaceship >> moveForward: steps [

	position := position + steps.

]

{ #category : 'methods' }
Spaceship >> moveTo: aPosition [

    position := aPosition.

]

{ #category : 'accessing' }
Spaceship >> name [
    ^ playerName.
]

{ #category : 'initialize' }
Spaceship >> position [

    ^ position.
]

{ #category : 'methods' }
Spaceship >> restoreFuel [

        fuel := maxFuel.
]


{ #category : 'cards' }
Spaceship >> addCard: aCard [
        cards add: aCard.
]

{ #category : 'cards' }
Spaceship >> removeCard: aCard [
        cards remove: aCard ifAbsent: [ ].
]

{ #category : 'cards' }
Spaceship >> cards [
        ^ cards
]

{ #category : 'cards' }
Spaceship >> addActiveCard: aCard [
        activeCards add: aCard.
]

{ #category : 'cards' }
Spaceship >> activeCards [
        ^ activeCards
{ #category : 'fuel' }
Spaceship >> increaseMaxFuelBy: anAmount [
    maxFuel := maxFuel + anAmount.
]

{ #category : 'fuel' }
Spaceship >> decreaseFuelBy: anAmount [
    fuel := (fuel - anAmount) max: 0.

]
