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
		'iwork',
		'info',
		'a',
		'b',
		's'
	],
	#pools : [
		'LapackConstants',
		'LapackTypes'
	],
	#category : #'Lapack-Tests'
}

{ #category : #'as yet unclassified' }
LapackTest >> doublePointer: aNumber [

	^ LapackDoublePointerClass new value: aNumber
]

{ #category : #'as yet unclassified' }
LapackTest >> expectedMinimumNormSolution [

	^ #(
		-0.69 -0.24 0.06
		-0.80 -0.08 0.21
		0.38 0.12 -0.65
		0.29 -0.24 0.42
		0.29 0.35 -0.30
	) asFFIExternalArrayOfType: 'double'.
]

{ #category : #'as yet unclassified' }
LapackTest >> expectedRank [

	^ 4
]

{ #category : #'as yet unclassified' }
LapackTest >> expectedSingularValues [

	^ #(18.66 15.99 10.01 8.51) asFFIExternalArrayOfType: 'double'.
]

{ #category : #tests }
LapackTest >> findOptimalWorkspace [
	"Just the method that calls another method.
	This way we avoid copying a super long method call"
	
	| mPtr nPtr nrhsPtr ldaPtr ldbPtr rankPtr infoPtr rcondPtr |
	
	mPtr := self integerPointer: m.
	nPtr := self integerPointer: n.
	nrhsPtr := self integerPointer: nrhs.
	ldaPtr := self integerPointer: lda.
	ldbPtr := self integerPointer: ldb.
	rankPtr := self integerPointer: rank.
	infoPtr := self integerPointer: info.
	rcondPtr := self doublePointer: rcond.
	
	^ lapack
		findOptimalWorkspace: mPtr 
		n: nPtr 
		nrhs: nrhsPtr
		a: a 
		lda: ldaPtr 
		b: b 
		ldb: ldbPtr 
		s: s 
		rcond: rcondPtr 
		rank: rankPtr 
		work: work  
		iwork: iwork 
		info: infoPtr.
]

{ #category : #'as yet unclassified' }
LapackTest >> initializeArrayA [

	^ {
		0.12. -6.91. -3.33.  3.97.
      	-8.19.  2.22. -8.94.  3.33.
      	7.69. -5.12. -6.72. -2.74.
      	-2.26. -9.08. -4.40. -7.92.
      	-4.71.  9.96. -9.98. -3.20
	} asFFIExternalArrayOfType: 'double'
]

{ #category : #'as yet unclassified' }
LapackTest >> initializeArrayB [

	^ {
		7.30.  1.33.  2.68. -9.62.  0.00.
		0.47.  6.58. -1.71. -0.79.  0.00.
		-6.28. -3.42.  3.46.  0.41.  0.00
	} asFFIExternalArrayOfType: 'double'
]

{ #category : #'as yet unclassified' }
LapackTest >> initializeArrayIWork [
	"iwork dimension should be at least 3*min(m,n)*nlvl + 11*min(m,n),
   where nlvl = max( 0, int( log_2( min(m,n)/(smlsiz+1) ) )+1 )
   and smlsiz = 25"

	| size |
	size := (3 * m * 0) + (11 * m).
	^ FFIExternalArray newType: 'int' size: size.
]

{ #category : #'as yet unclassified' }
LapackTest >> initializeArrayS [

	^ FFIExternalArray newType: 'double' size: m.
]

{ #category : #'as yet unclassified' }
LapackTest >> integerPointer: aNumber [

	^ LapackIntegerPointerClass new value: aNumber
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
	
	a := self initializeArrayA.
	b := self initializeArrayB.
	s := self initializeArrayS.
	iwork := self initializeArrayIWork.
		
	lapack := Lapack new.
]

{ #category : #tests }
LapackTest >> testDgelsd [
	
	| lwork mPtr nPtr nrhsPtr ldaPtr ldbPtr rankPtr infoPtr rcondPtr lworkPtr |
	
	lwork := self findOptimalWorkspace.
	work := FFIExternalArray newType: 'double' size: lwork.
	
	mPtr := self integerPointer: m.
	nPtr := self integerPointer: n.
	nrhsPtr := self integerPointer: nrhs.
	ldaPtr := self integerPointer: lda.
	ldbPtr := self integerPointer: ldb.
	rankPtr := self integerPointer: rank.
	infoPtr := self integerPointer: info.
	rcondPtr := self doublePointer: rcond.
	lworkPtr := self integerPointer: lwork.
	
	lapack
		ffiDgelsdM: mPtr 
		n: nPtr 
		nrhs: nrhsPtr 
		a: a 
		lda: ldaPtr 
		b: b
		ldb: ldbPtr 
		s: s 
		rcond: rcondPtr 
		rank: rankPtr 
		work: work 
		lwork: lworkPtr 
		iwork: iwork 
		info: infoPtr.
		
	"Check for convergence"
	self assert: info equals: 0.
	
	"Check the minimum norm solution"
	"self assert: b closeTo: self expectedMinimumNormSolution."
	
	"Check the rank of a matrix"
	self assert: rankPtr value equals: self expectedRank.
	
	"Check singular values"
	"self assert: s equals: self expectedSingularValues."
]

{ #category : #tests }
LapackTest >> testFindOptimalWorkspace [

	self
		assert: self findOptimalWorkspace
		equals: 936. 
]
