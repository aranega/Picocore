Class {
	#name : #PicoInstanceSlotScope,
	#superclass : #CHInstanceScope,
	#category : #'PicoCore-Core'
}

{ #category : #accessing }
PicoInstanceSlotScope >> definedVariables [
	^ receiver picoClass picoIVs, receiver picoClass picoSlots keys
]

{ #category : #'meta-object-protocol' }
PicoInstanceSlotScope >> read: aString [

	| rcvr |
	rcvr := self receiver.
	rcvr picoClass picoSlots
		at: aString asSymbol
		ifPresent: [:slot | ^ slot send: #read: withArguments: {receiver} ]
		ifAbsent: [ ^ rcvr valueOfInstanceVariable: aString ]
]

{ #category : #'meta-object-protocol' }
PicoInstanceSlotScope >> write: aString withValue: aValue [

	| rcvr |
	rcvr := self receiver.
	rcvr picoClass picoSlots
		at: aString asSymbol
		ifPresent: [ :slot | 
			^ slot send: #write:to: withArguments: { 
					  aValue.
					  receiver } ]
		ifAbsent: [ 
		^ self receiver setValueOfInstanceVariable: aString to: aValue ]
]
