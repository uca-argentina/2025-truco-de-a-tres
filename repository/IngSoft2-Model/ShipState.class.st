Class {
    #name : 'ShipState',
    #superclass : 'Object',
    #category : 'IngSoft2-Model',
    #package : 'IngSoft2-Model'
}

{ #category : 'enumerating' }
ShipState >> whenPenalizedDo: penalizedBlock whenNormalDo: normalBlock [
    self subclassResponsibility.
]
