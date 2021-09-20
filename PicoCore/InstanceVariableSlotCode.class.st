Class {
	#name : #InstanceVariableSlotCode,
	#superclass : #DefaultSlotCode,
	#type : #variable,
	#category : #'PicoCore-Tests'
}

{ #category : #'instance creation' }
InstanceVariableSlotCode class >> named: aName [
	^ self new name: aName
]

{ #category : #accessing }
InstanceVariableSlotCode >> read: anObject [

	| index |
	index := anObject picoClass picoSlots keys indexOf: name.
	^ anObject at: anObject picoClass picoIVs size + index
]

{ #category : #accessing }
InstanceVariableSlotCode >> size [ 
	^ 1
]

{ #category : #accessing }
InstanceVariableSlotCode >> write: aValue to: anObject [

	| index |
	index := anObject picoClass picoSlots keys indexOf: name.
	^ anObject at: anObject picoClass picoIVs size + index put: aValue
]
