Class {
	#name : 'CancellationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - instance' }
CancellationCardTest >> testApplyEffectToRemovesCardFromGame [

    | target card ship1 ship2 board dice game |

    target := RepeatCard new.
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    ship1 addActiveCard: target.

    board := Board of: 5 andWormholeAt: {}.
    dice := DiceCup with: { Die withSides: 1 }.
    game := Game startWithShips: { ship1. ship2 } board: board dice: dice laps: 1.

    card := CancellationCard cancelling: target.
    card applyEffectTo: ship2 inGame: game.

    self deny: (ship1 activeCards includes: target).
]

{ #category : 'tests - class' }
CancellationCardTest >> testCancellingCreatesCardWithTarget [

    | target card |

    target := RepeatCard new.
    card := CancellationCard cancelling: target.

    self assert: card class equals: CancellationCard.
    self assert: (card instVarNamed: 'cardToCancel') equals: target.
]

{ #category : 'tests - instance' }
CancellationCardTest >> testInitializeCancellingSetsCardToCancel [

    | target card returned |

    target := RepeatCard new.
    card := CancellationCard new.
    returned := card initializeCancelling: target.

    self assert: returned == card.
    self assert: (card instVarNamed: 'cardToCancel') equals: target.
]
