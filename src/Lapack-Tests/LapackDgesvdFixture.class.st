"
Source: https://www.intel.com/content/www/us/en/develop/documentation/onemkl-lapack-examples/top/least-squares-and-eigenvalue-problems/singular-value-decomposition/gesvd-function/dgesvd-example/dgesvd-example-c.html
"
Class {
	#name : #LapackDgesvdFixture,
	#superclass : #Object,
	#category : #'Lapack-Tests'
}

{ #category : #accessing }
LapackDgesvdFixture >> matrixA [

	^ #(
		8.79   6.11  -9.15   9.57  -3.49   9.84
		9.93   6.91  -7.93   1.64   4.02   0.15
		9.83   5.04   4.86   8.83   9.80  -8.99
		5.45  -0.27   4.85   0.74   10.00 -6.02
		3.16   7.98   3.01   5.80   4.27  -5.31)
]

{ #category : #accessing }
LapackDgesvdFixture >> matrixU [

	^ #(
		-0.59  -0.40  -0.03  -0.43  -0.47   0.29
		 0.26   0.24  -0.60   0.24  -0.35   0.58
		 0.36  -0.22  -0.45  -0.69   0.39  -0.02
		 0.31  -0.75   0.23   0.33   0.16   0.38
		 0.23  -0.36  -0.31   0.16  -0.52  -0.65)
]

{ #category : #accessing }
LapackDgesvdFixture >> matrixVTransposed [

	^ #(
		-0.25   0.81  -0.26   0.40  -0.22
		-0.40   0.36   0.70  -0.45   0.14
		-0.69  -0.25  -0.22   0.25   0.59
		-0.37  -0.37   0.39   0.43  -0.63
		-0.41  -0.10  -0.49  -0.62  -0.44)
]

{ #category : #accessing }
LapackDgesvdFixture >> numberOfColumns [

	^ 5
]

{ #category : #accessing }
LapackDgesvdFixture >> numberOfRows [

	^ 6
]

{ #category : #accessing }
LapackDgesvdFixture >> optimalWorkArraySize [

	^ 0
]

{ #category : #accessing }
LapackDgesvdFixture >> singularValues [

	^ #(27.47 22.64 8.56 5.99 2.01)
]
