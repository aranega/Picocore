Class {
	#name : #PicoInterpreter2,
	#superclass : #CHInterpreter,
	#category : #'PicoCore-Core'
}

{ #category : #visiting }
PicoInterpreter2 >> globalScopeClass [
	^ PicoGlobalScope
]

{ #category : #visiting }
PicoInterpreter2 >> instanceScopeClass [
	^ PicoInstanceScope
]

{ #category : #visiting }
PicoInterpreter2 >> visitArgumentNode: aNode [

	^ self tempAt: aNode name
]

{ #category : #visiting }
PicoInterpreter2 >> visitGlobalNode: aNode [

	^ PicoBlop giveClassNamed: aNode name ifAbsent: [nil]
]

{ #category : #visiting }
PicoInterpreter2 >> visitInstanceVariableNode: aVariableNode [

	^ self receiver valueOfInstanceVariable: aVariableNode name
]

{ #category : #visiting }
PicoInterpreter2 >> visitMessageNode: aMessageNode [
	| sel |
	sel := aMessageNode selector.
	^ ((sel = #send:) or: [ self = #send:withArguments: ])
		ifTrue: [ super visitMessageNode: aMessageNode ]
		ifFalse: 
			[ 
			sel isUnary
				ifTrue: [ (self visitNode: aMessageNode receiver) 
									perform: sel ]
				ifFalse: [ (self visitNode: aMessageNode receiver)
									perform: sel			 	
									withArguments: (aMessageNode arguments collect: [:each | self visitNode: each ] ) asArray ]]

]
