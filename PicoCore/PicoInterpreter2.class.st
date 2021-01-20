Class {
	#name : #PicoInterpreter2,
	#superclass : #CHInterpreter,
	#category : #'PicoCore-Core'
}

{ #category : #visiting }
PicoInterpreter2 >> visitInstanceVariableNode: aVariableNode [

	^ self receiver valueOfInstanceVariable: aVariableNode name
]
