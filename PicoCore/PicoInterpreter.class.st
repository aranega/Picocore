Class {
	#name : #PicoInterpreter,
	#superclass : #RBBetterProgramNodeVisitor,
	#instVars : [
		'receiver',
		'stack',
		'arguments',
		'argumentIndex'
	],
	#category : #PicoCore
}

{ #category : #accessing }
PicoInterpreter >> arguments: anArray [
	arguments := anArray
]

{ #category : #initialization }
PicoInterpreter >> initialize [ 
	super initialize.
	stack := Stack new. 
	arguments := #().
	self pushNewScope
]

{ #category : #'stack management' }
PicoInterpreter >> newScope [
	^ CTEnvironment new
]

{ #category : #'stack management' }
PicoInterpreter >> pushNewScope [
	"Pushing a new scope consists in creating a new dictionary whose parent is the top of the stack
	and pushing it as a new top. This way variable not found in current scope will be looked up in previous scope."

	| newTop |
	newTop := self newScope.
	newTop parent: stack top.
	stack push: newTop 
	
]

{ #category : #accessing }
PicoInterpreter >> receiver [
	^ receiver
]

{ #category : #accessing }
PicoInterpreter >> receiver: anObject [
	receiver := anObject
]

{ #category : #'stack management' }
PicoInterpreter >> setValueOfTempVariable: name to: aValue [
	^ stack top at: name put: aValue 
]

{ #category : #'stack management' }
PicoInterpreter >> valueOfTempVariable: name [
	^ stack top at: name
]

{ #category : #visiting }
PicoInterpreter >> visitAssignmentNode: anAssignmentNode [
	"for a naive version without temp."
	| value |
	value := self visitNode: anAssignmentNode value. 
	anAssignmentNode variable isInstance
		ifTrue: [ receiver setValueOfInstanceVariable: anAssignmentNode variable name to: value ]
		ifFalse: [ self setValueOfTempVariable: anAssignmentNode variable name to: value ]
]

{ #category : #visiting }
PicoInterpreter >> visitInstanceVariableNode: aVariableNode [

	^ receiver valueOfInstanceVariable: aVariableNode name
]

{ #category : #visiting }
PicoInterpreter >> visitLiteralNode: aLiteralNode [
	
	^ aLiteralNode value
]

{ #category : #visiting }
PicoInterpreter >> visitMessageArgumentNode: aNode [

	self halt.
]

{ #category : #visiting }
PicoInterpreter >> visitMessageNode: aMessageNode [

	self pushNewScope.
	super visitMessageNode: aMessageNode

]

{ #category : #'visiting variable' }
PicoInterpreter >> visitParameterNode: aNode [
	
	stack top at: aNode name put: (arguments at: argumentIndex).
	argumentIndex := argumentIndex + 1. 
]

{ #category : #visiting }
PicoInterpreter >> visitParameterNodes: aCol [
	"We visit the parameter list of a method. Basically a list of variable"
	
	argumentIndex := 1.
	super visitParameterNodes: aCol
]

{ #category : #visiting }
PicoInterpreter >> visitReturnNode: aMethodNode [
	| val | 
	val := super visitReturnNode: aMethodNode.
	stack pop.
	^ val
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitSelfNode: aSelfNode [

	^ receiver
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitSuperNode: aSuperNode [

	^ receiver
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitTemporaryNode2: aNode [
	"is it a temp definition temp node or a temp usage?"
	^ self valueOfTempVariable: aNode name
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitVariableNode: aNode [

	^ self valueOfTempVariable: aNode name
]
