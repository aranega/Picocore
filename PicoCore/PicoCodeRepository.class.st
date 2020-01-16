"
This class is to keep the methods of the pico core classes.

"
Class {
	#name : #PicoCodeRepository,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'color',
		'x',
		'y'
	],
	#category : #PicoCore
}

{ #category : #color }
PicoCodeRepository >> color [ 
	
	^ color 
]

{ #category : #points }
PicoCodeRepository >> distanceToOrigin [

	^ self x * self x + (self y * self y)
]

{ #category : #points }
PicoCodeRepository >> x [ 

	^ x
]

{ #category : #points }
PicoCodeRepository >> y [

	^ y
]
