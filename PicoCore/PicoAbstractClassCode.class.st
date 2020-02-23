Class {
	#name : #PicoAbstractClassCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-Metaclass Example'
}

{ #category : #'class behavior' }
PicoAbstractClassCode >> allocate [

	^ Error signal: 'The class ', self picoClassName asString, ' is abstract.'
]
