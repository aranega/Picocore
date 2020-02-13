"
This is the first faked class definition before Object exists.
"
Class {
	#name : #PicoFakedClassCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-CoreCodeRepository'
}

{ #category : #'class behavior' }
PicoFakedClassCode >> allocate [

	^ self allocateAnInstance
]

{ #category : #'class behavior' }
PicoFakedClassCode >> initialize [ 
	
	| picoSuperclass |
	"self initializeUsing: initArray. missing"
	picoSuperclass := PicoBlop giveClassNamed: self picoSuperclassId ifAbsent: [nil].
	picoSuperclass isNil
		ifFalse: [ self picoIVs: (self computeNewIVFrom: picoSuperclass picoIVs with: self picoIVs)]
		ifTrue: [self picoIVs: (self computeNewIVFrom: #(#class) with: self picoIVs)].
	
	self picoMethodDict: (IdentityDictionary new: 3).
	PicoBlop declareClass: self.
	^ self
]

{ #category : #'class behavior' }
PicoFakedClassCode >> new [ 

	^ (self send: #allocate) send: #initialize
]
