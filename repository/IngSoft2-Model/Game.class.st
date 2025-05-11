Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dice',
		'turn',
		'winner',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Game >> initialize [
	super initialize.
	ships := OrderedCollection new.
	dice := OrderedCollection new.
	turn := 1.
	winner := nil.
]

{ #category : 'initialization' }
Game >> initializeWithShips: someShips board: aBoard dice: someDice [
    ships := someShips asOrderedCollection.
    board := aBoard.
    dice := someDice asOrderedCollection.
    turn := 1.
    winner := nil.
]

{ #category : 'as yet unclassified' }
Game >> withShips: someShips board: aBoard dice: someDices [
    ^ self new
        initializeWithShips: someShips board: aBoard dice: someDices;
        yourself.
]
