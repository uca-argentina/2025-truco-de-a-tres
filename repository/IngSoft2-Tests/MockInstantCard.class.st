Class {
    #name : 'MockInstantCard',
    #superclass : 'InstantCard',
    #instVars : [ 'applied' ],
    #category : 'IngSoft2-Tests',
    #package : 'IngSoft2-Tests'
}

{ #category : 'playing' }
MockInstantCard >> applyEffectTo: aShip inGame: aGame [
    applied := true.
]

{ #category : 'accessing' }
MockInstantCard >> applied [
    ^ applied
]
