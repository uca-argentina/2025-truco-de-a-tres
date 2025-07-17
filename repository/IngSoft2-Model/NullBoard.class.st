Class {
    #name : 'NullBoard',
    #superclass : 'Object',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'spaceships' }
NullBoard >> moveShip: aShip to: aPosition [
    aShip moveTo: aPosition.
]

{ #category : 'spaceships' }
NullBoard >> moveShip: aShip backward: steps [
    aShip moveBack: steps.
]

{ #category : 'spaceships' }
NullBoard >> moveShip: aShip forward: steps [
    aShip moveForward: steps.
]
