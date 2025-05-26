Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
BoardTest >> testApplyEffectToSpaceship [
	| board ship |
	board := Board withCells: 5 andWormholes: #().
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 3.

	board cells at: 4 put: TestEffect new.  "posición 3 → índice 4"

	board applyEffectTo: ship.

	self assert: ship lap equals: 1.

]

{ #category : 'tests - instance' }
BoardTest >> testBlackHoleEffectMovesSpaceshipBackwards [
	| board ship |
	board := Board withCells: 5 andWormholes: #().
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 3.

	board cells at: 4 put: BlackHoleEffect new.  "posición 3 → índice 4 (1-based)"
	board applyEffectTo: ship.

	self assert: ship position equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testBoardAllowsEntryToHyperGravityCellWithSufficientRoll [
	| board ship effect newPosition |
	board := Board withCells: 5 andWormholes: #().
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 2.

	effect := HyperGravityEffect new.
	effect requiredRoll: 4.  "Tirada mínima conocida y controlada"
	board cells at: 3 put: effect.

	newPosition := board newPositionFrom: ship position steps: 1 for: ship withRoll: 5.

	self assert: newPosition equals: 3.  "Sí avanzó"

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
	| board ship newPosition |
	board := Board withCells: 5 andWormholes: #().
	
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 2.

	board cells at: 3 put: HyperGravityEffect new.  "posición 2 → índice 3"

	self assert: ((board cells at: 3) requiredRoll) equals: 4.

	newPosition := board newPositionFrom: ship position steps: 1 for: ship withRoll: 2.

	self assert: newPosition equals: 2.  "No avanzó"
	self assert: ship lap equals: 0.  "No contó vuelta"

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
	board cells at: 3 put: effect.  "Casillero 2 → índice 3"

	"Simulamos una tirada menor al requerido (por default, 4)"
	self deny: (effect allowsEntryWithRoll: 2).

]

{ #category : 'tests - instance' }
BoardTest >> testHyperGravityEffectHasCorrectDefaultRoll [
	| effect |
	effect := HyperGravityEffect new.
	self assert: effect requiredRoll equals: 4.

]

{ #category : 'tests - instance' }
BoardTest >> testHyperJumpEffectJumpsShipForward [
	| board ship newPosition effect |
	
	board := Board withCells: 10 andWormholes: #().
	
	HyperJumpEffect resetJumpIndex.  "deja el salto en 3"

	effect := HyperJumpEffect new.
	board cells at: 6 put: effect.  "🔒 esto se hace después de initializeCells"

	self assert: (board effectAt: 5) class equals: HyperJumpEffect.

	ship := Spaceship withName: 'Apollo'.
	ship moveTo: 5.

	newPosition := board newPositionFrom: ship position steps: 1 for: ship withRoll: 4.
	ship moveTo: newPosition.
	
	board applyEffectTo: ship.

	self assert: ship position equals: 6.

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
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 3.

	newPosition := board circularPositionFrom: ship position steps: 4 for: ship.

	self assert: newPosition equals: 7.
	self assert: ship lap equals: 0.

]

{ #category : 'tests - instance' }
BoardTest >> testLapIncrementsWhenPassingLastCell [
	| board ship newPosition |
	board := Board withCells: 10 andWormholes: OrderedCollection new.
	ship := Spaceship withName: 'Lucas'.
	ship moveTo: 8.

	newPosition := board circularPositionFrom: ship position steps: 3 for: ship.

	self assert: newPosition equals: 1.
	self assert: ship lap equals: 1.

]

{ #category : 'tests - instance' }
BoardTest >> testMoonWalkEffectMovesOtherSpaceshipsBackwards [
	| effect nave1 nave2 nave3 allShips |
	
	effect := MoonWalkEffect new.

	nave1 := Spaceship withName: 'Jugador1'.
	nave2 := Spaceship withName: 'Jugador2'.
	nave3 := Spaceship withName: 'Jugador3'.

	nave1 moveTo: 5.
	nave2 moveTo: 7.
	nave3 moveTo: 3.

	allShips := { nave1. nave2. nave3 }.

	effect applyTo: nave2 inContextOf: allShips.

	"nave2 fue quien activó el efecto, no debe moverse"
	self assert: nave2 position equals: 7.

	"las demás naves retroceden 2"
	self assert: nave1 position equals: 3.
	self assert: nave3 position equals: 1.

]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithWormhole [
	| board ship |
	board := Board withCells: 25 andWormholes: (OrderedCollection with: (Wormhole from: 6 to: 20)).
	ship := Spaceship withName: 'Test'.

	self assert: (board newPositionFrom: 2 steps: 4 for: ship) equals: 20.

]

{ #category : 'tests - instance' }
BoardTest >> testNewPositionWithoutWormhole [
	| board ship |
	board := Board withCells: 25 andWormholes: #().
	ship := Spaceship withName: 'Test'.

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
