Class {
	#name : #PicoBlopTest,
	#superclass : #TestCase,
	#instVars : [
		'pointClass'
	],
	#category : #PicoCore
}

{ #category : #running }
PicoBlopTest >> setUp [

	pointClass := PicoBlop new: 5.
	{ #PicoClass . #PicoPoint . #PicoObject . { #class . #x . #y } . 5 }
		withIndexDo: [ :each :i | pointClass at: i put: each ].
	
	pointClass initializeMethodDictionaryFrom: PicoCodeRepositoryForPoint.
	PicoBlop initializePicoClassEnvironment.
	PicoBlop declareClass: pointClass.
	
	
]

{ #category : #tests }
PicoBlopTest >> testMethodDictionaryFrom [

	| dict |
	dict := PicoBlop new methodDictionaryFrom: PicoCodeRepositoryForPoint.
	self assert: dict keys asSet equals: PicoCodeRepositoryForPoint selectors asSet.
	self assert: (dict at: #x) equals: (PicoCodeRepositoryForPoint >> #x) ast

]

{ #category : #tests }
PicoBlopTest >> testPoinInstantiation [
	|  inst |
	inst := pointClass primitiveAllocateAnInstance.
	self assert: (inst at: 1) equals: 'PicoPoint'.
	self assert: (inst at: 2) equals: nil.
	self assert: (inst at: 3) equals: nil.
]

{ #category : #tests }
PicoBlopTest >> testPoinInstantiationClass [
	| inst |
	inst := pointClass primitiveAllocateAnInstance.
	self assert: (inst at: 1) equals: 'PicoPoint'.
	self assert: inst picoClass equals: pointClass.

]

{ #category : #tests }
PicoBlopTest >> testSimpleLookup [
	| method |
	method := pointClass primitiveLookup: #x:.
	self assert: method equals: ((pointClass at: 5) at: #x:)
]