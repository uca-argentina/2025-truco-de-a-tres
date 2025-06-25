Class {
	#name : 'TurnManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TurnManagerTest >> testAdvanceTurnCyclesAndIncrementsTurn [
	| ship1 ship2 manager |
    ship1 := Spaceship withName: 'A'.
    ship2 := Spaceship withName: 'B'.
    manager := TurnManager withShips: { ship1 . ship2 }.
    manager advanceTurn.
    self assert: manager currentTurnIndex equals: 2.
    self assert: manager turn equals: 2.
    self assert: (manager currentShip == ship2).
    manager advanceTurn.
    self assert: manager currentTurnIndex equals: 1.
    self assert: manager turn equals: 3.
    self assert: (manager currentShip == ship1).
]

{ #category : 'tests' }
TurnManagerTest >> testInitializeWithShipsReturnsSelf [
	| ship1 ship2 manager result |
    ship1 := Spaceship withName: 'X'.
    ship2 := Spaceship withName: 'Y'.
    manager := TurnManager new.
    result := manager initializeWithShips: { ship1 . ship2 }.
    self assert: (result == manager).
    self assert: manager currentTurnIndex equals: 1.
    self assert: manager turn equals: 1.
    self assert: (manager currentShip == ship1).
]

{ #category : 'tests' }
TurnManagerTest >> testWithShipsInitializesCorrectly [
	| ship1 ship2 manager |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    manager := TurnManager withShips: { ship1 . ship2 }.
    self assert: manager turn equals: 1.
    self assert: manager currentTurnIndex equals: 1.
    self assert: (manager currentShip == ship1).
]
