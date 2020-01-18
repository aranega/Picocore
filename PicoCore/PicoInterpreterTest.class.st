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

	pointClass := PicoBlop new: 5.
	{ #PicoClass . #PicoPoint . #PicoObject . { #class . #x . #y } . 5 }
		withIndexDo: [ :each :i | pointClass at: i put: each ].
	
	pointClass initializeMethodDictionaryFrom: PicoCodeRepositoryForPoint.
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

{ #category : #interpreter }
PicoInterpreterTest >> testSetterExecution [
	|  inst |
	inst := pointClass primitiveAllocateAnInstance.
	inst send: #x: withArguments: #(20).
	self assert: (inst at: 2) equals: 20.
	
]

{ #category : #interpreter }
PicoInterpreterTest >> testUsingTemp [
	|  inst value |
	inst := pointClass primitiveAllocateAnInstance.
	value := inst send: #settingAValueToTemp.
	self assert: value equals: 10.
	
]

{ #category : #interpreter }
PicoInterpreterTest >> testUsingTempValue [
	|  inst value |
	inst := pointClass primitiveAllocateAnInstance.
	value := inst send: #usingTemp2.
	self assert: value equals: 20.
	
]
