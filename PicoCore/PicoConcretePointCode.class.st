Class {
	#name : #PicoConcretePointCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#category : #'PicoCore-Metaclass Example'
}

{ #category : #initialization }
PicoConcretePointCode >> initialize [ 
	x := 1000.
	y := 2000.
]

{ #category : #initialization }
PicoConcretePointCode >> x [ 
	"Pay attention that this x refers to the state stored in a blop instance and not an instance of this class."
	
	^ x
]

{ #category : #initialization }
PicoConcretePointCode >> y [ 
	"Pay attention that this y refers to the state stored in a blop instance and not an instance of this class."
	
	^ y
]
