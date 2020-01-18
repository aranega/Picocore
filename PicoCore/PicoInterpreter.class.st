"
Random notes for me. 

Since I only have a point in pico. I should do two messages in a row to the same object.
Later I can think about creating anew point from pico itself. 

I have to make a distinction between a pico Send and a pharo send. 

dotProduct: aPicoPoint 
	""Answer a number that is the dot product of the receiver and the argument, aPoint. 
	That is, the two points are multipled and the coordinates of the result summed.""

	^ (x * (aPicoPoint send: #x)) + (y * (aPicoPoint send: #y))
	
so during message interpretation I will have to mkae the distinction between pharo code and picocode. 

"
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
	arguments := #().
	stack := Stack new.
	"We create the first empty environment." 
	stack push: self newScope.
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

{ #category : #accessing }
PicoInterpreter >> stack [
	^ stack
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
PicoInterpreter >> visitMessageNode: aMessageNode [

	self pushNewScope.
	"newscope should also contains receiver and arguments. 
	else we cannot have a different kind of receiver 
	"
	^ ((aMessageNode selector = #send:) or: [ aMessageNode selector = #send:withArguments:  ])
		ifTrue: [ self halt. "This is a pico message. " ]
		ifFalse: [  
			(self visitMessageReceiver: aMessageNode receiver) 
				perform: aMessageNode selector 	
				withArguments: (self visitMessageArgumentNodes: aMessageNode arguments)
			 ]

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
PicoInterpreter >> visitVariableNode: aNode [

	^ self valueOfTempVariable: aNode name
]
