"
I'm a class which should not be instantiated and I'm just a container of methods to be associated to an instance of the PicoBlop class when such instance represents the class PicoColoredPoint.

So direct references to instance variables are in fact interpreted as references to instance variable 
represented in a blop instance. 
"
Class {
	#name : #PicoColoredPointCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-ExampleCodeRepository'
}

{ #category : #'for lookup tests' }
PicoColoredPointCode >> error: args [
	
	^ 'Error on coloredPoint for message: ', args first
]

{ #category : #'for lookup tests' }
PicoColoredPointCode >> foo [ 
	
	'PicoColoredPoint>>foo' traceCr.
	^ (super send: #foo) + (super send: #foo)
]

{ #category : #'for lookup tests' }
PicoColoredPointCode >> returnSuper [

	^ super
]
