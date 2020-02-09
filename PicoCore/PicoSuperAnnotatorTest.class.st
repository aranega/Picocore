Class {
	#name : #PicoSuperAnnotatorTest,
	#superclass : #TestCase,
	#instVars : [
		'pointClass',
		'coloredPointClass'
	],
	#category : #PicoCore
}

{ #category : #running }
PicoSuperAnnotatorTest >> setUp [ 

	pointClass := PicoBlop new: 5.
	{ #PicoClass . #PicoPoint . #PicoObject . { #class . #x . #y } . 5 }
		withIndexDo: [ :each :i | pointClass at: i put: each ].
	pointClass initializeMethodDictionaryFrom: PicoPointCode.
	PicoBlop initializePicoClassEnvironment.
	PicoBlop declareClass: pointClass.
	
	coloredPointClass := PicoBlop new: 5.
	{ #PicoClass . #PicoColoredPoint . #PicoPoint . { #class . #x . #y . #color} . 5 }
		withIndexDo: [ :each :i | coloredPointClass at: i put: each ].
	coloredPointClass initializeMethodDictionaryFrom: PicoColoredPointCode.
	PicoBlop declareClass: coloredPointClass.
	
	
	
]

{ #category : #tests }
PicoSuperAnnotatorTest >> testSuperIsAnnotatedWithDefinitionClass [
	| method annotator |
	annotator := RBPicoSuperAnnotator annotateSuperWithClass: coloredPointClass.
	method := coloredPointClass bodyOfMethod: #returnSuper.
	annotator visitNode: method. 
	self assert: (method children first statements first  value propertyAt: #definitionClass) equals: coloredPointClass.
]
