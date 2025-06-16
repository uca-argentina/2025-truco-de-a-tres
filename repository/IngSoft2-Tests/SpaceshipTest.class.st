Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
SpaceshipTest >> testHasNotReachedGoalWhenBehind [
    | board spaceship |

    board := Board of: 10 andWormholeAt: #().

    spaceship := Spaceship withName: 'Endeavour' and: 4.

    spaceship moveTo: 9.

    self deny: (spaceship hasReachedGoalOn: board).

]

{ #category : 'tests - instance' }
SpaceshipTest >> testHasReachedGoalWhenAtGoal [
    | board spaceship |

    board := Board of: 10 andWormholeAt: #().

    spaceship := Spaceship withName: 'Orion' and: 4.

    spaceship moveTo: 10.

    self assert: (spaceship hasReachedGoalOn: board).

]

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeInPositionZero [

	|player |
	player := Spaceship withName: 'JohnDoe' and: 4.
	
	self assert: player position equals: 0. 
]

{ #category : 'tests - instance' }
SpaceshipTest >> testInitializeWithEmptyNameRaisesError [
	| errorThrown |
	
	errorThrown := [ Spaceship withName: '' and: 4 ] on: Error do: [ :e | e ].

	self assert: errorThrown messageText equals: 'Name cannot be empty'.

]
