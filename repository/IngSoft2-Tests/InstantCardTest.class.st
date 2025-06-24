Class {
	#name : 'InstantCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
InstantCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [
    self
        should: anErrorBlock
        raise: anErrorClass
        withExceptionDo: [ :error | self assert: error messageText equals: errorMessage ].
]

{ #category : 'tests' }
InstantCardTest >> testApplyEffectToIsAbstract [
    | card |
    card := InstantCard new.
    self should: [ card applyEffectTo: (Spaceship withName: 'Ship') inGame: nil ] raise: Error.
]

{ #category : 'tests' }
InstantCardTest >> testPlayOnInvokesApplyEffect [
    | ship1 ship2 board dice game card |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    board := Board of: 5 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    card := MockInstantCard new.
    card playOn: ship1 inGame: game.
    self assert: card applied.
]

{ #category : 'tests' }
InstantCardTest >> testPlayOnRaisesErrorWhenGameFinished [
    | ship1 ship2 board dice game card |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    board := Board of: 1 andWormholeAt: #().
    dice := DiceCup with: { Die withSides: 6 }.
    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.
    game playTurn.
    game checkWinCondition.
    card := InstantCard new.
    self
        should: [ card playOn: ship2 inGame: game ]
        raise: Error
        withMessageText: 'Game is already over'.
]
