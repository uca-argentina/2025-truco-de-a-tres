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
