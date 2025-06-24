Class {
	#name : 'AccelerationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AccelerationCardTest >> testActivateForAddsCardToShipActiveCards [
    | ship card |
    ship := Spaceship withName: 'TestShip'.
    card := AccelerationCard new.
    card activateFor: ship inGame: nil.
    self assert: (ship activeCards includes: card).
]

{ #category : 'tests' }
AccelerationCardTest >> testModifyRollAddsOne [
    | card result |
    card := AccelerationCard new.
    result := card modifyRoll: 3 forShip: (Spaceship withName: 'Pilot') inGame: nil.
    self assert: result equals: 4.
]
