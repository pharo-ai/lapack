Class {
	#name : #LapackDgesvdTest,
	#superclass : #TestCase,
	#instVars : [
		'algorithm',
		'fixture'
	],
	#category : #'Lapack-Tests'
}

{ #category : #initialization }
LapackDgesvdTest >> setUp [

	super setUp.
	fixture := LapackDgesvdFixture.
	
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
	
	self
		assert: (algorithm matrixU first: fixture numberOfRows * fixture numberOfColumns)
		closeTo: fixture matrixU.
]

{ #category : #tests }
LapackDgesvdTest >> testMatrixVTransposed [
	
	self
		assert: algorithm matrixVTransposed
		closeTo: fixture matrixVTransposed.
]

{ #category : #tests }
LapackDgesvdTest >> testSingularValues [
	
	self
		assert: (algorithm singularValues first: fixture numberOfColumns)
		closeTo: fixture singularValues.
]
