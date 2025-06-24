Class {
	#name : 'OverloadCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
OverloadCardTest >> testActivateForAddsCardToShipActiveCards [
	| ship card |
	ship := Spaceship withName: 'Player'.
	card := OverloadCard forShip: ship.
	card activateFor: ship inGame: nil.
	self assert: (ship activeCards includes: card).
]

{ #category : 'tests' }
OverloadCardTest >> testForShipCreatesCardWithTargetShipSet [
	| ship card |
	ship := Spaceship withName: 'Target'.
	card := OverloadCard forShip: ship.
	self assert: (card instVarNamed: 'targetShip') equals: ship.
]

{ #category : 'tests' }
OverloadCardTest >> testInitializeForShipSetsTargetShip [
	| ship card |
	ship := Spaceship withName: 'Alpha'.
	card := OverloadCard new initializeForShip: ship.
	self assert: (card instVarNamed: 'targetShip') equals: ship.
]

{ #category : 'tests' }
OverloadCardTest >> testModifyRollForOtherShipUnchanged [
	| ship1 ship2 card result |
	ship1 := Spaceship withName: 'One'.
	ship2 := Spaceship withName: 'Two'.
	card := OverloadCard forShip: ship1.
	result := card modifyRoll: 4 forShip: ship2 inGame: nil.
	self assert: result equals: 4.
]

{ #category : 'tests' }
OverloadCardTest >> testModifyRollForTargetShipSubtractsTwo [
	| ship card result |
	ship := Spaceship withName: 'One'.
	card := OverloadCard forShip: ship.
	result := card modifyRoll: 5 forShip: ship inGame: nil.
	self assert: result equals: 3.
]
