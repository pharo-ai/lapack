Class {
	#name : #LapackDgelsdTest,
	#superclass : #TestCase,
	#instVars : [
		'algorithm',
		'fixture'
	],
	#category : #'Lapack-Tests'
}

{ #category : #initialization }
LapackDgelsdTest >> setUp [
	super setUp.
	fixture := LapackDgelsdFixture.
	
	algorithm := LapackDgelsd new
		numberOfRows: fixture numberOfRows;
		numberOfColumns: fixture numberOfColumns;
		numberOfRightHandSides: fixture numberOfRightHandSides;
		matrixA: fixture matrixA;
		matrixB: fixture matrixB;
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
		closeTo: fixture minimumNormSolution.
]

{ #category : #accessing }
LapackDgelsdTest >> testOptimalWorkArraySize [
	
	self
		assert: algorithm optimalWorkArraySize
		equals: fixture optimalWorkArraySize.
]

{ #category : #accessing }
LapackDgelsdTest >> testRank [
	
	self
		assert: algorithm rank
		equals: fixture rank.
]

{ #category : #accessing }
LapackDgelsdTest >> testSingularValues [
	
	self
		assert: algorithm singularValues
		closeTo: fixture singularValues.
]
