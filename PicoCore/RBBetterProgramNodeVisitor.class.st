Class {
	#name : #RBBetterProgramNodeVisitor,
	#superclass : #RBProgramNodeVisitor,
	#category : #PicoCore
}

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitAllButLastStatementNodes: aCol [
	"Visit all the statements of a block body except the last one. See visitLastStatementNode:"

	^ aCol do: [ :each | self visitNode: each ]
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitArgumentNode: anArgumentNode [
	"Sent *each time* an argument node is found"
	"does nothing!"
	^ self
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitLastStatementNode: aNode [
	"Visit the last statement of a sequence node (method body or block body)."
	^ self visitNode: aNode
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageArgumentNode: aNode [
	^ self visitNode: aNode
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageArgumentNodes: aCol [

	^ aCol do: [ :each | self visitMessageArgumentNode: each ]
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageNode: aMessageNode [
	(aMessageNode isCascaded not or: [ aMessageNode isFirstCascaded ])
		ifTrue: [ self visitMessageReceiver: aMessageNode receiver ].
	self visitMessageArgumentNodes: aMessageNode arguments
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageReceiver: aNode [
	^ self visitNode: aNode
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMethodNode: aMethodNode [
	self visitParameterNodes: aMethodNode arguments.
	self visitPragmaNodes: aMethodNode pragmas.
	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitParameterNode: aNode [
	"We visit a single method parameter, usually a simple variable."
	
	^ self visitNode: aNode
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitParameterNodes: aCol [
	"We visit the **parameter** list of a method: in  foo: anInt, anInt is a parameter and not an argument. 
	We keep the term arguments for the actual objects pass to a message. Basically a list of variables"
	
	^ aCol do: [ :each | self visitParameterNode: each  ]
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitPragmaNode: aPragmaNode [
	^ self visitNode: aPragmaNode
	
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitPragmaNodes: aCol [
	^ aCol do: [ :each | self visitPragmaNode: each ]
	
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitSequenceNode: aSequenceNode [
	"Sequence nodes represent method or block body."
	
	self visitTemporaryNodes: aSequenceNode temporaries.
	self visitAllButLastStatementNodes: aSequenceNode statements allButLast.
	^ self visitLastStatementNode: aSequenceNode statements last
]
