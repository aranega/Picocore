Class {
	#name : #PicoBlopTest1,
	#superclass : #TestCase,
	#instVars : [
		'pointClass',
		'aPoint',
		'coloredPointClass',
		'aColoredPoint'
	],
	#category : #PicoCore
}

{ #category : #running }
PicoBlopTest1 >> assembleColoredPointClass [
	
	"This is not the way to create classes. Here we are testing primitives before the bootstrap of the kernel so we do everything by hand. In future tests we will retest these functionalities using a full kernel version."
	
	coloredPointClass := PicoBlop new: 5.
	coloredPointClass at: coloredPointClass offsetForName put: #PicoColoredPoint.
	coloredPointClass at: coloredPointClass offsetForClass put: #PicoClass.
	coloredPointClass at: coloredPointClass offsetForIVs put: #(#class #x #y #color).
	coloredPointClass at: coloredPointClass offsetForSuperclass put: #PicoPoint.
	coloredPointClass at: coloredPointClass offsetForMethodDict put: (IdentityDictionary new).
	coloredPointClass initializeMethodDictionaryFrom: PicoColoredPointCode.
	PicoBlop declareClass: coloredPointClass.

]

{ #category : #running }
PicoBlopTest1 >> assembleColoredPointInstance [
	aColoredPoint := PicoBlop new: 3.
	aColoredPoint at: 1 put: #PicoColoredPoint.
	aColoredPoint at: 2 put: 10.
	aColoredPoint at: 3 put: 15.
	aColoredPoint at: 4 put: Color red
]

{ #category : #running }
PicoBlopTest1 >> assemblePointClass [
	
	"This is not the way to create classes. Here we are testing primitives before the bootstrap of the kernel so we do everything by hand. In future tests we will retest these functionalities using a full kernel version."
	
	pointClass := PicoBlop new: 5.
	pointClass at: pointClass offsetForName put: #PicoPoint.
	pointClass at: pointClass offsetForClass put: #PicoClass.
	pointClass at: pointClass offsetForIVs put: #(#class #x #y).
	pointClass at: pointClass offsetForSuperclass put: #PicoObject.
	pointClass at: pointClass offsetForMethodDict put: (IdentityDictionary new).
	pointClass initializeMethodDictionaryFrom: PicoPointCode.
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
	self assembleColoredPointClass.
]

{ #category : #'step5-tests-allocate' }
PicoBlopTest1 >> testAllocate [
  "(self  selector: #testAllocate) run"
  | newInstance |
  newInstance := pointClass allocateAnInstance.
  self assert: (newInstance at: 1) equals: #PicoPoint.
  self assert: newInstance size equals: 3.
  self assert: (newInstance at: 2) isNil.
  self assert: (newInstance at: 3) isNil.
  self assert: newInstance picoClass equals: pointClass
]

{ #category : #'step3-tests-class access' }
PicoBlopTest1 >> testClassAccess [
	"(self  selector: #testClassAccess) run"
	
	self assert: (aPoint picoClass = pointClass)
]

{ #category : #'step4-tests-iv management' }
PicoBlopTest1 >> testIVOffsetAskingTheClass [
	"(self  selector: #testIVOffsetAskingTheClass) run"

	self assert: (pointClass offsetFromClassOfInstanceVariable: #x ) equals: 2.
	self assert: (pointClass offsetFromClassOfInstanceVariable: #lulu ) equals:  0
]

{ #category : #'step4-tests-iv management' }
PicoBlopTest1 >> testIVOffsetAskingTheInstance [
	"(self  selector: #testIVOffsetAskingTheInstance) run"

	self assert: (pointClass offsetFromClassOfInstanceVariable: #x) equals: 2.
	self assert: (pointClass offsetFromClassOfInstanceVariable: #lulu) equals: 0
]

{ #category : #'step4-tests-iv management' }
PicoBlopTest1 >> testIVValue [
	"(self  selector: #testIVOffsetAndValue) run"

	self assert: (aPoint valueOfInstanceVariable: #x) equals: 10
]

{ #category : #'step7-tests-initialize' }
PicoBlopTest1 >> testInstanceVariableInheritance [
	"(self  selector: #testInstanceVariableInheritance) run"

	"a better choice would be to throw an exception if there are duplicates"
	self assert: 
			(PicoBlop new computeNewIVFrom: #(#a #b #c #d) asOrderedCollection
				with: #(#a #z #b #t) asOrderedCollection)
					equals: #(#a #b #c #d #z #t) asOrderedCollection.
	self assert: 
			(PicoBlop new computeNewIVFrom: #() asOrderedCollection
				with: #(#a #z #b #t) asOrderedCollection)
					equals: #(#a #z #b #t) asOrderedCollection
]

{ #category : #'step8-lookup' }
PicoBlopTest1 >> testLookupMethodInSuperclass [
	| method |
	method := coloredPointClass lookup: #x.
	self assert: method equals: (pointClass bodyOfMethod: #x)
]

{ #category : #'step6-method-API' }
PicoBlopTest1 >> testMethodManagmentBodyOfMethod [
	"(self  selector: #testMethodManagmentBodyOfMethod) run"
	
	self assert: ((pointClass bodyOfMethod: #x) isKindOf: RBProgramNode )

]

{ #category : #'step6-method-API' }
PicoBlopTest1 >> testMethodManagmentUnderstandGoodMethod [
	"(self  selector: #testMethodManagmentUnderstandGoodMethod) run"

	self assert: (pointClass doesUnderstand: #x).

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

{ #category : #'step8-lookup' }
PicoBlopTest1 >> testSimpleLookup [
	| method |
	method := pointClass lookup: #x:.
	self assert: method equals: (pointClass bodyOfMethod: #x:)
]
