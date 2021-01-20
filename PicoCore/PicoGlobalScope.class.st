Class {
	#name : #PicoGlobalScope,
	#superclass : #CHGlobalScope,
	#category : #'PicoCore-Core'
}

{ #category : #'meta-object-protocol' }
PicoGlobalScope >> read: aString [ 

	^ PicoBlop giveClassNamed: aString
]
