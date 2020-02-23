"
These tests consider that the kernel is bootstrapped.
"
Class {
	#name : #BootstrappedPicoTest,
	#superclass : #PicoTest,
	#instVars : [
		'picoClass'
	],
	#category : #'PicoCore-Tests'
}

{ #category : #tests }
BootstrappedPicoTest >> setUp [ 
	super setUp.
	PicoBlop bootstrap.
	picoClass := PicoBlop giveClassNamed: #PicoClass.
]

{ #category : #tests }
BootstrappedPicoTest >> testManuallyCreateClassCreateClass [
	"(self selector: #testManuallyCreateClassCreateClass) run"

	| pointClass |
	pointClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#PicoPoint.
			#PicoObject.
			#(x y)}.
	self assert: pointClass picoClassId equals: #PicoClass.
	self assert: pointClass picoSuperclassId equals: #PicoObject.
	self assert: pointClass picoIVs equals: #(class x y).
	self
		assert: pointClass picoMethodDict keys size
		equals: PicoPointCode selectors size.
	self assert: pointClass picoClassName equals: #PicoPoint
]

{ #category : #tests }
BootstrappedPicoTest >> testManuallyCreateClassInstanceOfClass [
	"(self selector: #testManuallyCreateClassInstanceOfClass) run"

	| pointClass aPoint |
	pointClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#PicoPoint.
			#PicoObject.
			#(x y)}.
	aPoint := pointClass send: #new.
	self assert: (aPoint send: #x) equals: 1000.
	self assert: (aPoint send: #y) equals: 2000
]

{ #category : #tests }
BootstrappedPicoTest >> testManuallyCreateClassIsDeclared [
	"(self selector: #testManuallyCreateClassInstanceOfClass) run"

	| pointClass |
	pointClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#PicoPoint.
			#PicoObject.
			#(class x y)}.
	self assert: (PicoBlop picoEnvironment keys includes: #PicoPoint)
]

{ #category : #tests }
BootstrappedPicoTest >> testObjectMethods [
	"(self selector: #testObjectMethods) run"

	| objectClass instanceOfObject |
	objectClass := PicoBlop giveClassNamed: #PicoObject.
	instanceOfObject := objectClass send: #new.
	self assert: (instanceOfObject send: #isClass) not.
	self assert: (instanceOfObject send: #isMetaclass) not.
]
