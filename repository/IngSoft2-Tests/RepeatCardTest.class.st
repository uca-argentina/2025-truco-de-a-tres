Class {
    #name : 'RepeatCardTest',
    #superclass : 'TestCase',
    #category : 'IngSoft2-Tests',
    #package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RepeatCardTest >> testApplyEffectDelegatesToGame [
    | card ship game |
    card := RepeatCard new.
    ship := Spaceship withName: 'Enterprise'.
    game := RepeatCardTestGame new.

    card applyEffectTo: ship inGame: game.

    self assert: game receivedShip equals: ship.
]

{ #category : 'tests' }
RepeatCardTest >> testPlayOnDelegatesToApplyEffect [
    | card ship game |
    card := RepeatCard new.
    ship := Spaceship withName: 'Voyager'.
    game := RepeatCardTestGame new.

    card playOn: ship inGame: game.

    self assert: game receivedShip equals: ship.
]
