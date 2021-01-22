Class {
	#name : #SmDoctorCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#instVars : [
		'name'
	],
	#category : #'PicoCore-Sm Example'
}

{ #category : #accessing }
SmDoctorCode >> name [
	^ name
]

{ #category : #accessing }
SmDoctorCode >> name: anObject [
	name := anObject
]
