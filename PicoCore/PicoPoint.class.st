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

{ #category : #'return and access' }
PicoPoint >> return100 [

	^ 100
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
