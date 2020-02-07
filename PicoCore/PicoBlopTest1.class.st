Class {
	#name : #PicoBlopTest1,
	#superclass : #TestCase,
	#instVars : [
		'pointClass',
		'aPoint'
	],
	#category : #PicoCore
}

{ #category : #running }
PicoBlopTest1 >> assemblePointClass [
	
	pointClass := PicoBlop new: 5.
	pointClass at: pointClass offsetForName put: #PicoPoint.
	pointClass at: pointClass offsetForClass put: #PicoClass.
	pointClass at: pointClass offsetForIVs put: #(#class #x #y).
	pointClass at: pointClass offsetForSuperclass put: #PicoObject.
	pointClass at: pointClass offsetForMethodDict
		put: (IdentityDictionary new).
	PicoBlop declareClass: pointClass.

]

{ #category : #running }
PicoBlopTest1 >> assemblePointInstance [
	aPoint := PicoBlop new: 3.
	aPoint at: 1 put: #PicoPoint.
	aPoint at: 2 put: 10.
	aPoint at: 3 put: 15
]

{ #category : #running }
PicoBlopTest1 >> setUp [ 
	self assemblePointClass.
	self assemblePointInstance. 
]

{ #category : #'step1-tests-structure of objects' }
PicoBlopTest1 >> testPrimitiveStructureObjClassIdForSimpleObject [
	"self run: #testPrimitiveStructureObjClassIdForSimpleObject"

	self assert: aPoint picoClassId equals: #PicoPoint

]

{ #category : #'step2-tests-structure of classes' }
PicoBlopTest1 >> testPrimitiveStructureObjIVs [
	"(self selector: #testPrimitiveStructureObjIVs) run"

	self assert: (pointClass picoIVs) equals: #(#class #x #y)

]

{ #category : #'step2-tests-structure of classes' }
PicoBlopTest1 >> testPrimitiveStructureObjName [
	"(self selector: #testPrimitiveStructureObjName) run"

	self assert: pointClass picoName equals: #PicoPoint
	
]

{ #category : #'step2-tests-structure of classes' }
PicoBlopTest1 >> testPrimitiveStructureObjSuperclassId [
	"(self selector: #testPrimitiveStructureObjSuperclassId) run"

	self assert: pointClass picoSuperclassId equals: #PicoObject.

]

{ #category : #'step1-tests-structure of objects' }
PicoBlopTest1 >> testPrimitiveStructurePicoClassId [
	"(self selector: #testPrimitiveStructureObjClassId) run"

	self assert: pointClass picoClassId equals: #PicoClass

]
