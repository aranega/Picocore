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
	
	pointClass initializeMethodDictionaryFrom: PicoPoint.
	PicoBlop initializePicoClassEnvironment.
	PicoBlop declareClass: pointClass.
	
	
]

{ #category : #tests }
PicoBlopTest >> testMethodDictionaryFrom [

	| dict |
	dict := PicoBlop new methodDictionaryFrom: PicoPoint.
	self assert: dict keys asSet equals: PicoPoint selectors asSet.
	self assert: (dict at: #x) equals: (PicoPoint >> #x) ast

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

{ #category : #'message tests' }
PicoBlopTest >> testValidSend [

	self should: [ pointClass primitiveAllocateAnInstance 
							send: #dotProduct: withArguments: {1 . 2} ] 
							raise: Error.
							
	self should: [ pointClass primitiveAllocateAnInstance 
							send: #dotProduct withArguments: {1} ] 
							raise: Error.
	
	self should: [ pointClass primitiveAllocateAnInstance 
							send: #dotProduct:and: withArguments: {1} ] 
							raise: Error.
							
	self should: [ pointClass primitiveAllocateAnInstance 
							send: #dotProduct:and: withArguments: {1 . 2 .3 } ] 
							raise: Error
]
