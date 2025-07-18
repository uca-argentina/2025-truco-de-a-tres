Class {
	#name : 'RedoCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RedoCardTest >> testPlayOnRepeatsLastCardEffect [
    | board dice ship1 ship2 game advanceCard redoCard |
    board := Board of: 10 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    advanceCard := AdvanceCard new.
    redoCard := RedoCard new.
    ship1 addCard: advanceCard.
    ship1 addCard: redoCard.

    ship1 playCard: advanceCard inGame: game.
    self assert: ship1 position equals: 1.

    ship1 playCard: redoCard inGame: game.

    self assert: ship1 position equals: 2.
    self assert: game lastCardPlayed class equals: RedoCard.
]

{ #category : 'tests' }
RedoCardTest >> testPlayOnWithNoLastCardDoesNothing [
    | board dice ship1 ship2 game redoCard |
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    redoCard := RedoCard new.
    ship1 addCard: redoCard.

    ship1 playCard: redoCard inGame: game.

    self assert: ship1 position equals: 0.
    self assert: game lastCardPlayed class equals: RedoCard.
]
{ #category : 'tests' }
RedoCardTest >> testPlayOnReplaysAccelerationCard [
    | board dice ship1 ship2 game accelCard redoCard |
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    accelCard := AccelerationCard new.
    game lastCardPlayed: accelCard.
    redoCard := RedoCard new.
    ship1 addCard: redoCard.

    ship1 playCard: redoCard inGame: game.

    self assert: (ship1 activeCards includes: accelCard).
    self assert: game lastCardPlayed class equals: RedoCard.
]
{ #category : 'tests' }
RedoCardTest >> testPlayOnReplaysAllyCard [
    | board dice ship1 ship2 game allyCard redoCard |
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    allyCard := AllyCard withAlly: ship2.
    game lastCardPlayed: allyCard.
    redoCard := RedoCard new.
    ship1 addCard: redoCard.

    ship1 playCard: redoCard inGame: game.

    self assert: (ship1 activeCards includes: allyCard).
    self assert: (ship2 activeCards includes: allyCard).
    self assert: game lastCardPlayed class equals: RedoCard.
]
{ #category : 'tests' }
RedoCardTest >> testPlayOnReplaysCancellationCard [
    | board dice ship1 ship2 game target card redoCard |
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    target := ShieldCard new.
    ship1 addActiveCard: target.
    card := CancellationCard cancelling: target.
    game lastCardPlayed: card.
    redoCard := RedoCard new.
    ship1 addCard: redoCard.

    ship1 playCard: redoCard inGame: game.

    self deny: (ship1 activeCards includes: target).
    self assert: game lastCardPlayed class equals: RedoCard.
]
{ #category : 'tests' }
RedoCardTest >> testPlayOnReplaysOverloadCard [
    | board dice ship1 ship2 game card redoCard |
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    card := OverloadCard forShip: ship1.
    game lastCardPlayed: card.
    redoCard := RedoCard new.
    ship1 addCard: redoCard.

    ship1 playCard: redoCard inGame: game.

    self assert: (ship1 activeCards includes: card).
    self assert: game lastCardPlayed class equals: RedoCard.
]
{ #category : 'tests' }
RedoCardTest >> testPlayOnReplaysRepeatCard [
    | board dice ship1 ship2 game card redoCard |
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    card := RepeatCard new.
    game lastCardPlayed: card.
    redoCard := RedoCard new.
    ship1 addCard: redoCard.

    ship1 playCard: redoCard inGame: game.

    self assert: ship1 position equals: 0.
    self assert: game lastCardPlayed class equals: RedoCard.
]
{ #category : 'tests' }
RedoCardTest >> testPlayOnReplaysShieldCard [
    | board dice ship1 ship2 game card redoCard |
    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    game := Game
        startWithShips: { ship1. ship2 }
        board: board
        dice: dice
        laps: 1.

    card := ShieldCard new.
    game lastCardPlayed: card.
    redoCard := RedoCard new.
    ship1 addCard: redoCard.

    ship1 playCard: redoCard inGame: game.

    self assert: (ship1 activeCards includes: card).
    self assert: game lastCardPlayed class equals: RedoCard.
]

