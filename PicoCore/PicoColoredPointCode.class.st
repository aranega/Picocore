Class {
	#name : #PicoColoredPointCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-CodeRepository'
}

{ #category : #'for lookup tests' }
PicoColoredPointCode >> foo [ 
	
	'PicoColoredPoint>>foo' traceCr.
	^ (super send: #foo) + (super send: #foo)
]

{ #category : #'for lookup tests' }
PicoColoredPointCode >> returnSuper [

	^ super
]
