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
	"At this stage Object does not exist, yet."
	| newClass |
	newClass := self send: #new.
	newClass picoClassName: aSymbol.
	newClass picoSuperclassId: aSuperclassSymbol.
	newClass computeIVForBootstrapOfSuperclassSymbol: aSuperclassSymbol iv: instVars.
	"this class is only used to create Class and Object so let us 
	hardcode it. And we do not have support for loops and conditional in Pico..."
		
	newClass initializeMethodDictionaryFromCodeRepositoryFor: aSymbol.
	"PicoBlop is a kind of world for us so it always exist.
	We can access it and the interpreter knows it."
	PicoBlop declareClass: newClass.
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
	
	| inst |
	inst := (self send: #allocate).
	inst send: #initialize.
	^ inst
]
