Class {
	#name : #PicoGlobalScope,
	#superclass : #CHGlobalScope,
	#category : #'PicoCore-Core'
}

{ #category : #'meta-object-protocol' }
PicoGlobalScope >> read: aString [ 
	"unused for now."
	^ PicoBlop giveClassNamed: aString
]
