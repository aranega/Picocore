Class {
	#name : #BaselineOfPicoCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfPicoCore
}

{ #category : #baselines }
BaselineOfPicoCore >> baseline: spec [
	<baseline>
	spec
		baseline: 'ContainersPropertyEnvironment'
		with: [ spec repository: 'github://Ducasse/Containers-PropertyEnvironment' ].
	spec
		baseline: 'Champollion'
		with: [ spec repository: 'github://Ducasse/Champollion' ].	
	spec
		for: #pharo
		do: [ 
			spec
				package: 'PicoCore' with: [ spec requires: #('ContainersPropertyEnvironment' 'Champollion') ] ]
]
