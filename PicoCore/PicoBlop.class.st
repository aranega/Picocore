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

{ #category : #lookup }
PicoBlop >> lookup: aString [ 
	
	^ self picoMethodDict at: aString
]

{ #category : #'as yet unclassified' }
PicoBlop >> offsetMethodDict [
	^ 5
]

{ #category : #'as yet unclassified' }
PicoBlop >> picoClassId: ID [

	self at: 1 put: ID
]

{ #category : #'as yet unclassified' }
PicoBlop >> picoMethodDict [

	^ self at: self offsetMethodDict
]

{ #category : #'as yet unclassified' }
PicoBlop >> picoName [

	^ 'PicoPoint'
]

{ #category : #'as yet unclassified' }
PicoBlop >> picoNumberOfIVs [
	"for now class x y"
	^ 3
]

{ #category : #'as yet unclassified' }
PicoBlop >> primitiveAllocateAnInstance [
	"Returns a newly created instance of self, an ObjClass. In this implementation the identifier of the object class is the name of the class. "

	| a |
	a := self class new: self picoNumberOfIVs.
	a picoClassId: self picoName.
	^a
]

{ #category : #'as yet unclassified' }
PicoBlop >> primitiveLookup: aSelector [

	^ self picoMethodDict at: aSelector
]
