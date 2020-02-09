Class {
	#name : #RBPicoSuperAnnotator,
	#superclass : #RBBetterProgramNodeVisitor,
	#instVars : [
		'definitionClass'
	],
	#category : #PicoCore
}

{ #category : #'instance creation' }
RBPicoSuperAnnotator class >> annotateSuperWithClass: aClass [ 
	^ self new 
		definitionClass: aClass; yourself.
]

{ #category : #accessing }
RBPicoSuperAnnotator >> definitionClass [
	^ definitionClass
]

{ #category : #accessing }
RBPicoSuperAnnotator >> definitionClass: anObject [
	definitionClass := anObject
]

{ #category : #visiting }
RBPicoSuperAnnotator >> visitSuperNode: aSuperNode [

	aSuperNode propertyAt: #definitionClass put: definitionClass
]
