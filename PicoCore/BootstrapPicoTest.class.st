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
		initializePicoClassEnvironment;
		manuallySetClassStructure.
		
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	self assert: picoClass picoClassName equals: #PicoClass.
	self assert: picoClass picoClassId equals: #PicoClass.
	self assert: picoClass picoClass equals: picoClass.
	self assert: picoClass picoSuperclassId equals: #picoObject.	
	"the fact that the created first class inherits form ObjObject is not necessary
	because there is no super calls"
	self assert: picoClass picoIVs equals: #(#class #name #superclass #iv #methodDict).
	
]
