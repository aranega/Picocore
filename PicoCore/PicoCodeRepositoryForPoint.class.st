Class {
	#name : #PicoCodeRepositoryForPoint,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #PicoCore
}

{ #category : #points }
PicoCodeRepositoryForPoint >> distanceToOrigin [

	^ self x * self x + (self y * self y)
]

{ #category : #points }
PicoCodeRepositoryForPoint >> return100 [

	^ 100
]

{ #category : #points }
PicoCodeRepositoryForPoint >> x [ 

	^ x
]

{ #category : #points }
PicoCodeRepositoryForPoint >> x: anInteger [

	x := anInteger
]

{ #category : #points }
PicoCodeRepositoryForPoint >> y [

	^ y
]

{ #category : #points }
PicoCodeRepositoryForPoint >> y: anInteger [

	y := anInteger
]
