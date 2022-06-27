Class {
	#name : #BaselineOfAILapack,
	#superclass : #BaselineOf,
	#category : #BaselineOfAILapack
}

{ #category : #baselines }
BaselineOfAILapack >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"Packages"
		spec 
			package: 'Lapack';
			package: 'Lapack-Algorithms' with: [ spec requires: #('Lapack') ];
			package: 'Lapack-Tests' with: [ spec requires: #('Lapack' 'Lapack-Algorithms') ] ].
]
