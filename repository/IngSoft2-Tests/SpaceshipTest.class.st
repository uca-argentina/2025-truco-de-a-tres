Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
SpaceshipTest >> testAdvanceWithDieAndBoard [
    | die board spaceship |
    
    board := Board withCells: 30 andWormholes: (OrderedCollection with: (Wormhole from: 5 to: 20)).

    die := Die withSides: 1.
    spaceship := Spaceship withName: 'Apollo'.

    spaceship advanceWith: die on: board.

    self assert: spaceship position equals: 1.

]

{ #category : 'tests - instance' }
SpaceshipTest >> testAdvanceWithWormholeTransport [
    | die board spaceship |

    board := Board withCells: 30 andWormholes: (OrderedCollection with: (Wormhole from: 1 to: 10)).

    die := Die withSides: 1.
    spaceship := Spaceship withName: 'Vostok'.

    spaceship advanceWith: die on: board.

    self assert: spaceship position equals: 10.

]

{ #category : 'tests - instance' }
SpaceshipTest >> testHasNotReachedGoalWhenBehind [
    | board spaceship |
    board := Board withCells: 10 andWormholes: #().
    spaceship := Spaceship withName: 'Endeavour'.

    spaceship moveTo: 9.

    self deny: (spaceship hasReachedGoalOn: board).

]

{ #category : 'tests - instance' }
SpaceshipTest >> testHasReachedGoalWhenAtGoal [
    | board spaceship |
    board := Board withCells: 10 andWormholes: #().
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
