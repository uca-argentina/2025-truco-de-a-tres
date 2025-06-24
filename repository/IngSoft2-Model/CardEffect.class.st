Class {
    #name : 'CardEffect',
    #superclass : 'EffectDecorator',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'operations' }
CardEffect >> applyEffectTo: aSpaceship inBoard: aBoard [
    aSpaceship addCard: CardDeck randomCard.
]
