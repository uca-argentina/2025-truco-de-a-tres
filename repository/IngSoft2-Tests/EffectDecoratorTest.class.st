Class {
	#name : 'EffectDecoratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectDecoratorTest >> testApplyToWithoutWrappedEffectDoesNothing [

    | decorator ship originalPosition |

    decorator := EffectDecorator new.

    ship := Spaceship withName: 'SoloShip' and: 4.
    ship moveTo: 3.

    originalPosition := ship position.

    decorator applyTo: ship.

    self assert: ship position equals: originalPosition.
]
