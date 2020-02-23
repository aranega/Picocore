Class {
	#name : #PicoAbstractMetaclass,
	#superclass : #PicoTest,
	#instVars : [
		'picoClass',
		'picoAbstractPointClass',
		'picoAbstractMetaclass',
		'picoConcretePointClass'
	],
	#category : #'PicoCore-Metaclass Example'
}

{ #category : #setup }
PicoAbstractMetaclass >> defineAbstractClass [

	picoAbstractMetaclass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#PicoAbstractClass.
			#PicoClass.
			#()}.
]

{ #category : #setup }
PicoAbstractMetaclass >> defineAbstractPoint [ 

	picoAbstractPointClass := picoAbstractMetaclass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#PicoAbstractPoint.
			#PicoObject.
			#()}.
]

{ #category : #setup }
PicoAbstractMetaclass >> defineConcretePoint [ 
	
	"now we pay attention to really use the non abstract metaclass"
	picoConcretePointClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#PicoConcretePoint.
			#PicoAbstractPoint.
			#(x y)}.
]

{ #category : #setup }
PicoAbstractMetaclass >> setUp [ 
	super setUp.
	PicoBlop bootstrap.
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	
	self defineAbstractClass.
	self defineAbstractPoint.
	self defineConcretePoint.
]

{ #category : #setup }
PicoAbstractMetaclass >> testAbstractClass [

	self assert: picoAbstractPointClass picoClassName equals: #PicoAbstractPoint.
	self assert: picoAbstractPointClass picoSuperclassId equals: #PicoObject.
	self assert: picoAbstractPointClass picoIVs equals: #(class).
	
	self should: [ picoAbstractPointClass send: #new ] raise: Error
]

{ #category : #setup }
PicoAbstractMetaclass >> testAbstractMetaClass [

	self assert: picoAbstractMetaclass picoClassName equals: #PicoAbstractClass.
	self assert: picoAbstractMetaclass picoSuperclass equals: picoClass.
	self assert: picoAbstractMetaclass picoIVs equals: picoClass picoIVs.
]

{ #category : #setup }
PicoAbstractMetaclass >> testConcreteClass [

	| aPoint |
	self assert: picoConcretePointClass picoClassName equals: #PicoConcretePoint.
	self assert: picoConcretePointClass picoSuperclassId equals: #PicoAbstractPoint.
	self assert: picoConcretePointClass picoIVs equals: #(class x y).
	
	aPoint := picoConcretePointClass send: #new.
	self assert: (aPoint send: #x) equals: 1000.
]

{ #category : #setup }
PicoAbstractMetaclass >> testPointInstanceExecuteMethodOfAbstractSuperclass [

	| aPoint |
	aPoint := picoConcretePointClass send: #new.
	self assert: (aPoint send: #display) equals: 'I am a 1000 with (1000 , 2000)'.
]
