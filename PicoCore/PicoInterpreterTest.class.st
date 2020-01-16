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
	dict at: #x put: (PicoCodeRepository >> #x) ast.
	dict at: #y put: (PicoCodeRepository >> #distanceToOrigin) ast.
	dict at: #distanceToOrigin  put: (PicoCodeRepository >> #distanceToOrigin) ast.
	
	pointClass at: 5 put: dict.
	
	
]

{ #category : #tests }
PicoInterpreterTest >> testPicoPointClass [
	|  inst |
	inst := pointClass primitiveAllocateAnInstance.
	self assert: (inst at: 1) equals: 'PicoPoint'.
	self assert: (inst at: 2) equals: nil.
	self assert: (inst at: 3) equals: nil.
]
