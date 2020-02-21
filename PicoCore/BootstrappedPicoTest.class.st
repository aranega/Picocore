"
These tests consider that the kernel is bootstrapped.
"
Class {
	#name : #BootstrappedPicoTest,
	#superclass : #PicoTest,
	#category : #'PicoCore-Tests'
}

{ #category : #tests }
BootstrappedPicoTest >> setUp [ 
	super setUp.
	PicoBlop bootstrap.
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
