Class {
    #name : 'ShieldCard',
    #superclass : 'PermanentCard',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'playing' }
ShieldCard >> activateFor: aShip inGame: aGame [
    aShip addActiveCard: self.
]
