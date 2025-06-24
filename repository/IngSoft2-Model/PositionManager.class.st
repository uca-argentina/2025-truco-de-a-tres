Class {
    #name : 'PositionManager',
    #superclass : 'Object',
    #instVars : [
        'positions'
    ],
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
PositionManager class >> forShips: someShips [
    ^ self new initializeForShips: someShips
]

{ #category : 'initialization' }
PositionManager >> initializeForShips: someShips [
    positions := Dictionary new.
    someShips do: [ :ship | positions at: ship put: ship position ].
    ^ self
]

{ #category : 'accessing' }
PositionManager >> positionOf: aShip [
    ^ positions at: aShip
]

{ #category : 'updating' }
PositionManager >> moveShip: aShip to: aPosition [
    positions at: aShip put: aPosition.
    aShip moveTo: aPosition.
]

{ #category : 'updating' }
PositionManager >> moveShip: aShip forward: steps [
    self moveShip: aShip to: ((self positionOf: aShip) + steps)
]

{ #category : 'updating' }
PositionManager >> moveShip: aShip backward: steps [
    | newPos |
    newPos := (self positionOf: aShip) - steps.
    newPos < 0 ifTrue: [ newPos := 0 ].
    self moveShip: aShip to: newPos
]
