Class {
    #name : 'PermanentCardTest',
    #superclass : 'TestCase',
    #category : 'IngSoft2-Tests',
    #package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
PermanentCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error |
            self assert: error messageText equals: errorMessage].

]

{ #category : 'tests' }
PermanentCardTest >> testActivateForRaisesError [
    | card |
    card := PermanentCard new.
    self should: [ card activateFor: (Spaceship withName: 'Pilot') inGame: nil ] raise: Error.
]

{ #category : 'tests' }
PermanentCardTest >> testPlayOnActivatesCardWhenCurrentPlayer [
    | ship1 ship2 board dice game card |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    board := Board of: 5 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    card := OverloadCard forShip: ship1.
    card playOn: ship1 inGame: game.
    self assert: (ship1 activeCards includes: card).
]

{ #category : 'tests' }
PermanentCardTest >> testPlayOnRaisesErrorIfGameFinished [
    | ship1 ship2 board dice game card |
    ship1 := Spaceship withName: 'First'.
    ship2 := Spaceship withName: 'Second'.
    board := Board of: 2 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    game playUntilFinish.
    card := OverloadCard forShip: ship1.
    self
        should: [ card playOn: ship1 inGame: game ]
        raise: Error
        withMessageText: 'Game is already over'.
]

{ #category : 'tests' }
PermanentCardTest >> testPlayOnRaisesErrorIfNotPlayersTurn [
    | ship1 ship2 board dice game card |
    ship1 := Spaceship withName: 'Alpha'.
    ship2 := Spaceship withName: 'Beta'.
    board := Board of: 5 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    card := OverloadCard forShip: ship2.
    self
        should: [ card playOn: ship2 inGame: game ]
        raise: Error
        withMessageText: 'Not your turn'.
]
