Class {
	#name : 'MoonWalkEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkEffectTest >> testApplyToDoesNothing [

    | effect ship originalPosition |

    effect := MoonWalkEffect new.
    ship := Spaceship withName: 'TestShip'.

    originalPosition := ship position.
    effect applyTo: ship.
    
    self assert: ship position equals: originalPosition.
]

{ #category : 'tests' }
MoonWalkEffectTest >> testApplyToInContextMovesOthersBack [

    | effect ship1 ship2 ship3 allShips |

    effect := MoonWalkEffect new.

    ship1 := Spaceship withName: 'TargetShip'.
    ship2 := Spaceship withName: 'Ship2'.
    ship3 := Spaceship withName: 'Ship3'.

    ship1 moveTo: 5.
    ship2 moveTo: 5.
    ship3 moveTo: 5.

    allShips := { ship1. ship2. ship3 }.

    effect applyTo: ship1 inContextOf: allShips.

    self assert: ship1 position equals: 5.
    self assert: ship2 position equals: 3.
    self assert: ship3 position equals: 3.
]
