"
I am a superclass for the algorithms that solves a real, double precision for for GE matrices.
"
Class {
	#name : #LapackDGE,
	#superclass : #LapackAlgorithm,
	#instVars : [
		'workArraySize',
		'numberOfRows',
		'singularValues',
		'matrixA',
		'leadingDimensionA',
		'info',
		'numberOfColumns'
	],
	#category : #'Lapack-Algorithms'
}

{ #category : #testing }
LapackDGE class >> isAbstract [

	^ self = LapackDGE
]

{ #category : #accessing }
LapackDGE >> info [

	^ info
]

{ #category : #accessing }
LapackDGE >> leadingDimensionA [

	^ leadingDimensionA ifNil: [ 1 max: self numberOfRows ]
]

{ #category : #accessing }
LapackDGE >> leadingDimensionA: aNumber [

	leadingDimensionA := aNumber
]

{ #category : #accessing }
LapackDGE >> matrixA: aMatrix [

	matrixA := aMatrix
]

{ #category : #accessing }
LapackDGE >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
LapackDGE >> numberOfColumns: aNumber [

	numberOfColumns := aNumber
]

{ #category : #accessing }
LapackDGE >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
LapackDGE >> numberOfRows: aNumber [

	numberOfRows := aNumber
]

{ #category : #accessing }
LapackDGE >> singularValues [

	^ singularValues
]

{ #category : #running }
LapackDGE >> solve [

	^ self subclassResponsibility
]
