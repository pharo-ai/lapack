"
Source: https://software.intel.com/sites/products/documentation/doclib/mkl_sa/11/mkl_lapack_examples/dgelsd_ex.c.htm
"
Class {
	#name : #LapackDgelsdFixture,
	#superclass : #Object,
	#category : #'Lapack-Tests'
}

{ #category : #accessing }
LapackDgelsdFixture class >> matrixA [

	^ AINativeFloatContiguousColumnMajorMatrix
		values: #( 0.12 -6.91 -3.33  3.97 -8.19
		  2.22 -8.94  3.33  7.69 -5.12
		 -6.72 -2.74 -2.26 -9.08 -4.40
		 -7.92 -4.71  9.96 -9.98 -3.20 ) asFloat64Array
		rows: self numberOfRows
		columns: self numberOfColumns
]

{ #category : #accessing }
LapackDgelsdFixture class >> matrixB [
	
	^ AINativeFloatContiguousColumnMajorMatrix
		values: #( 7.30  1.33  2.68 -9.62 0.00
		  0.47  6.58 -1.71 -0.79 0.00
		 -6.28 -3.42  3.46  0.41 0.00 ) asFloat64Array
		rows: 15
		columns: 1
]

{ #category : #accessing }
LapackDgelsdFixture class >> minimumNormSolution [
	
	^ #( -0.685765 -0.795005  0.376681  0.288496  0.291609
		  -0.243126 -0.083631  0.120785 -0.241508  0.352529
		   0.064233  0.211787 -0.654056  0.417589 -0.301543 )
]

{ #category : #accessing }
LapackDgelsdFixture class >> numberOfColumns [
	
	^ 5
]

{ #category : #accessing }
LapackDgelsdFixture class >> numberOfRightHandSides [
	
	^ 3
]

{ #category : #accessing }
LapackDgelsdFixture class >> numberOfRows [
	
	^ 4
]

{ #category : #accessing }
LapackDgelsdFixture class >> optimalWorkArraySize [

	^ 936
]

{ #category : #accessing }
LapackDgelsdFixture class >> rank [

	^ 4
]

{ #category : #accessing }
LapackDgelsdFixture class >> singularValues [

	^ #( 18.661317 15.988138 10.013671 8.507254 )
]
