Class {
	#name : #BaselineOfLapack,
	#superclass : #BaselineOf,
	#category : #BaselineOfLapack
}

{ #category : #baselines }
BaselineOfLapack >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"Dependencies"
		spec
			baseline: 'AILinearAlgebra'
			with: [ spec repository: 'github://pharo-ai/linear-algebra/src' ].

		"Packages"
		spec 
			package: 'Lapack';
			package: 'Lapack-Algorithms' with: [ spec requires: #('Lapack' 'AILinearAlgebra') ];
			package: 'Lapack-Tests' with: [ spec requires: #('Lapack' 'Lapack-Algorithms') ] ].
]
