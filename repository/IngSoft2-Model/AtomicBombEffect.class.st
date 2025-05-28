Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship inGame: aGame [
	aGame spaceShips do: [ :ship | ship moveTo: 0 ]

]
