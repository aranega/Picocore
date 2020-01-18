Class {
	#name : #PicoCodeRepositoryForPoint,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #PicoCore
}

{ #category : #message }
PicoCodeRepositoryForPoint >> distanceToOrigin [

	^ self x * self x + (self y * self y)
]

{ #category : #'return and access' }
PicoCodeRepositoryForPoint >> return100 [

	^ 100
]

{ #category : #'simple temp manipulation' }
PicoCodeRepositoryForPoint >> settingAValueFromTempToTemp2 [

	| temp temp2 | 
	temp := 10.
	temp2 := temp.
	^ temp2
]

{ #category : #'simple temp manipulation' }
PicoCodeRepositoryForPoint >> settingAValueToTemp [

	| temp | 
	temp := 10.
	^ temp
]

{ #category : #'simple temp manipulation' }
PicoCodeRepositoryForPoint >> settingAValueToTemp2 [

	| temp | 
	temp := 10.
	temp := 20.
	^ temp
]

{ #category : #message }
PicoCodeRepositoryForPoint >> simpleMessage [

	^ 10 * 10
]

{ #category : #message }
PicoCodeRepositoryForPoint >> usingTempValue [

	| temp | 
	temp := 10.
	temp := temp + temp.
	^ temp
]

{ #category : #'return and access' }
PicoCodeRepositoryForPoint >> x [ 

	^ x
]

{ #category : #'return and access' }
PicoCodeRepositoryForPoint >> x: anInteger [

	x := anInteger
]

{ #category : #'return and access' }
PicoCodeRepositoryForPoint >> y [

	^ y
]

{ #category : #'return and access' }
PicoCodeRepositoryForPoint >> y: anInteger [

	y := anInteger
]
