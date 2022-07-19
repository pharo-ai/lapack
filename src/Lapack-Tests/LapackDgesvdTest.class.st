Class {
	#name : #LapackDgesvdTest,
	#superclass : #TestCase,
	#instVars : [
		'algorithm',
		'fixture'
	],
	#category : #'Lapack-Tests'
}

{ #category : #running }
LapackDgesvdTest >> setUp [

	super setUp.
	fixture := LapackDgesvdFixture new.
	
	algorithm := LapackDgesvd new
		numberOfRows: fixture numberOfRows;
		numberOfColumns: fixture numberOfColumns;
		matrixA: fixture matrixA;
		yourself.

	algorithm solve
]

{ #category : #tests }
LapackDgesvdTest >> testInfo [
	
	self assert: algorithm info equals: 0.
]

{ #category : #tests }
LapackDgesvdTest >> testMatrixU [

	(algorithm matrixU first: fixture numberOfRows * fixture numberOfColumns)
		with: fixture matrixU
		do: [ :real :expected | self assert: real closeTo: expected ]
]

{ #category : #tests }
LapackDgesvdTest >> testMatrixVTransposed [

	algorithm matrixVTransposed
		with: fixture matrixVTransposed
		do: [ :real :expected | self assert: real closeTo: expected ]
]

{ #category : #tests }
LapackDgesvdTest >> testSingularValues [

	(algorithm singularValues first: fixture numberOfColumns)
		with: fixture singularValues
		do: [ :real :expected | self assert: real closeTo: expected ]
]
