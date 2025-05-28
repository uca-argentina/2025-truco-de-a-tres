Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
SpaceshipTest >> testFuelConsumptionOnMovement [
    | ship |
    ship := Spaceship withName: 'Test' and: 5. "maxFuel = 10"
    ship moveTo: 3.
    self assert: ship fuel equals: 7. "Consume 3 unidades"
]

{ #category : 'tests - instance' }
SpaceshipTest >> testFuelRestoreOnPassTurn [

	| ships ship1 ship2 game dice1 dicesGame boardGame|
	
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with:
		             (OrderedCollection with: dice1).
	ship1 := Spaceship withName: 'Test' and: dicesGame maxRoll.
	ship2 := Spaceship withName: 'Test' and: dicesGame maxRoll.
	ship1 moveTo: 3.
	
	boardGame := Board withCells: 10 andWormholes: #().
	
	ships := OrderedCollection with: ship1 with: ship2.
	game := Game
		        startWithShips: ships
		        board: boardGame
		        dice: dicesGame.

	game passTurn.
	self assert: ship1 fuel equals: 12
]

{ #category : 'tests - instance' }
SpaceshipTest >> testHasNotReachedGoalWhenBehind [
    | board spaceship |
    board := Board withCells: 10 andWormholes: #().
    spaceship := Spaceship withName: 'Endeavour' and: 3.

    spaceship moveTo: 9.

    self deny: (spaceship hasReachedGoalOn: board).

]

{ #category : 'tests - instance' }
SpaceshipTest >> testHasReachedGoalWhenAtGoal [
    | board spaceship |
    board := Board withCells: 10 andWormholes: #().
    spaceship := Spaceship withName: 'Orion' and: 4.

    spaceship moveTo: 10.

    self assert: (spaceship hasReachedGoalOn: board).

]

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeInPositionZero [

	|player |
	player := Spaceship withName: 'JohnDoe' and: 6.
	
	self assert: player position equals: 0. 
]

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeWithEmptyNameRaisesError [
	| errorThrown |
	
	errorThrown := [ Spaceship withName: '' and: 45] on: Error do: [ :e | e ].

	self assert: errorThrown messageText equals: 'Name cannot be empty'.

]
