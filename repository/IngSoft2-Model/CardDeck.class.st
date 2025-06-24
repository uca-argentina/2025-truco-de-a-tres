Class {
	#name : 'CardDeck',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'deck' }
CardDeck class >> availableCards [
	^ { AdvanceCard. ShieldCard. OverloadCard. AccelerationCard. CancellationCard. AllyCard. RedoCard. RepeatCard }
]

{ #category : 'deck' }
CardDeck class >> randomCard [
	^ (self availableCards atRandom) new
]
