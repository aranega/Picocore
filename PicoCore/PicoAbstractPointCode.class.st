Class {
	#name : #PicoAbstractPointCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-Metaclass Example'
}

{ #category : #displaying }
PicoAbstractPointCode >> display [ 
	
	^ 'I am a ', self picoClassName asString, ' with (', (self send: #x) asString, ' , ' , (self send: #y ) asString, ')'
]
