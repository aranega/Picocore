"
This is the final class definition once the kernel is bootstrapped.
"
Class {
	#name : #PicoClassCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-CoreCodeRepository'
}

{ #category : #instantiation }
PicoClassCode >> allocate [

	^ self allocateAnInstance
]

{ #category : #instantiation }
PicoClassCode >> createClassNamed: aSymbol inheritsFrom: aSuperclassSymbol instVars: instVars [ 
	
	| newClass picoSuperclass |
	newClass := self send: #new.
	newClass picoClassName: aSymbol.
	newClass picoSuperclassId: aSuperclassSymbol.
	picoSuperclass := PicoBlop giveClassNamed: aSuperclassSymbol.
	newClass picoIVs: (newClass computeNewIVFrom: picoSuperclass picoIVs with: instVars).
	"this class is only used to create Class and Object so let us 
	hardcode it. And we do not have support for loops and conditional in Pico..."
	newClass initializeMethodDictionaryFromCodeRepositoryFor: aSymbol.
	PicoBlop declareClass: newClass.
	^ newClass
	
	
]

{ #category : #instantiation }
PicoClassCode >> initialize [ 
	
	self picoClassName: #YouShouldNameMe.
	self picoSuperclassId: #YouShouldNameMeToo.
	self picoIVs: #().
	self picoMethodDict: (IdentityDictionary new: 3).
	^ self
]

{ #category : #testing }
PicoClassCode >> isClass [ 
	"an object is a class if is class is a metaclass. cool"
	
	^ (self send: #picoClass) send: #isMetaclass
]

{ #category : #testing }
PicoClassCode >> isMetaclass [ 
	"we could also return true since Class is the first metaclass."
	
	^ self picoIVs includes: #superclass
]

{ #category : #instantiation }
PicoClassCode >> new [ 
	
	| inst |
	inst := (self send: #allocate).
	inst send: #initialize.
	^ inst
]
