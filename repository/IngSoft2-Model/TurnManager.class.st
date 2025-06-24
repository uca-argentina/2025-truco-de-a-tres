Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'currentIndex',
		'turn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnManager class >> withShips: someShips [
    ^ self new initializeWithShips: someShips.
]

{ #category : 'accessing' }
TurnManager >> advanceTurn [
    currentIndex := currentIndex + 1.
    currentIndex > ships size ifTrue: [ currentIndex := 1 ].
    turn := turn + 1.
]

{ #category : 'accessing' }
TurnManager >> currentShip [
    ^ ships at: currentIndex
]

{ #category : 'accessing' }
TurnManager >> currentTurnIndex [
    ^ currentIndex
]

{ #category : 'initialize' }
TurnManager >> initializeWithShips: someShips [
    ships := someShips.
    currentIndex := 1.
    turn := 1.
    ^ self
]

{ #category : 'accessing' }
TurnManager >> turn [
    ^ turn
]
