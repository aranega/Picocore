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
PicoFakedClassCode >> createClassNamed: aSymbol inheritsFrom: aSuperclassSymbol instVars: instVars [ 

	| newClass |
	newClass := self send: #new.
	"the following could be done also why message sends."
	newClass picoClassName: aSymbol.
	newClass picoSuperclassId: aSuperclassSymbol.
	newClass picoIVs: instVars.
	newClass initializeMethod initializeMethodDictionaryFromCodeRepositoryFor: aSymbol.
	^ newClass
	
	
]

{ #category : #'class behavior' }
PicoFakedClassCode >> initialize [ 
	
	self picoClassName: #YouShouldNameMe.
	self picoSuperclassId: #YouShouldNameMeToo.
	self picoIVs: #().
	self picoMethodDict: (IdentityDictionary new: 3).
	^ self
]

{ #category : #'class behavior' }
PicoFakedClassCode >> new [ 

	^ (self send: #allocate) send: #initialize
]
