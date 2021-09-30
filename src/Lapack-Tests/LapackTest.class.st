"
A LapackTest is a test class for testing the behavior of Lapack
"
Class {
	#name : #LapackTest,
	#superclass : #TestCase,
	#instVars : [
		'lapack',
		'm',
		'n',
		'nrhs',
		'lda',
		'ldb',
		'rcond',
		'rank',
		'work',
		'info'
	],
	#category : #'Lapack-Tests'
}

{ #category : #'as yet unclassified' }
LapackTest >> arrayA [

	^ {
		0.12. -6.91. -3.33.  3.97.
      	-8.19.  2.22. -8.94.  3.33.
      	7.69. -5.12. -6.72. -2.74.
      	-2.26. -9.08. -4.40. -7.92.
      	-4.71.  9.96. -9.98. -3.20
	} asFFIExternalArrayOfType: 'double'
]

{ #category : #'as yet unclassified' }
LapackTest >> arrayB [

	^ {
		7.30.  1.33.  2.68. -9.62.  0.00.
		0.47.  6.58. -1.71. -0.79.  0.00.
		-6.28. -3.42.  3.46.  0.41.  0.00
	} asFFIExternalArrayOfType: 'double'
]

{ #category : #'as yet unclassified' }
LapackTest >> arrayIWork [
	"iwork dimension should be at least 3*min(m,n)*nlvl + 11*min(m,n),
   where nlvl = max( 0, int( log_2( min(m,n)/(smlsiz+1) ) )+1 )
   and smlsiz = 25"

	| size |
	size := (3 * m * 0) + (11 * m).
	^ FFIExternalArray newType: 'int' size: size.
]

{ #category : #'as yet unclassified' }
LapackTest >> arrayS [

	^ FFIExternalArray newType: 'double' size: m.
]

{ #category : #tests }
LapackTest >> findOptimalWorkspace [
	"Just the method that calls another method.
	This way we avoid copying a super long method call"
	
	^ lapack
		findOptimalWorkspace: m 
		n: n 
		nrhs: nrhs 
		a: self arrayA 
		lda: lda 
		b: self arrayB 
		ldb: ldb 
		s: self arrayS 
		rcond: rcond 
		rank: rank 
		work: work  
		iwork: self arrayIWork 
		info: info.
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
	
	"Empty values"
	rank := 0.
	info := 0.
	
	"Negative rcond means using default (machine precision) value"
	rcond := -1.0.
		
	lapack := Lapack new.
]

{ #category : #tests }
LapackTest >> testDgelsd [
	
	| lwork |
	
	lwork := self findOptimalWorkspace.
	work := FFIExternalArray newType: 'double' size: lwork.
	
	lapack
		ffiDgelsdM: m 
		n: n 
		nrhs: nrhs 
		a: self arrayA 
		lda: lda 
		b: self arrayB 
		ldb: ldb 
		s: self arrayS 
		rcond: rcond 
		rank: rank 
		work: work 
		lwork: lwork 
		iwork: self arrayIWork 
		info: info
]

{ #category : #tests }
LapackTest >> testFindOptimalWorkspace [

	self
		assert: self findOptimalWorkspace
		equals: 936. 
]
