"
I'm an hybrid interpreter for the pico language. 
Pico language is nearly the same as Pharo except that it does not return in block, not blocks.
Pico only supports: 
	- message sends using send: and send:withArgument:
	- primitive compution using any pharo messages`
	- assignemt
	- direct access to variables stored in picoBlop objects.
	
For example 

dotProduct: aPicoPoint 
	""Answer a number that is the dot product of the receiver and the argument, aPoint. 
	That is, the two points are multipled and the coordinates of the result summed.""

	^ (x * (aPicoPoint send: #x)) + (y * (aPicoPoint send: #y))
	

Implementation
	arguments is an array to be able to pass arguments from a picoBlop expression to the interpreter.
	Internally the arguments are pushed in the current scope via this variable. 
	
"
Class {
	#name : #PicoInterpreter,
	#superclass : #RBBetterProgramNodeVisitor,
	#instVars : [
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
	^ self valueOfTempVariable: #self
]

{ #category : #accessing }
PicoInterpreter >> receiver: anObject [
	self setValueOfTempVariable: #self to: anObject 
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
PicoInterpreter >> visitArrayNode: anArrayNode [

	^ anArrayNode children collect: [ :each | self visitNode: each ]
]

{ #category : #visiting }
PicoInterpreter >> visitAssignmentNode: anAssignmentNode [
	"for a naive version without temp."
	| value |
	value := self visitNode: anAssignmentNode value. 
	anAssignmentNode variable isInstance
		ifTrue: [ self receiver setValueOfInstanceVariable: anAssignmentNode variable name to: value ]
		ifFalse: [ self setValueOfTempVariable: anAssignmentNode variable name to: value ]
]

{ #category : #visiting }
PicoInterpreter >> visitInstanceVariableNode: aVariableNode [

	^ self receiver valueOfInstanceVariable: aVariableNode name
]

{ #category : #visiting }
PicoInterpreter >> visitLiteralNode: aLiteralNode [
	
	^ aLiteralNode value
]

{ #category : #visiting }
PicoInterpreter >> visitMessageArgumentNodes: aCol [

	^ aCol collect: [ :each | self visitMessageArgumentNode: each ]
]

{ #category : #visiting }
PicoInterpreter >> visitMessageNode: aMessageNode [
	
	^ ((aMessageNode selector = #send:) or: [ aMessageNode selector = #send:withArguments:  ])
		ifTrue: [ 
			| rec |
			self pushNewScope.
			rec := (self visitMessageReceiver: aMessageNode receiver).
			self setValueOfTempVariable: #self to: rec. 
			arguments := aMessageNode arguments allButFirst flatCollect: [ :each | self visitNode: each ].
				"here the arguments are passed in a { } so we should dewrap."
			^ self visitMethodNode: (rec picoClass primitiveLookup: aMessageNode arguments first value)
			]
		
		ifFalse: [  
			"we evaluate the receiver and the arguments and execute the selector using them."
			(self visitMessageReceiver: aMessageNode receiver) 
				perform: aMessageNode selector 	
				withArguments: (self visitMessageArgumentNodes: aMessageNode arguments)
			 ]

]

{ #category : #'visiting variable' }
PicoInterpreter >> visitParameterNode: aNode [
	
	self setValueOfTempVariable: aNode name to: (arguments at: argumentIndex).
	argumentIndex := argumentIndex + 1. 
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitParameterNodes: aCol [

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

	^ self receiver
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitSuperNode: aSuperNode [

	^ self receiver
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitTemporaryDeclarationNode: aTemporaryDeclarationNode [
	"We do nothing for declaration of temps since there is no initial value in the temps definition"

	^ self
]

{ #category : #'visiting variable' }
PicoInterpreter >> visitVariableNode: aNode [

	^ self valueOfTempVariable: aNode name
]
