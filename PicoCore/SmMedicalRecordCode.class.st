Class {
	#name : #SmMedicalRecordCode,
	#superclass : #PicoCodeRepository,
	#type : #variable,
	#instVars : [
		'notes',
		'address',
		'patient'
	],
	#category : #'PicoCore-Sm Example'
}

{ #category : #accessing }
SmMedicalRecordCode >> addNote: aNote [
	notes add: aNote
]

{ #category : #accessing }
SmMedicalRecordCode >> address [
	^ address
]

{ #category : #accessing }
SmMedicalRecordCode >> address: anObject [
	address := anObject
]

{ #category : #accessing }
SmMedicalRecordCode >> initialize [

	notes := OrderedCollection new
]

{ #category : #accessing }
SmMedicalRecordCode >> notes [
	^ notes
]

{ #category : #accessing }
SmMedicalRecordCode >> notes: anObject [
	notes := anObject
]

{ #category : #accessing }
SmMedicalRecordCode >> owner [ 
	
	^ self picoOwner
]

{ #category : #accessing }
SmMedicalRecordCode >> patient [
	^ patient
]

{ #category : #accessing }
SmMedicalRecordCode >> patient: anObject [
	patient := anObject
]
