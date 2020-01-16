Class {
	#name : #PicoInterpreter,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'receiver'
	],
	#category : #PicoCore
}

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

	self halt.
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
	self halt. 
	(aMessageNode isCascaded not or: [ aMessageNode isFirstCascaded ])
		ifTrue: [ self visitNode: aMessageNode receiver ].
	aMessageNode arguments do: [ :each | self visitNode: each ]
]

{ #category : #visiting }
PicoInterpreter >> visitMethodNode: aMethodNode [
	self visitArgumentNodes: aMethodNode arguments.
	aMethodNode pragmas do: [ :each | self visitNode: each ].
		"to be revisited when visitMethodNode: gets better design"
	^ self visitNode: aMethodNode body
]

{ #category : #visiting }
PicoInterpreter >> visitSequenceNode: aSequenceNode [
	self visitTemporaryNodes: aSequenceNode temporaries.
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	"why am I forced to write such code? "
	^  self visitNode: aSequenceNode statements last
]
