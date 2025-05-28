Class {
	#name : 'MoonWalkEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
MoonWalkEffect >> applyTo: aSpaceship [
	"By default, this does nothing. Real logic is in applyTo:inContextOf:"
	^ self

]

{ #category : 'operations' }
MoonWalkEffect >> applyTo: aSpaceship inContextOf: allSpaceships [
	allSpaceships do: [:ship |
		ship = aSpaceship ifFalse: [ ship moveBack: 2 ]].
]

{ #category : 'operations' }
MoonWalkEffect >> applyTo: aSpaceship inGame: aGame [
    | stepsBack |
    stepsBack := 2.

    aGame spaceShips do: [:ship |
        ship == aSpaceship ifFalse: [
            | requiredFuel |
            requiredFuel := stepsBack min: ship position.

            (ship hasFuelFor: requiredFuel)
                ifTrue: [
                    "Consumo explícito (opcional)"
                    ship consumeFuel: requiredFuel.
                    ship moveBack: requiredFuel
                ]
                ifFalse: [
                    ship resetPosition.
                    aGame penalize: ship forTurns: 2
                ]
        ]
    ]
]
