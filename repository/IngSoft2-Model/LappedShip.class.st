Class {
	#name : 'LappedShip',
	#superclass : 'Object',
	#instVars : [
		'ship',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
LappedShip class >> for: aShip [
	^ self new initializeWith: aShip
]

{ #category : 'adding' }
LappedShip >> addLap [

	laps := laps + 1
]

{ #category : 'testing' }
LappedShip >> hasWonWithTotalLaps: aNumber [

	^ laps >= aNumber
]

{ #category : 'initialize' }
LappedShip >> initializeWith: aShip [

	ship := aShip.
	laps := 0.
	^ self
]

{ #category : 'testing' }
LappedShip >> lapCount [

	^ laps
]

{ #category : 'adding' }
LappedShip >> ship [ 
^ship
]
