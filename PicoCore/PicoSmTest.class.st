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

{ #category : #'test - basics' }
PicoSmTest >> testDoctorNameAndIdSetAndGet [

	| s1 |
	s1 := doctorClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]

{ #category : #'test - basics' }
PicoSmTest >> testMedicalRecord [

	| m1 |
	m1 := medicalRecordClass send: #new.
	self assert: (m1 send: #notes) class equals: OrderedCollection
	
]

{ #category : #'test - basics' }
PicoSmTest >> testMedicalRecordIsCreatedByAPatient [

	| p1 parm m1 |
	p1 := patientClass send: #new.
	p1 send: #name:  withArguments: { 'Dupond' }.
	parm := IdentityDictionary new.
	parm at: #address put: 'Belgique'.
	parm at: #patient put: p1.
	
	m1 := p1 create: #SmMedicalRecord with: parm.
	
	self assert: (m1 send: #owner) equals: p1
	
]

{ #category : #'test - basics' }
PicoSmTest >> testMedicalRecordIsCreatedByAPatientLowLevel [
	| p m1 |
	p := patientClass send: #new.
	m1 := medicalRecordClass send: #new.
	m1 privateOwnedBySetter: p.

	"the following test shows that owner is accessible in the language (high level)"
	self assert: (m1 send: #owner) equals: p.
	
	"the following test shows that owner is primitive potentially not accessible from the language (high level)"
	self assert: m1 picoOwner equals: p
]

{ #category : #'test - basics' }
PicoSmTest >> testSourceIdSetAndGet [

	| s1 |
	s1 := sourceClass send: #new.
	s1 send: #id: withArguments: { #Source1}.
	self assert: (s1 send: #id) equals: #Source1
]
