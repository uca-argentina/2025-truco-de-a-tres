Class {
    #name : 'AdvanceCard',
    #superclass : 'InstantCard',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AdvanceCard >> applyEffectTo: aShip inGame: aGame [
    aGame board moveShip: aShip forward: 1.
]
