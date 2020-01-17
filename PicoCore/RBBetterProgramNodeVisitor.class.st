Class {
	#name : #RBBetterProgramNodeVisitor,
	#superclass : #RBProgramNodeVisitor,
	#category : #PicoCore
}

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageArgumentNode: aNode [
	self visitNode: aNode
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageArgumentNodes: aCol [

	aCol do: [ :each | self visitMessageArgumentNode: each ]
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageNode: aMessageNode [
	(aMessageNode isCascaded not or: [ aMessageNode isFirstCascaded ])
		ifTrue: [ self visitMessageReceiver: aMessageNode receiver ].
	self visitMessageArgumentNodes: aMessageNode
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMessageReceiver: aNode [
	self visitNode: aNode
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #visiting }
RBBetterProgramNodeVisitor >> visitMethodNode: aMethodNode [
	self visitArgumentNodes: aMethodNode arguments.
	aMethodNode pragmas do: [ :each | self visitNode: each ].
	^ self visitMethodBodyNode: aMethodNode body
]
