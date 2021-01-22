Class {
	#name : #SmPatientCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#instVars : [
		'name'
	],
	#category : #'PicoCore-Sm Example'
}

{ #category : #accessing }
SmPatientCode >> name [
	^ name
]

{ #category : #accessing }
SmPatientCode >> name: anObject [
	name := anObject
]
