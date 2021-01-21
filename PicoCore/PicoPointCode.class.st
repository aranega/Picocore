"
I'm a class which should not be instantiated and I'm just a container of methods to be associated to an instance of the PicoBlop class when such instance represents the class PicoPoint.

So direct references to instance variables are in fact interpreted as references to instance variable 
represented in a blop instance. 
"
Class {
	#name : #PicoPointCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-ExampleCodeRepository'
}

{ #category : #'internal messages' }
PicoPointCode >> accessGlobal [

	^ PicoPoint
]

{ #category : #'for lookup tests' }
PicoPointCode >> condition [
	
	^ true
		ifTrue: [ 3 ]
		ifFalse: [ 5 ] 
]

{ #category : #messages }
PicoPointCode >> directAccessToX [

	^ x
]

{ #category : #messages }
PicoPointCode >> dotProduct2: aPicoPoint [ 
	"Answer a number that is the dot product of the receiver and the argument, aPoint. 
	That is, the two points are multipled and the coordinates of the result summed."

	^ ((self send: #x) * (aPicoPoint send: #x)) + ((self send: #y) * (aPicoPoint send: #y))
]

{ #category : #messages }
PicoPointCode >> dotProduct: aPicoPoint [ 
	"Answer a number that is the dot product of the receiver and the argument, aPoint. 
	That is, the two points are multipled and the coordinates of the result summed."

	^ (x * (aPicoPoint send: #x)) + (y * (aPicoPoint send: #y))
]

{ #category : #'for lookup tests' }
PicoPointCode >> foo [ 
	
	'PicoPoint>>foo' traceCr.
	^ 5
]

{ #category : #messages }
PicoPointCode >> halfDotProduct: aPicoPoint [ 

	^ x * (aPicoPoint send: #x) 
]

{ #category : #'return and access' }
PicoPointCode >> initialize [ 
	x := 1000.
	y := 2000.
]

{ #category : #'internal messages' }
PicoPointCode >> messageSendToGlobal [

	"I would expect more PicoPoint allocate for example but here this definition is stupid"
	^ PicoBlop giveClassNamed: #PicoPoint ifAbsent: [nil].
]

{ #category : #messages }
PicoPointCode >> methodAccessingTemp [

	| temp |
	^ temp
]

{ #category : #messages }
PicoPointCode >> methodWithTemp [

	| temp |
	
	temp := 7.
	^ self send: #methodAccessingTemp
]

{ #category : #'for lookup tests' }
PicoPointCode >> notOverridenFoo [ 
	
	'PicoPoint>>notOverridenFoo' traceCr.
	^ 55
]

{ #category : #'internal messages' }
PicoPointCode >> playingWithString [

	^ 'pico core is cool' size
]

{ #category : #'return and access' }
PicoPointCode >> return100 [

	^ 100
]

{ #category : #messages }
PicoPointCode >> sendingMessageToArgument: aPicoPoint [ 
	
	^ (aPicoPoint send: #x) 
]

{ #category : #messages }
PicoPointCode >> sendingMessageToArgument: anEvilPoint withArg: arg [
	
	^ (anEvilPoint send: #x) + arg
]

{ #category : #messages }
PicoPointCode >> sendingMessageToArgument: aPicoPoint withDifferentArgument: anArg [
	
	aPicoPoint send: #x: withArguments: {33}.
	^ aPicoPoint send: #x
]

{ #category : #'simple temp manipulation' }
PicoPointCode >> settingAValueFromTempToTemp2 [

	| temp temp2 | 
	temp := 10.
	temp2 := temp.
	^ temp2
]

{ #category : #'simple temp manipulation' }
PicoPointCode >> settingAValueToTemp [

	| temp | 
	temp := 10.
	^ temp
]

{ #category : #'simple temp manipulation' }
PicoPointCode >> settingAValueToTemp2 [

	| temp | 
	temp := 10.
	temp := 20.
	^ temp
]

{ #category : #'internal messages' }
PicoPointCode >> simpleMessage [

	^ 10 * 10
]

{ #category : #messages }
PicoPointCode >> summingArg: arg1 arg2: arg2 [
	
	^ arg1 + arg2
]

{ #category : #messages }
PicoPointCode >> swappingArg: arg1 arg2: arg2 [
	
	^ self send: #summingArg:arg2: withArguments: { arg1 . arg2}
]

{ #category : #'internal messages' }
PicoPointCode >> usingTempValue [

	| temp | 
	temp := 10.
	temp := temp + temp.
	^ temp
]

{ #category : #'return and access' }
PicoPointCode >> x [ 
	"Pay attention that this x refers to the state stored in a blop instance and not an instance of this class."
	
	^ x
]

{ #category : #'return and access' }
PicoPointCode >> x: anInteger [

	x := anInteger
]

{ #category : #'return and access' }
PicoPointCode >> y [

	^ y
]

{ #category : #'return and access' }
PicoPointCode >> y: anInteger [

	y := anInteger
]
