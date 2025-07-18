Class {
    #name : 'NullBoardTest',
    #superclass : 'TestCase',
    #category : 'IngSoft2-Tests',
    #package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipBackwardMovesShipProperly [
    | board ship |
    board := NullBoard new.
    ship := Spaceship withName: 'Voyager'.
    ship moveTo: 3.
    board moveShip: ship backward: 2.
    self assert: ship position equals: 1.
]

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipForwardMovesShipProperly [
    | board ship |
    board := NullBoard new.
    ship := Spaceship withName: 'Enterprise'.
    board moveShip: ship forward: 3.
    self assert: ship position equals: 3.
]

{ #category : 'tests - instance' }
NullBoardTest >> testMoveShipToSetsExactPosition [
    | board ship |
    board := NullBoard new.
    ship := Spaceship withName: 'Discovery'.
    board moveShip: ship to: 5.
    self assert: ship position equals: 5.
]
