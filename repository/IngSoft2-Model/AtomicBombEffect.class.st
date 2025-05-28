Class {
	#name : 'AtomicBombEffect',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship [
	"Este efecto requiere contexto, por lo que este método no hace nada directo"
	^ self

]

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship inContextOf: allSpaceships [
	allSpaceships do: [:ship | ship moveTo: 0 ].

]

{ #category : 'operations' }
AtomicBombEffect >> applyTo: aSpaceship inGame: aGame [
	aGame spaceShips do: [ :ship | ship moveTo: 0 ]

]
