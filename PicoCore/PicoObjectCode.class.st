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
