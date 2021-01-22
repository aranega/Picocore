Class {
	#name : #PicoSmTest,
	#superclass : #PicoTest,
	#instVars : [
		'picoClass',
		'picoObject',
		'sourceClass',
		'doctorClass',
		'patientClass',
		'medicalRecordClass'
	],
	#category : #'PicoCore-Sm Example'
}

{ #category : #running }
PicoSmTest >> defineDoctor [

	
	"now we pay attention to really use the non abstract metaclass"
	doctorClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmDoctor.
			#SmSource.
			#(name)}.
]

{ #category : #running }
PicoSmTest >> defineMedicalRecord [

	
	"now we pay attention to really use the non abstract metaclass"
	medicalRecordClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmMedicalRecord.
			#PicoObject.
			#(notes address patient)}.
]

{ #category : #running }
PicoSmTest >> definePatient [

	
	"now we pay attention to really use the non abstract metaclass"
	patientClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmPatient.
			#PicoObject.
			#(name)}.
]

{ #category : #running }
PicoSmTest >> defineSource [

	
	"now we pay attention to really use the non abstract metaclass"
	sourceClass := picoClass
		send: #createClassNamed:inheritsFrom:instVars:
		withArguments:
			{#SmSource.
			#PicoObject.
			#(id)}.
]

{ #category : #running }
PicoSmTest >> setUp [ 
	super setUp.
	PicoBlop bootstrap.
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	picoObject := PicoBlop giveClassNamed: #PicoObject.
	
	self defineSource.
	self definePatient.
	self defineDoctor.
	self defineMedicalRecord

]

{ #category : #running }
PicoSmTest >> testDoctorNameAndIdSetAndGet [

	| s1 |
	s1 := doctorClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]

{ #category : #running }
PicoSmTest >> testMedicalRecord [

	| s1 |
	s1 := medicalRecordClass send: #new.
	self assert: (s1 send: #notes) class equals: OrderedCollection
	
]

{ #category : #running }
PicoSmTest >> testSourceIdSetAndGet [

	| s1 |
	s1 := sourceClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]
