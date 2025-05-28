Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
Effect >> allowsEntryWithRoll: aRoll [
    ^ true
]

{ #category : 'operations' }
Effect >> applyTo: aSpaceship [
    self subclassResponsibility.
]

{ #category : 'operations' }
Effect >> applyTo: aSpaceship inGame: aGame [
    self subclassResponsibility.
]
