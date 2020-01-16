Class {
	#name : #PicoInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'pointClass'
	],
	#category : #PicoCore
}

{ #category : #tests }
PicoInterpreterTest >> setUp [

	| dict |
	pointClass := PicoBlop new: 5.
	{ #PicoClass . #PicoPoint . #PicoObject . { #class . #x . #y } . 5 }
		withIndexDo: [ :each :i | pointClass at: i put: each ].
		
	dict := IdentityDictionary new. 
	dict at: #x put: (PicoCodeRepositoryForPoint >> #x) ast.
	dict at: #x: put: (PicoCodeRepositoryForPoint >> #x:) ast.
	dict at: #y put: (PicoCodeRepositoryForPoint >> #y) ast.
	dict at: #return100 put: (PicoCodeRepositoryForPoint >> #return100) ast.
	dict at: #distanceToOrigin  put: (PicoCodeRepositoryForPoint >> #distanceToOrigin) ast.
	
	pointClass at: 5 put: dict.
	PicoBlop initializePicoClassEnvironment.
	PicoBlop declareClass: pointClass.
	
	
]

{ #category : #interpreter }
PicoInterpreterTest >> testGetterExecution [
	|  inst val |
	inst := pointClass primitiveAllocateAnInstance.
	inst at: 2 put: 33.
	val := inst send: #x.
	self assert: val equals: 33
	
]

{ #category : #tests }
PicoInterpreterTest >> testPoinInstantiation [
	|  inst |
	inst := pointClass primitiveAllocateAnInstance.
	self assert: (inst at: 1) equals: 'PicoPoint'.
	self assert: (inst at: 2) equals: nil.
	self assert: (inst at: 3) equals: nil.
]

{ #category : #tests }
PicoInterpreterTest >> testPoinInstantiationClass [
	|  inst |
	inst := pointClass primitiveAllocateAnInstance.
	self assert: (inst at: 1) equals: 'PicoPoint'.
	self assert: inst picoClass equals: pointClass.

]

{ #category : #interpreter }
PicoInterpreterTest >> testReturn100Execution [
	|  inst val |
	inst := pointClass primitiveAllocateAnInstance.
	val := inst send: #return100.
	self assert: val equals: 100
	
]

{ #category : #tests }
PicoInterpreterTest >> testSimpleLookup [
	|  method |
	method := pointClass primitiveLookup: #x:.
	self assert: method equals: ((pointClass at: 5) at: #x:)
]
