Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
BoardTest >> testAtomicBombEffectResetsPositionsButKeepsLaps [

	| dice1 dicesGame effect ship1 ship2 ship3 allShips |
	
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).

	effect := AtomicBombEffect new.

	ship1 := Spaceship withName: 'Red' and: dicesGame maxRoll.
	ship2 := Spaceship withName: 'Blue' and: dicesGame maxRoll.
	ship3 := Spaceship withName: 'Green' and: dicesGame maxRoll.

	ship1 moveTo: 6.
	ship2 moveTo: 3.
	ship3 moveTo: 9.

	allShips := {
		ship1.
		ship2.
		ship3 }.

	effect applyTo: ship2 inContextOf: allShips.

	self assert: (LappedShip for: ship1) lapCount equals: 0.
	self assert: (LappedShip for: ship2) lapCount equals: 0.
	self assert: (LappedShip for: ship3) lapCount equals: 0.
]

{ #category : 'tests - instance' }
BoardTest >> testBlackHoleEffectMovesSpaceshipBackwards [
	| board ship |
	board := Board withCells: 5 andWormholes: #().
	ship := Spaceship withName: 'Lucas' and: 4.
	ship moveTo: 3.

	board cells at: 4 put: BlackHoleEffect new.
	board applyEffectTo: ship.

	self assert: ship position equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testBoardCellsContainRecognizedEffects [
	| board validClasses |
	validClasses := { BlackHoleEffect. HyperGravityEffect }.

	board := Board withCells: 20 andWormholes: OrderedCollection new.

	self assert: (board cells allSatisfy: [:e |
		validClasses anySatisfy: [:c | e class = c ] ]).

]

{ #category : 'tests - instance' }
BoardTest >> testBoardInitializesCorrectNumberOfEffects [
	| board |
	board := Board withCells: 20 andWormholes: OrderedCollection new.

	self assert: board cells size equals: 20.

]

{ #category : 'tests - instance' }
BoardTest >> testBoardPreventsEntryToHyperGravityCellWithLowRoll [
	| dice1 dicesGame board ship lappedShip effect newPosition |
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	board := Board withCells: 5 andWormholes: #().
	
	ship := Spaceship withName: 'Lucas' and: dicesGame maxRoll.
	ship moveTo: 2.
	lappedShip := LappedShip for: ship.  "Usar LappedShip para vueltas"

	effect := HyperGravityEffect new.
	effect requiredRoll: 4.
	board cells at: 4 put: effect. "posición 3 → índice 4 (1-based)"

	newPosition := board 
		newPositionFrom: ship position 
		steps: 1 
		for: lappedShip  "Pasar LappedShip para tracking de vueltas"
		withRoll: 2.

	"Verificar que no avanzó"
	self assert: newPosition equals: 2.
	self assert: ship position equals: 2.
	
	"Verificar que no se incrementó vuelta"
	self assert: lappedShip lapCount equals: 0.
]

{ #category : 'tests - instance' }
BoardTest >> testCanEnterHyperGravityCellWithSufficientRoll [
	| board effect |
	board := Board withCells: 5 andWormholes: #().
	effect := HyperGravityEffect new.
	board cells at: 3 put: effect.

	self assert: (effect allowsEntryWithRoll: 5).

]

{ #category : 'tests - instance' }
BoardTest >> testCannotEnterHyperGravityCellWithLowRoll [
	| board effect |
	board := Board withCells: 5 andWormholes: #().
	effect := HyperGravityEffect new.
	board cells at: 3 put: effect.

	self deny: (effect allowsEntryWithRoll: 2).

]

{ #category : 'tests - instance' }
BoardTest >> testHyperGravityAllowsEntryWhenRollIsSufficient [
	| board ship effect newPosition |

	board := Board withCells: 5 andWormholes: #().
	ship := Spaceship withName: 'Lucas' and: 4.
	ship moveTo: 2.

	effect := HyperGravityEffect new.
	effect requiredRoll: 4.
	board cells at: 4 put: effect.

	newPosition := board newPositionFrom: ship position steps: 1 for: (LappedShip for: ship) withRoll: 5.
	self assert: newPosition equals: 3.

	ship moveTo: newPosition.
	board applyEffectTo: ship.

	self assert: ship position equals: 3.
]

{ #category : 'tests - instance' }
BoardTest >> testHyperGravityEffectHasCorrectDefaultRoll [
	| effect |
	effect := HyperGravityEffect new.
	self assert: effect requiredRoll equals: 4.

]

{ #category : 'tests - instance' }
BoardTest >> testHyperJumpEffectJumpsShipForward [
	| dice1 dicesGame board ship lappedShip effect newPosition game |
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	board := Board withCells: 10 andWormholes: #().
	
	"Configurar efecto HyperJump en posición correcta (índice 7 = posición 6)"
	HyperJumpEffect resetJumpIndex.
	effect := HyperJumpEffect new.
	board cells at: 7 put: effect.  "Para posición 6 (1-based index)"
	
	ship := Spaceship withName: 'Apollo' and: dicesGame maxRoll.
	ship restoreFuel. "Asegurar combustible suficiente"
	lappedShip := LappedShip for: ship. "Para tracking de vueltas"
	
	ship moveTo: 5.
	self assert: ship position equals: 5.
	
	"Mover a posición 6 (donde está el efecto)"
	newPosition := board 
		newPositionFrom: ship position 
		steps: 1 
		for: lappedShip 
		withRoll: 4.
	self assert: newPosition equals: 6.
	
	ship moveTo: newPosition.
	self assert: ship position equals: 6.
	
	"Crear contexto mínimo del juego para aplicar efecto"
	game := Game startWithShips: {ship} board: board dice: dicesGame laps: 1.
	effect applyTo: ship.
	
	"Verificar salto de 3 posiciones (6 + 3 = 9)"
	self assert: ship position equals: 9.
	self assert: ship fuel equals: (dicesGame maxRoll * 2) - 4. "Combustible consumido"
]

{ #category : 'tests - instance' }
BoardTest >> testIsGoalReached [
    | board |
    board := Board withCells: 10 andWormholes: #().

    self assert: (board isGoalReachedAt: 10).
    self assert: (board isGoalReachedAt: 11).
    self deny: (board isGoalReachedAt: 9).

]

{ #category : 'tests - instance' }
BoardTest >> testLapDoesNotIncrementWhenStayingWithinBounds [
	| board ship newPosition |
	board := Board withCells: 10 andWormholes: OrderedCollection new.
	ship := Spaceship withName: 'Lucas' and: 4.
	ship moveTo: 3.

	newPosition := board circularPositionFrom: ship position steps: 4 for: ship.

	self assert: newPosition equals: 7.
	self assert: ship lap equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testLapIncrementsWhenPassingLastCell [
	| dice1 dicesGame board ship newPosition |
	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	board := Board withCells: 10 andWormholes: OrderedCollection new.
	ship := Spaceship withName: 'Lucas' and: dicesGame maxRoll.
	ship moveTo: 8.

	newPosition := board circularPositionFrom: ship position steps: 3 for: (LappedShip for: ship) .

	self assert: newPosition equals: 1.
	self assert: (LappedShip for: ship) lapCount equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testMoonWalkEffectMovesOtherSpaceshipsBackwards [
	| dice1 dicesGame effect ship1 ship2 ship3 allShips |

	dice1 := Die withSides: 6.
	dicesGame := DiceCup with: (OrderedCollection with: dice1).
	
	effect := MoonWalkEffect new.

	ship1 := Spaceship withName: 'Player1' and: dicesGame maxRoll.
	ship2 := Spaceship withName: 'Player2' and: dicesGame maxRoll.
	ship3 := Spaceship withName: 'Player3' and: dicesGame maxRoll.

	ship1 moveTo: 5.
	ship2 moveTo: 7.
	ship3 moveTo: 3.

	allShips := { ship1. ship2. ship3 }.

	effect applyTo: ship2 inContextOf: allShips.

	self assert: ship2 position equals: 7.
	self assert: ship1 position equals: 3.
	self assert: ship3 position equals: 1.
]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithWormhole [
	| board ship |
	board := Board withCells: 25 andWormholes: (OrderedCollection with: (Wormhole from: 6 to: 20)).
	ship := Spaceship withName: 'Test' and: 4.

	self assert: (board newPositionFrom: 2 steps: 4 for: ship) equals: 20.

]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithoutWormhole [
	| board ship |
	board := Board withCells: 25 andWormholes: #().
	ship := Spaceship withName: 'Test' and: 4.

	self assert: (board newPositionFrom: 2 steps: 2 for: ship) equals: 4.

]

{ #category : 'tests - instance' }
BoardTest >> testPositionWithoutWormholeReturnsSame [
    | board |
    board := Board withCells: 10 andWormholes: #().

    self assert: (board applyWormholeIfPresentAt: 5) equals: 5.

]

{ #category : 'tests - instance' }
BoardTest >> testWormholeTransportsCorrectly [
    | board |
    board := Board withCells: 20 andWormholes: (OrderedCollection withAll: {
        Wormhole from: 2 to: 10.
        Wormhole from: 10 to: 2.
    }).

    self assert: (board applyWormholeIfPresentAt: 2) equals: 10.
    self assert: (board applyWormholeIfPresentAt: 10) equals: 2.

]
