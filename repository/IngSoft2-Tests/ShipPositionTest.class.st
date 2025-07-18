Class {
	#name : 'ShipPositionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipPositionTest >> testIsGreaterThanReturnsFalseWhenLower [
    | ship1 ship2 pos1 pos2 |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    ship1 moveTo: 2.
    ship2 moveTo: 4.
    pos1 := ShipPosition for: ship1.
    pos2 := ShipPosition for: ship2.
    self deny: (pos1 isGreaterThan: pos2).
]

{ #category : 'tests' }
ShipPositionTest >> testIsGreaterThanReturnsTrueWhenHigher [
    | ship1 ship2 pos1 pos2 |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    ship1 moveTo: 5.
    ship2 moveTo: 3.
    pos1 := ShipPosition for: ship1.
    pos2 := ShipPosition for: ship2.
    self assert: (pos1 isGreaterThan: pos2).
]

{ #category : 'tests' }
ShipPositionTest >> testIsLessThanReturnsTrueWhenLower [
    | ship1 ship2 pos1 pos2 |
    ship1 := Spaceship withName: 'One'.
    ship2 := Spaceship withName: 'Two'.
    ship1 moveTo: 1.
    ship2 moveTo: 2.
    pos1 := ShipPosition for: ship1.
    pos2 := ShipPosition for: ship2.
    self assert: (pos1 isLessThan: pos2).
]
