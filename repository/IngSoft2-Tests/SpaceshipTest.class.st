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
    
    die := Die withSides: 1.
    spaceship := Spaceship withName: 'Apollo'.

    spaceship advanceWith: die on: board.

    self assert: spaceship position equals: 1.

]

{ #category : 'tests - instance' }
SpaceshipTest >> testAdvanceWithWormholeTransport [
    | die board wormholes spaceship |
    
    wormholes := Dictionary new.
    wormholes at: 1 put: 10.
    board := Board new initializeWithCells: 30 wormholes: wormholes.
    
    die := Die withSides: 1.
	 spaceship := Spaceship withName: 'Vostok'.


    spaceship advanceWith: die on: board.

    self assert: spaceship position equals: 10.

]

{ #category : 'tests - instance' }
SpaceshipTest >> testHasNotReachedGoalWhenBehind [
    | board spaceship |
    board := Board new initializeWithCells: 10 wormholes: Dictionary new.
    spaceship := Spaceship withName: 'Endeavour'.

    spaceship moveTo: 9.

    self deny: (spaceship hasReachedGoalOn: board).

]

{ #category : 'tests - instance' }
SpaceshipTest >> testHasReachedGoalWhenAtGoal [
    | board spaceship |
    board := Board new initializeWithCells: 10 wormholes: Dictionary new.
    spaceship := Spaceship withName: 'Orion'.

    spaceship moveTo: 10.

    self assert: (spaceship hasReachedGoalOn: board).

]

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeInPositionZero [

	|player |
	player := Spaceship withName: 'JohnDoe'.
	
	self assert: player position equals: 0. 
]

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeWithEmptyNameRaisesError [
	| errorThrown |
	
	errorThrown := [ Spaceship withName: '' ] on: Error do: [ :e | e ].

	self assert: errorThrown messageText equals: 'Name cannot be empty'.

]
