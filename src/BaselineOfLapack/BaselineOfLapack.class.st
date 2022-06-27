Class {
	#name : #BaselineOfLapack,
	#superclass : #BaselineOf,
	#category : #BaselineOfLapack
}

{ #category : #baselines }
BaselineOfLapack >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"Packages"
		spec 
			package: 'Lapack';
			package: 'Lapack-Algorithms' with: [ spec requires: #('Lapack') ];
			package: 'Lapack-Tests' with: [ spec requires: #('Lapack' 'Lapack-Algorithms') ] ].
]
