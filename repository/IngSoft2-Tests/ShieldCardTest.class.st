Class {
	#name : 'ShieldCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShieldCardTest >> testActivateForAddsCardToShipActiveCards [
	| ship card |
    ship := Spaceship withName: 'Defender'.
    card := ShieldCard new.
    card activateFor: ship inGame: nil.
    self assert: (ship activeCards includes: card).
]
