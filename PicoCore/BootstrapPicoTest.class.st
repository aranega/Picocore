"
These tests are about the bootstrap of the kernel.
"
Class {
	#name : #BootstrapPicoTest,
	#superclass : #TestCase,
	#category : #'PicoCore-Tests'
}

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
BootstrapPicoTest >> testManuallyCreateClassNew [
	"(self selector: #testManuallyCreateClassAllocate) run"

	| picoClass emptyClass |

	PicoBlop 
		initialize;
		manuallyDefineClass.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	emptyClass := picoClass send: #new.
	self assert: emptyClass picoClassId equals: #PicoClass.
	self assert:  emptyClass picoSuperclassId isNil.
	self assert:  emptyClass picoIVs isNil.
	self assert:  emptyClass picoMethodDict isNil.
	self assert:  emptyClass picoClassName isNil
]
