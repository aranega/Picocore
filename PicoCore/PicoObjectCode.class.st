"
error: arrayOfArguments

	('Error ', arrayOfArguments first) trace.
	^ 'Error ', arrayOfArguments first
"
Class {
	#name : #PicoObjectCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #PicoCore
}

{ #category : #'error handling' }
PicoObjectCode >> error: arrayOfArguments [

	('Error ', arrayOfArguments first) trace.
	^ 'Error ', arrayOfArguments first
]

{ #category : #'error handling' }
PicoObjectCode >> introspectReadVariable: aSymbol [

	"^ self send: #valueOfInstanceVariable: withArguments: {aSymbol}"
	^ self valueOfInstanceVariable: aSymbol
]

{ #category : #'error handling' }
PicoObjectCode >> introspectWriteVariable: aSymbol value: aValue [

	self at: (self offsetFromObjectOfInstanceVariable: aSymbol) put: aValue
]

{ #category : #testing }
PicoObjectCode >> isClass [

	^ false
]

{ #category : #testing }
PicoObjectCode >> isMetaclass [

	^ false
]

{ #category : #testing }
PicoObjectCode >> klass [

	^ self picoClass 
]
