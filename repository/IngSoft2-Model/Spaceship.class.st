Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'position',
		'playerName'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
Spaceship >> initializeWith: aName [

	aName isEmpty ifTrue: [ self error: 'El nombre no puede estar vacío' ].

	playerName := aName.
	position := 0
]

{ #category : 'instance creation' }
Spaceship >> playerName [
    ^ playerName
]

{ #category : 'instance creation' }
Spaceship >> position [
    ^ position
]
