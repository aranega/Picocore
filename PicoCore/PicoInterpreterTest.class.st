Class {
	#name : #PicoInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'pointClass'
	],
	#category : #PicoCore
}

{ #category : #running }
PicoInterpreterTest >> setUp [

	pointClass := PicoBlop new: 5.
	{ #PicoClass . #PicoPoint . #PicoObject . { #class . #x . #y } . 5 }
		withIndexDo: [ :each :i | pointClass at: i put: each ].
	
	pointClass initializeMethodDictionaryFrom: PicoPoint.
	PicoBlop initializePicoClassEnvironment.
	PicoBlop declareClass: pointClass.
	
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testGetterExecution [
	|  inst val |
	inst := pointClass primitiveAllocateAnInstance.
	inst at: 2 put: 33.
	val := inst send: #x.
	self assert: val equals: 33
	
]

{ #category : #'primitive message tests' }
PicoInterpreterTest >> testPlayingWithString [
	| inst val |
	inst := pointClass primitiveAllocateAnInstance.
	val := inst send: #playingWithString.
	"playingWithString

	^ 'pico core is cool' size"
	self assert: val equals: 17
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testReturn100Execution [
	|  inst val |
	inst := pointClass primitiveAllocateAnInstance.
	val := inst send: #return100.
	self assert: val equals: 100
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testSendingMessageToArgument [
	|  inst inst2 value |
	inst := pointClass primitiveAllocateAnInstance.
	inst2 := pointClass primitiveAllocateAnInstance.
	inst at: 2 put: 42.
	inst2 at: 2 put: 666.
	"sendingMessageToArgument: aPicoPoint 
	
	^ (aPicoPoint send: #x) "
	value := inst send: #sendingMessageToArgument: withArguments: {inst2}.
	self assert: value equals: 666.
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testSendingMessageToArgumentWithArg [

	|  inst inst2 value |
	inst := pointClass primitiveAllocateAnInstance.
	inst2 := pointClass primitiveAllocateAnInstance.
	inst at: 2 put: 42.
	inst2 at: 2 put: 666.
	"sendingMessageToArgument: anEvilPoint withArg: arg
	
	^ (anEvilPoint send: #x) + arg"

	value := inst send: #sendingMessageToArgument:withArg: withArguments: {inst2 . 72}.
	self assert: value equals: 666 + 72.
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testSendingMessageToArgumentwithDifferentArgument [

	|  inst inst2 value |
	inst := pointClass primitiveAllocateAnInstance.
	inst2 := pointClass primitiveAllocateAnInstance.
	inst at: 2 put: 42.
	inst2 at: 2 put: 666.
	"sendingMessageToArgument: aPicoPoint withDifferentArgument: anArg
	
	^ aPicoPoint send: #x: withArguments: {33}"

	value := inst send: #sendingMessageToArgument:withDifferentArgument: withArguments: {inst2 . 72}.
	self assert: value equals: 33.
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testSetterExecution [
	| inst |
	inst := pointClass primitiveAllocateAnInstance.
	inst send: #x: withArguments: #(20).
	self assert: (inst at: 2) equals: 20.
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testSettingAValueFromTempToTemp2 [
	|  inst value |
	inst := pointClass primitiveAllocateAnInstance.
	value := inst send: #settingAValueFromTempToTemp2.
	self assert: value equals: 10.
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testSettingAValueToTemp [
	|  inst value |
	inst := pointClass primitiveAllocateAnInstance.
	value := inst send: #settingAValueToTemp.
	
	"settingAValueToTemp

	| temp | 
	temp := 10.
	^ temp"
	
	self assert: value equals: 10.
	
]

{ #category : #'interpreter tests' }
PicoInterpreterTest >> testSettingAValueToTemp2 [
	|  inst value |
	inst := pointClass primitiveAllocateAnInstance.
	value := inst send: #settingAValueToTemp2.
	self assert: value equals: 20.
]

{ #category : #'primitive message tests' }
PicoInterpreterTest >> testSimpleMessage [
	|  inst val |
	inst := pointClass primitiveAllocateAnInstance.
	val := inst send: #simpleMessage.
	"
	simpleMessage
		^ 10 * 10
	"
	self assert: val equals: 100
	
]

{ #category : #'stack tests' }
PicoInterpreterTest >> testStackIsWellInitialized [

	| int |
	int := PicoInterpreter new.
	self assert: int stack top parent isNil.
]

{ #category : #'stack tests' }
PicoInterpreterTest >> testStackPushNewScope [

	| int |
	int := PicoInterpreter new.
	int pushNewScope.
	"the parent of the top scope is the previous one."
	self deny: int stack top parent isNil.
]

{ #category : #'primitive message tests' }
PicoInterpreterTest >> testUsingTempValue [
	|  inst val |
	inst := pointClass primitiveAllocateAnInstance.
	val := inst send: #usingTempValue.
	"usingTempValue

	| temp | 
	temp := 10.
	temp := temp + temp.
	^ temp"
	self assert: val equals: 20
	
]
