Class {
	#name : #LapackDgesvdTest,
	#superclass : #TestCase,
	#instVars : [
		'algorithm',
		'fixture'
	],
	#category : #'Lapack-Tests'
}

{ #category : #asserting }
LapackDgesvdTest >> assert: actualNumber closeTo: expectedNumber precision: epsilon [

	self flag: #pharo10. "Remove this method when Pharo 11 will be the latest supported version of this project. 
	This is to fix float comparison problem like in https://github.com/pharo-project/pharo/pull/12615"

	^ self assert: (actualNumber - expectedNumber) abs <= epsilon description: [ self comparingStringBetween: actualNumber and: expectedNumber ]
]

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
		do: [ :real :expected | self assert: real closeTo: expected precision: 0.01 ]
]

{ #category : #tests }
LapackDgesvdTest >> testMatrixVTransposed [

	algorithm matrixVTransposed with: fixture matrixVTransposed do: [ :real :expected | self assert: real closeTo: expected precision: 0.01 ]
]

{ #category : #tests }
LapackDgesvdTest >> testSingularValues [

	(algorithm singularValues first: fixture numberOfColumns)
		with: fixture singularValues
		do: [ :real :expected | self assert: real closeTo: expected precision: 0.01 ]
]
