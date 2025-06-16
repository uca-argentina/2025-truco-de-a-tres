Class {
	#name : 'DiceCupTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceCupTest >> testInitializationWithoutDiceRaisesError [

    self should: [ DiceCup with: #() ] raise: Error.
]

{ #category : 'tests' }
DiceCupTest >> testRollReturnsSumOfRolls [

    | die1 die2 cup total |

    die1 := Die withSides: 1.
    die2 := Die withSides: 1.
    cup := DiceCup with: { die1. die2 }.

    total := cup roll.
    self assert: total equals: 2.
]

{ #category : 'tests' }
DiceCupTest >> testValidInitializationWithDice [

    | die1 die2 cup |

    die1 := Die withSides: 3.
    die2 := Die withSides: 4.
    cup := DiceCup with: { die1. die2 }.

    self assert: cup maxRoll equals: 7.
]
