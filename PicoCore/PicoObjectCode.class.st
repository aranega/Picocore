"
error: arrayOfArguments

	('Error ', arrayOfArguments first) trace.
	^ 'Error ', arrayOfArguments first
"
Class {
	#name : #PicoObjectCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-CoreCodeRepository'
}

{ #category : #'error handling' }
PicoObjectCode >> error: arrayOfArguments [
	| msg |
	msg := ('Error: message ', arrayOfArguments first, ' not found in class ', self picoClassId).
	msg trace.
	^ msg
]

{ #category : #testing }
PicoObjectCode >> initialize [ 

	^ self
]

{ #category : #'error handling' }
PicoObjectCode >> introspectReadVariable: aSymbol [

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

{ #category : #testing }
PicoObjectCode >> owner [

	^ self picoOwner 
]

{ #category : #testing }
PicoObjectCode >> picoClass [

	^ self picoClass 
]
