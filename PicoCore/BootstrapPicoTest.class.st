"
These tests are about the bootstrap of the kernel.
"
Class {
	#name : #BootstrapPicoTest,
	#superclass : #TestCase,
	#category : #'PicoCore-Tests'
}

{ #category : #'tests - Object class' }
BootstrapPicoTest >> testCreateObject [
	"(self selector: #testCreateObject) run"

	| objectClass |

	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	PicoBlop defineObject.
	objectClass := PicoBlop giveClassNamed: #PicoObject.
	self assert: objectClass picoClassId equals: #PicoClass.
	self assert: objectClass picoSuperclassId isNil.
	self assert: objectClass picoIVs equals: #(class).
	self assert: objectClass picoMethodDict keys size equals: PicoObjectCode selectors size.
	self assert: objectClass picoClassName equals: #PicoObject
]

{ #category : #'tests - Object class' }
BootstrapPicoTest >> testCreateObjectMethods [
	"(self selector: #testCreateObjectMethods) run"

	| objectClass instanceOfObject |
	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	PicoBlop defineObject.
	self assert: (PicoBlop picoEnvironment keys includesAll: #(PicoObject PicoClass)).
	objectClass := PicoBlop giveClassNamed: #PicoObject.
	instanceOfObject := objectClass send: #new.
	self assert: (instanceOfObject send: #isClass) not.
	self assert: (instanceOfObject send: #isMetaclass) not.
]

{ #category : #'tests - Object class' }
BootstrapPicoTest >> testMakeSureThatInitializeOnObjectIsInvoked [
	"(self selector: #testMakeSureThatInitializeOnObjectIsInvoked) run"

	| objectClass instanceOfObject |

	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	PicoBlop defineObject.
	self assert: (PicoBlop picoEnvironment keys includesAll: #(PicoObject PicoClass)).
	objectClass := PicoBlop giveClassNamed: #PicoObject.
	instanceOfObject := objectClass send: #new.
	self assert: (instanceOfObject send: #picoClass) equals: objectClass.
]

{ #category : #'tests - manually class creation' }
BootstrapPicoTest >> testManualClassStructureCreation [
	| picoClass |
	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	self assert: picoClass picoClassName equals: #PicoClass.
	self assert: picoClass picoClassId equals: #PicoClass.
	self assert: picoClass picoClass equals: picoClass.
	self assert: picoClass picoSuperclassId equals: #PicoObject.	
	"the fact that the created first class inherits form ObjObject is not necessary
	because there is no super calls"
	self assert: picoClass picoIVs equals: #(#class #name #superclass #iv #methodDict).
	
]

{ #category : #'tests - manually class creation' }
BootstrapPicoTest >> testManuallyCreateClassAllocate [
	"(self selector: #testManuallyCreateClassAllocate) run"

	| picoClass emptyClass |

	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	emptyClass := picoClass send: #allocate.
	self assert: emptyClass picoClassId equals: #PicoClass.
	self assert:  emptyClass picoSuperclassId isNil.
	self assert:  emptyClass picoIVs isNil.
	self assert:  emptyClass picoMethodDict isNil.
	self assert:  emptyClass picoClassName isNil
]

{ #category : #'tests - manually class creation' }
BootstrapPicoTest >> testManuallyCreateClassCreateClass [
	"(self selector: #testManuallyCreateClassCreateClass) run"

	| picoClass pointClass |

	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	pointClass := picoClass 
			send: #createClassNamed:inheritsFrom:instVars:
			withArguments: { #PicoPoint . #PicoObject . #(class x y)}.
	self assert: pointClass picoClassId equals: #PicoClass.
	self assert: pointClass picoSuperclassId equals: #PicoObject.
	self assert: pointClass picoIVs equals: #(class x y).
	self assert: pointClass picoMethodDict keys size equals: PicoPointCode selectors size.
	self assert: pointClass picoClassName equals: #PicoPoint
]

{ #category : #'tests - manually class creation' }
BootstrapPicoTest >> testManuallyCreateClassInstanceOfClass [
	"(self selector: #testManuallyCreateClassInstanceOfClass) run"

	| picoClass pointClass aPoint |

	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	pointClass := picoClass 
			send: #createClassNamed:inheritsFrom:instVars:
			withArguments: { #PicoPoint . #PicoObject . #(class x y)}.
	aPoint := pointClass send: #new.
	self assert: (aPoint send: #x) equals: 1000.
	self assert: (aPoint send: #y) equals: 2000
	
]

{ #category : #'tests - manually class creation' }
BootstrapPicoTest >> testManuallyCreateClassIsDeclared [
	"(self selector: #testManuallyCreateClassInstanceOfClass) run"
	
	| picoClass pointClass |
	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	pointClass := picoClass 
			send: #createClassNamed:inheritsFrom:instVars:
			withArguments: { #PicoPoint . #PicoObject . #(class x y)}.
	self assert: (PicoBlop picoEnvironment keys includes: #PicoPoint).
]

{ #category : #'tests - manually class creation' }
BootstrapPicoTest >> testManuallyCreateClassNew [
	"(self selector: #testManuallyCreateClassNew) run"

	| picoClass emptyClass |

	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	emptyClass := picoClass send: #new.
	self assert: emptyClass picoClassId equals: #PicoClass.
	self assert: emptyClass picoSuperclassId equals: #YouShouldNameMeToo.
	self assert: emptyClass picoIVs equals: #().
	self assert: emptyClass picoMethodDict class equals: IdentityDictionary.

]
