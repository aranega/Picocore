Class {
	#name : #SlotsPicoTest,
	#superclass : #PicoTest,
	#instVars : [
		'picoClass',
		'doctorClass',
		'picoObject',
		'picoDoctor',
		'picoClassWithSlot',
		'interpreter'
	],
	#category : #'PicoCore-Tests'
}

{ #category : #tests }
SlotsPicoTest >> createInterpreter [
	interpreter := PicoInterpreter2 new.
	self fillUpGlobalEnvironmentOf: interpreter.
	interpreter
		globalEnvironmentAt: #OrderedCollection put: OrderedCollection;
		globalEnvironmentAt: #IdentityDictionary put: IdentityDictionary;
		globalEnvironmentAt: #PicoBlop put: PicoBlop.
]

{ #category : #tests }
SlotsPicoTest >> loadPicoCoreCompatibleClass: aClass [

	"now we pay attention to really use the non abstract metaclass"

	| superclass |
	superclass := aClass superclass = PicoCodeRepository
		              ifTrue: [ #PicoObject ]
		              ifFalse: [ aClass superclass name asSymbol ].
	^ picoClass
		  send: #createClassNamed:inheritsFrom:instVars:
		  withArguments: { 
				  (aClass name withoutSuffix: 'Code') asSymbol.
				  (superclass withoutSuffix: 'Code') asSymbol.
				  (aClass instanceVariables collect: [ :e | e name asSymbol ]) }
]

{ #category : #tests }
SlotsPicoTest >> picoClassWithSlot [ 
	
	"now we pay attention to really use the non abstract metaclass"
	| slotClass slot |
	self loadPicoCoreCompatibleClass: DefaultSlotCode.
	slotClass := self loadPicoCoreCompatibleClass: InstanceVariableSlotCode.
	slot := slotClass send: #new.
	slot send: #name: withArguments: {#s1}.   
	^ picoClass
		send: #createClassNamed:inheritsFrom:instVars:slots:
		withArguments:
			{#SimpleClass.
			#PicoObject.
			#().
			{#s1 -> slot} asDictionary }.
]

{ #category : #tests }
SlotsPicoTest >> setUp [ 
	super setUp.
	PicoBlop bootstrap.
	picoClass := PicoBlop giveClassNamed: #PicoClass.
	picoObject := PicoBlop giveClassNamed: #PicoObject.
	picoDoctor := self loadPicoCoreCompatibleClass: DoctorCode.  
	picoClassWithSlot := self picoClassWithSlot.
]

{ #category : #tests }
SlotsPicoTest >> testAccessSlot [

	| newInstance |
	newInstance := picoClassWithSlot send: #new.
	self assert: (newInstance send: #s1) equals: nil.

	newInstance send: #s1: withArguments: { 42 }.
	self assert: (newInstance send: #s1) equals: 42
]

{ #category : #tests }
SlotsPicoTest >> testAllocate [
  "self  run: #testAllocate"

  | newInstance |
  newInstance := picoDoctor send: #new.
  self assert: (newInstance at: 1) equals: #Doctor.
  self assert: newInstance size equals: 2.
  self assert: (newInstance at: 2) isNil.
  
  
]
