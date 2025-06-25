Class {
	#name : 'ShipStatus',
	#superclass : 'Object',
	#instVars : [
		'ship',
		'position',
		'lapCount',
		'penalized'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipStatus class >> for: aShip position: aPosition laps: aLapCount penalized: isPenalized [

	^ self new
		initializeWith: aShip
		position: aPosition
		laps: aLapCount
		penalized: isPenalized.
]

{ #category : 'accessing' }
ShipStatus >> addLap [
	lapCount := lapCount + 1.
]

{ #category : 'accessing' }
ShipStatus >> hasWonWithTotalLaps: aNumber [
	^ lapCount >= aNumber.
]

{ #category : 'initialization' }
ShipStatus >> initializeWith: aShip position: aPosition laps: aLapCount penalized: isPenalized [

	ship := aShip.
	position := aPosition.
	lapCount := aLapCount.
	penalized := isPenalized.
]

{ #category : 'accessing' }
ShipStatus >> isPenalized [

	^ penalized.
]

{ #category : 'accessing' }
ShipStatus >> lapCount [

	^ lapCount.
]

{ #category : 'accessing' }
ShipStatus >> penalized: aBoolean [
	penalized := aBoolean.
]

{ #category : 'accessing' }
ShipStatus >> position [

	^ position.
]

{ #category : 'accessing' }
ShipStatus >> position: aPosition [
	position := aPosition.
]

{ #category : 'accessing' }
ShipStatus >> ship [

	^ ship.
]
