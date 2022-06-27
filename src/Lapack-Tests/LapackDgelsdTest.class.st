Class {
	#name : #LapackDgelsdTest,
	#superclass : #TestCase,
	#instVars : [
		'algorithm',
		'fixture'
	],
	#category : #'Lapack-Tests'
}

{ #category : #running }
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

	algorithm solve
]

{ #category : #tests }
LapackDgelsdTest >> testInfo [
	
	self assert: algorithm info equals: 0.
]

{ #category : #tests }
LapackDgelsdTest >> testMinimumNormSolution [
	algorithm minimumNormSolution
		with: fixture minimumNormSolution asArray
		do: [ :elem1 :elem2 |
			self assert: elem1 closeTo: elem2 ].
]

{ #category : #tests }
LapackDgelsdTest >> testOptimalWorkArraySize [
	
	self
		assert: algorithm optimalWorkArraySize
		equals: fixture optimalWorkArraySize.
]

{ #category : #tests }
LapackDgelsdTest >> testRank [
	
	self
		assert: algorithm rank
		equals: fixture rank.
]

{ #category : #tests }
LapackDgelsdTest >> testSingularValues [
	
	self
		assert: algorithm singularValues
		closeTo: fixture singularValues.
]
