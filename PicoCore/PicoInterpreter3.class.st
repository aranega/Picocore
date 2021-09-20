Class {
	#name : #PicoInterpreter3,
	#superclass : #PicoInterpreter2,
	#category : #'PicoCore-Core'
}

{ #category : #executing }
PicoInterpreter3 >> instanceScopeClass [
	^ PicoInstanceSlotScope
]
