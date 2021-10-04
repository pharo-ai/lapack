Class {
	#name : #LapackDgelsdTest,
	#superclass : #TestCase,
	#instVars : [
		'algorithm',
		'example'
	],
	#category : #'Lapack-Tests'
}

{ #category : #initialization }
LapackDgelsdTest >> setUp [
	super setUp.
	example := LapackDgelsdExample new.
	
	algorithm := LapackDgelsd new
		numberOfRows: example numberOfRows;
		numberOfColumns: example numberOfColumns;
		numberOfRightHandSides: example numberOfRightHandSides;
		matrixA: example matrixA;
		matrixB: example matrixB;
		yourself.
		
	algorithm solve.
]

{ #category : #accessing }
LapackDgelsdTest >> testInfo [
	
	self assert: algorithm info equals: 0.
]

{ #category : #accessing }
LapackDgelsdTest >> testMinimumNormSolution [
	
	self
		assert: algorithm minimumNormSolution
		closeTo: example minimumNormSolution.
]

{ #category : #accessing }
LapackDgelsdTest >> testOptimalWorkArraySize [
	
	self
		assert: algorithm optimalWorkArraySize
		equals: example optimalWorkArraySize.
]

{ #category : #accessing }
LapackDgelsdTest >> testRank [
	
	self
		assert: algorithm rank
		equals: example rank.
]

{ #category : #accessing }
LapackDgelsdTest >> testSingularValues [
	
	self
		assert: algorithm singularValues
		closeTo: example singularValues.
]
