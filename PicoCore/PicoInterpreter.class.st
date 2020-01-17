Class {
	#name : #PicoInterpreter,
	#superclass : #RBBetterProgramNodeVisitor,
	#instVars : [
		'receiver',
		'stack'
	],
	#category : #PicoCore
}

{ #category : #initialization }
PicoInterpreter >> initialize [ 
	super initialize.
	stack := Stack new. 
	self pushNewScope
]

{ #category : #initialization }
PicoInterpreter >> newScope [
	^ Dictionary new
]

{ #category : #visiting }
PicoInterpreter >> pushNewScope [

	stack push: self newScope
	
]

{ #category : #accessing }
PicoInterpreter >> receiver [
	^ receiver
]

{ #category : #accessing }
PicoInterpreter >> receiver: anObject [
	receiver := anObject
]

{ #category : #visiting }
PicoInterpreter >> visitAssignmentNode: anAssignmentNode [
	" for a naive version without temp."
	
	"self at: (self offsetFromObjectOfInstanceVariable: anAssignmentNode name) put: "
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
PicoInterpreter >> visitMessageNode: aMessageNode [

	self pushNewScope.
	super visitMessageNode: aMessageNode

]

{ #category : #visiting }
PicoInterpreter >> visitMethodNode: aMethodNode [
	self visitArgumentNodes: aMethodNode arguments.
	aMethodNode pragmas do: [ :each | self visitNode: each ].
		"to be revisited when visitMethodNode: gets better design"
	^ self visitNode: aMethodNode body
]

{ #category : #visiting }
PicoInterpreter >> visitReturnNode: aMethodNode [
	super visitReturnNode: aMethodNode.
	stack pop
]

{ #category : #visiting }
PicoInterpreter >> visitSequenceNode: aSequenceNode [
	self visitTemporaryNodes: aSequenceNode temporaries.
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	"why am I forced to write such code? "
	^  self visitNode: aSequenceNode statements last
]
