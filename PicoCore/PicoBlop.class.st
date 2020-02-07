Class {
	#name : #PicoBlop,
	#superclass : #Array,
	#type : #variable,
	#classInstVars : [
		'picoEnvironment'
	],
	#category : #PicoCore
}

{ #category : #'global class repository management' }
PicoBlop class >> declareClass: aPicoClass [ 
	"Return the class defined in the class repository with the name aSymbol"

	^ picoEnvironment at: aPicoClass picoClassName put: aPicoClass 
			
]

{ #category : #'global class repository management' }
PicoBlop class >> giveClassNamed: aSymbol [ 
	"Return the class defined in the class repository with the name aSymbol"

	^ self 
			giveClassNamed: aSymbol 
			ifAbsent: [self error: ('The class ' , aSymbol printString , ' is not defined')]
]

{ #category : #'global class repository management' }
PicoBlop class >> giveClassNamed: aSymbol ifAbsent: aBlock [

	^ picoEnvironment at: aSymbol ifAbsent: aBlock
]

{ #category : #'global class repository management' }
PicoBlop class >> initializePicoClassEnvironment [
	"could be better to have it as instance level so that we can test without breaking everything but this is a toy."
	
	picoEnvironment := Dictionary new
]

{ #category : #allocate }
PicoBlop >> allocateAnInstance [
	"Returns a newly created instance of self, an ObjClass. In this implementation the identifier of the object class is the name of the class. "

	| a |
	a := self class new: self picoNumberOfIVs.
	a picoClassId: self picoName.
	^a
]

{ #category : #methods }
PicoBlop >> initializeMethodDictionaryFrom: aPharoClass [

	self picoMethodDict: (self methodDictionaryFrom: aPharoClass)

	
]

{ #category : #methods }
PicoBlop >> methodDictionaryFrom: aPharoClass [
	| dict | 
	dict := IdentityDictionary new. 
	aPharoClass selectors do: [ :each | dict at: each put: (aPharoClass compiledMethodAt: each) ast ].
	^ dict
]

{ #category : #offsets }
PicoBlop >> offsetForClass [

	^ 1
]

{ #category : #offsets }
PicoBlop >> offsetForIVs [
	^ 4
]

{ #category : #offsets }
PicoBlop >> offsetForMethodDict [
	^ 5
]

{ #category : #offsets }
PicoBlop >> offsetForName [
	^ 2
]

{ #category : #offsets }
PicoBlop >> offsetForSuperclass [

	^3
]

{ #category : #'instance variables' }
PicoBlop >> offsetFromClassOfInstanceVariable: aSymbol [ 
	"Returns the index of the instance variable named aSymbol for an class anObjClass.
	Returns 0 if the aSymbol is not present in the instance variable lists of anObjClass"

	^ self picoIVs indexOf: aSymbol
]

{ #category : #'instance variables' }
PicoBlop >> offsetFromObjectOfInstanceVariable: aSymbol [
	"Returns the offset of the instance variable named aSymbol in the object anObjObject.
	If aSymbol is not an instance variable is not an instance variable of the object raise an error"

	| aClass |
	aClass := self picoClass.
	(aClass picoIVs includes: aSymbol) 
		ifFalse: [self error: 'The class ' , aClass objName asString
						, ' does not define the instance variable ' , aSymbol asString].
	^ aClass offsetFromClassOfInstanceVariable: aSymbol
]

{ #category : #basic }
PicoBlop >> picoClass [

	^ self class giveClassNamed: self picoClassId
]

{ #category : #'class structure' }
PicoBlop >> picoClassId [

	^ self at: self offsetForClass 
]

{ #category : #'class structure' }
PicoBlop >> picoClassId: ID [

	self at: self offsetForClass put: ID
]

{ #category : #'class structure' }
PicoBlop >> picoClassName [

	^ self at: self offsetForName
]

{ #category : #'class structure' }
PicoBlop >> picoClassName: aString [

	self at: self offsetForName put: aString
]

{ #category : #'class structure' }
PicoBlop >> picoIVs [
	"Receiver should be: anObjClass. Returns the list of instance variables"
	
	^self at: self offsetForIVs
]

{ #category : #'class structure' }
PicoBlop >> picoIVs: anOrderedCollection [ 
	"Receiver should be: anObjClass. Set the list of instance variable names of the receiver (anObjClass)"

	self at: self offsetForIVs put: anOrderedCollection
]

{ #category : #'class structure' }
PicoBlop >> picoMethodDict [

	^ self at: self offsetForMethodDict
]

{ #category : #'class structure' }
PicoBlop >> picoMethodDict: aDict [

	self at: self offsetForMethodDict put: aDict
]

{ #category : #basic }
PicoBlop >> picoName [

	^ 'PicoPoint'
]

{ #category : #basic }
PicoBlop >> picoNumberOfIVs [
	"for now class x y"
	^ 3
]

{ #category : #'class structure' }
PicoBlop >> picoSuperclassId [
	"Receiver should be: anObjClass. Returns the superclass id of the receiver (anObjClass)"

	^self at: self offsetForSuperclass
]

{ #category : #'class structure' }
PicoBlop >> picoSuperclassId: anObjClassId [
	"Receiver should be: anObjClass. Set the superclass id of the receiver (anObjClass)"

	self at: self offsetForSuperclass put: anObjClassId
]

{ #category : #lookup }
PicoBlop >> primitiveLookup: aSelector [

	^ self picoMethodDict at: aSelector
]

{ #category : #lookup }
PicoBlop >> send: aSelector [

	^ self send: aSelector withArguments: #()
]

{ #category : #lookup }
PicoBlop >> send: aSelector withArguments: anArray [

	aSelector numArgs = anArray size 
		ifFalse: [ self error: aSelector, ' does not expect ', anArray printString  ].
	^ PicoInterpreter new 
			receiver: self;
			arguments: anArray; 
			visitNode: (self picoClass primitiveLookup: aSelector)
]

{ #category : #'instance variables' }
PicoBlop >> setValueOfInstanceVariable: aSymbol to: value [
	"Return the value of the instance variable, aSymbol, of the receiver."
	
	self at: (self offsetFromObjectOfInstanceVariable: aSymbol) put: value 
]

{ #category : #'instance variables' }
PicoBlop >> valueOfInstanceVariable: aSymbol [ 
	"Return the value of the instance variable, aSymbol, of the receiver."
	
	^self at: (self offsetFromObjectOfInstanceVariable: aSymbol)
]
