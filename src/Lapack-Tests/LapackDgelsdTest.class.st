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
	fixture := LapackDgelsdFixture new.
	
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
		with: fixture minimumNormSolution
		do: [ :elem1 :elem2 | self assert: elem1 closeTo: elem2 ]
]

{ #category : #tests }
LapackDgelsdTest >> testOptimalWorkArraySize [

	self assert: algorithm optimalWorkArraySize equals: fixture optimalWorkArraySize
]

{ #category : #tests }
LapackDgelsdTest >> testRank [

	self assert: algorithm rank equals: fixture rank
]

{ #category : #tests }
LapackDgelsdTest >> testSingularValues [

	algorithm singularValues
		with: fixture singularValues
		do: [ :elem1 :elem2 | self assert: elem1 closeTo: elem2 ]
]
