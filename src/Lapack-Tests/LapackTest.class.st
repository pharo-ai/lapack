"
A LapackTest is a test class for testing the behavior of Lapack
"
Class {
	#name : #LapackTest,
	#superclass : #TestCase,
	#instVars : [
		'm',
		'n',
		'nrhs',
		'lda',
		'ldb'
	],
	#category : #'Lapack-Tests'
}

{ #category : #'as yet unclassified' }
LapackTest >> matrixA [

	^ {
		0.12. -6.91. -3.33.  3.97.
      	-8.19.  2.22. -8.94.  3.33.
      	7.69. -5.12. -6.72. -2.74.
      	-2.26. -9.08. -4.40. -7.92.
      	-4.71.  9.96. -9.98. -3.20
	}
]

{ #category : #'as yet unclassified' }
LapackTest >> matrixB [

	^ {
		7.30.  1.33.  2.68. -9.62.  0.00.
		0.47.  6.58. -1.71. -0.79.  0.00.
		-6.28. -3.42.  3.46.  0.41.  0.00
	}
]

{ #category : #'as yet unclassified' }
LapackTest >> setUp [ 
	"https://software.intel.com/sites/products/documentation/doclib/mkl_sa/11/mkl_lapack_examples/dgelsd_ex.c.htm"
	
	super setUp.
	m := 4.
	n := 5.
	nrhs := 3.
	lda := m.
	ldb := n.
	
]

{ #category : #tests }
LapackTest >> testFirst [
	
	| lp work size s rcond rank iwork infoPtr lwork |
	lp := Lapack new.
	work := #().
	size := lp
		findOptimalWorkspace: m 
		n: n 
		nrhs: nrhs 
		a: self matrixA 
		lda: lda 
		b: self matrixB 
		ldb: ldb 
		s: s 
		rcond: rcond 
		rank: rank 
		work: work  
		iwork: iwork 
		info: infoPtr.
	
	lp 
		ffiDgelsdM: m 
		n: n 
		nrhs: nrhs 
		a: self matrixA 
		lda: lda 
		b: self matrixB 
		ldb: ldb 
		s: s 
		rcond: rcond 
		rank: rank 
		work: work 
		lwork: lwork 
		iwork: iwork 
		info: infoPtr
]
