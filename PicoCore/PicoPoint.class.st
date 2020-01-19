Class {
	#name : #PicoPoint,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #PicoCore
}

{ #category : #messages }
PicoPoint >> dotProduct: aPicoPoint [ 
	"Answer a number that is the dot product of the receiver and the argument, aPoint. 
	That is, the two points are multipled and the coordinates of the result summed."

	^ (x * (aPicoPoint send: #x)) + (y * (aPicoPoint send: #y))
]

{ #category : #messages }
PicoPoint >> halfDotProduct: aPicoPoint [ 
	"this example illustrates that the receiver should change over the execution.
	Here in the first expression it is the receiver then its argument."

	^ (self send: #x) * (aPicoPoint send: #x) 
]

{ #category : #'internal messages' }
PicoPoint >> playingWithString [

	^ 'pico core is cool' size
]

{ #category : #'return and access' }
PicoPoint >> return100 [

	^ 100
]

{ #category : #messages }
PicoPoint >> sendingMessageToArgument: aPicoPoint [ 
	
	^ (aPicoPoint send: #x) 
]

{ #category : #messages }
PicoPoint >> sendingMessageToArgument: anEvilPoint withArg: arg [
	
	^ (anEvilPoint send: #x) + arg
]

{ #category : #messages }
PicoPoint >> sendingMessageToArgument: aPicoPoint withDifferentArgument: anArg [
	
	aPicoPoint send: #x: withArguments: {33}.
	^ aPicoPoint send: #x
]

{ #category : #'simple temp manipulation' }
PicoPoint >> settingAValueFromTempToTemp2 [

	| temp temp2 | 
	temp := 10.
	temp2 := temp.
	^ temp2
]

{ #category : #'simple temp manipulation' }
PicoPoint >> settingAValueToTemp [

	| temp | 
	temp := 10.
	^ temp
]

{ #category : #'simple temp manipulation' }
PicoPoint >> settingAValueToTemp2 [

	| temp | 
	temp := 10.
	temp := 20.
	^ temp
]

{ #category : #'internal messages' }
PicoPoint >> simpleMessage [

	^ 10 * 10
]

{ #category : #messages }
PicoPoint >> summingArg: arg1 arg2: arg2 [
	
	^ arg1 + arg2
]

{ #category : #'internal messages' }
PicoPoint >> usingTempValue [

	| temp | 
	temp := 10.
	temp := temp + temp.
	^ temp
]

{ #category : #'return and access' }
PicoPoint >> x [ 

	^ x
]

{ #category : #'return and access' }
PicoPoint >> x: anInteger [

	x := anInteger
]

{ #category : #'return and access' }
PicoPoint >> y [

	^ y
]

{ #category : #'return and access' }
PicoPoint >> y: anInteger [

	y := anInteger
]
