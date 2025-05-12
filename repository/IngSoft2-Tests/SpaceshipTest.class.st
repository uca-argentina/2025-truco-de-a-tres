Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
SpaceshipTest >> testAdvanceWithDieAndBoard [
    | die board wormholes spaceship |
    
    wormholes := Dictionary new.
    wormholes at: 5 put: 20.
    board := Board new initializeWithCells: 30 wormholes: wormholes.
    
    die := Die new initializeWithSides: 1.
    spaceship := Spaceship new initializeWith: 'Apollo'.

    spaceship advanceWith: die on: board.

    self assert: spaceship position equals: 1.

]

{ #category : 'tests - instance' }
SpaceshipTest >> testAdvanceWithWormholeTransport [
    | die board wormholes spaceship |
    
    wormholes := Dictionary new.
    wormholes at: 1 put: 10.
    board := Board new initializeWithCells: 30 wormholes: wormholes.
    
    die := Die new initializeWithSides: 1.
	 spaceship := Spaceship new initializeWith: 'Vostok'.


    spaceship advanceWith: die on: board.

    self assert: spaceship position equals: 10.

]

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
