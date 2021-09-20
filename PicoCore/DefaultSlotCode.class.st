Class {
	#name : #DefaultSlotCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#instVars : [
		'name'
	],
	#category : #'PicoCore-Tests'
}

{ #category : #accessing }
DefaultSlotCode >> asSlot [
	^ self
]

{ #category : #accessing }
DefaultSlotCode >> index: anIndex [
	
]

{ #category : #accessing }
DefaultSlotCode >> isVirtual [
	^ false
]

{ #category : #accessing }
DefaultSlotCode >> name [
	^ name
]

{ #category : #accessing }
DefaultSlotCode >> name: aName [
	name := aName
]

{ #category : #accessing }
DefaultSlotCode >> read: anObject [
	^ 'S1SLOT', name
]

{ #category : #accessing }
DefaultSlotCode >> scope: aScope [

]

{ #category : #accessing }
DefaultSlotCode >> size [
	^ 0
]

{ #category : #accessing }
DefaultSlotCode >> write: aValue to: anObject [ 
	self halt.
]
