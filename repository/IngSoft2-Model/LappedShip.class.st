Class {
	#name : 'LappedShip',
	#superclass : 'Object',
        #instVars : [
                'ship',
                'laps',
                'position'
        ],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
LappedShip class >> for: aShip [

        ^ self new initializeWith: aShip.
]

{ #category : 'instance creation' }
LappedShip class >> for: aShip at: aPosition [

        ^ self new initializeWith: aShip position: aPosition.
]

{ #category : 'adding' }
LappedShip >> addLap [

	laps := laps + 1.
]

{ #category : 'testing' }
LappedShip >> hasWonWithTotalLaps: aNumber [

	^ laps >= aNumber.
]

{ #category : 'initialize' }
LappedShip >> initializeWith: aShip [

        ^ self initializeCommonWith: aShip position: aShip position.
]

{ #category : 'initialize' }
LappedShip >> initializeWith: aShip position: aPosition [

        ^ self initializeCommonWith: aShip position: aPosition.
]

{ #category : 'initialize' }
LappedShip >> initializeCommonWith: aShip position: aPosition [
        ship := aShip.
        laps := 0.
        position := aPosition.

        ^ self.
]

{ #category : 'testing' }
LappedShip >> lapCount [

	^ laps.
]

{ #category : 'adding' }
LappedShip >> ship [

        ^ ship.
]

{ #category : 'accessing' }
LappedShip >> position [

        ^ position.
]

{ #category : 'accessing' }
LappedShip >> moveTo: aPosition [

        position := aPosition.
        ship moveTo: aPosition.
]
