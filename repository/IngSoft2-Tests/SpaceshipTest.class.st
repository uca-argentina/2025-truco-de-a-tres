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

    self should: [ Spaceship withName: '' and: 4 ] raise: Error.
]

{ #category : 'tests - instance' }
SpaceshipTest >> testMoveBackDoesNotGoBelowZero [

    | ship |

    ship := Spaceship withName: 'Probe' and: 4.
    ship moveBack: 5.

    self assert: ship position equals: 0.
]

{ #category : 'tests - instance' }
SpaceshipTest >> testMoveForwardIncreasesPosition [

    | ship |

    ship := Spaceship withName: 'Runner' and: 4.
    ship moveForward: 3.

    self assert: ship position equals: 3.
]

{ #category : 'tests - instance' }
SpaceshipTest >> testMoveToChangesPosition [

    | ship |

    ship := Spaceship withName: 'Move' and: 4.
    ship moveTo: 5.

    self assert: (ship position) equals: 5.
]

{ #category : 'tests - instance' }
SpaceshipTest >> testNewRaisesError [

    self should: [ Spaceship new ] raise: Error.
]

{ #category : 'tests - instance' }
SpaceshipTest >> testRestoreFuelRestoresToMax [

    | ship |

    ship := Spaceship withName: 'Tank' and: 5.
    ship restoreFuel.

    self assert: (ship instVarNamed: 'fuel') equals: (ship instVarNamed: 'maxFuel').
]
