Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeInPositionZero [

	|player |
	player := Spaceship new initializeWith: 'JohnDoe'.
	
	self assert: player position equals: 0.
]

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeWithEmptyNameRaisesError [

	self "verify that the error shows and that it's the expected error if playerName is empty"
		should: [ Spaceship new initializeWith: '' ]
		raise: Error
		description: 'El nombre no puede estar vacío'
]
