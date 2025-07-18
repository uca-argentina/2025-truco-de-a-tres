Class {
	#name : 'ShipPosition',
	#superclass : 'Object',
	#instVars : [
		'ship',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShipPosition class >> for: aShip [

	^ self ship: aShip position: aShip position
]

{ #category : 'initialization' }
ShipPosition class >> ship: aShip position: aPosition [

	^ self new initializeWithShip: aShip position: aPosition
]

{ #category : 'accessing' }
ShipPosition >> initializeWithShip: aShip position: aPosition [

	ship := aShip.
	position := aPosition.
	^ self
]

{ #category : 'testing' }
ShipPosition >> isGreaterThan: anotherShipPosition [

	^ position > anotherShipPosition position
]

{ #category : 'testing' }
ShipPosition >> isLessThan: anotherShipPosition [

	^ position < anotherShipPosition position
]

{ #category : 'accessing' }
ShipPosition >> position [

	^ position
]

{ #category : 'accessing' }
ShipPosition >> ship [

	^ ship
]

{ #category : 'accessing' }
ShipPosition >> position [
    ^ position
]

{ #category : 'accessing' }
ShipPosition >> ship [
    ^ ship
]
