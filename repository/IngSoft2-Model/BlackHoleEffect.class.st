Class {
	#name : 'BlackHoleEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
BlackHoleEffect >> applyTo: aSpaceship inGame: aGame [
    | stepsBack requiredFuel |
    stepsBack := 4. "Retroceso fijo de 4 casilleros"
    
    requiredFuel := stepsBack min: aSpaceship position.
    
    (aSpaceship hasFuelFor: requiredFuel)
        ifTrue: [ "Tiene suficiente combustible"            
            aSpaceship moveBack: stepsBack 
        ]
        ifFalse: [  "Sin combustible"
            aSpaceship resetPosition.
            aGame penalize: aSpaceship forTurns: 2.
        ]
]
