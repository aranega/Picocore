Class {
	#name : #PicoColoredPointCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #PicoCore
}

{ #category : #'for lookup tests' }
PicoColoredPointCode >> foo [ 
	
	'PicoColoredPoint>>foo' traceCr.
	^ (self superSend: #foo) + self superSend: #foo
]
