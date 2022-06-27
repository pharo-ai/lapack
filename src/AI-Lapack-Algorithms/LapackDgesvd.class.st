"
**Source:** [http://www.netlib.org/lapack/explore-html/d1/d7e/group__double_g_esing_ga84fdf22a62b12ff364621e4713ce02f2.html](http://www.netlib.org/lapack/explore-html/d1/d7e/group__double_g_esing_ga84fdf22a62b12ff364621e4713ce02f2.html)

DGESVD computes the singular value decomposition (SVD) of a real
 M-by-N matrix A, optionally computing the left and/or right singular
 vectors. The SVD is written

$A = U\Sigma V^\top$

 where SIGMA is an M-by-N matrix which is zero except for its
 min(m,n) diagonal elements, U is an M-by-M orthogonal matrix, and
 V is an N-by-N orthogonal matrix.  The diagonal elements of SIGMA
 are the singular values of A; they are real and non-negative, and
 are returned in descending order.  The first min(m,n) columns of
 U and V are the left and right singular vectors of A.

 Note that the routine returns $V^\top$, not $V$.

### Parameters info:

* **JOBU** is CHARACTER*1
          Specifies options for computing all or part of the matrix U:
          = 'A':  all M columns of U are returned in array U:
          = 'S':  the first min(m,n) columns of U (the left singular
                  vectors) are returned in the array U;
          = 'O':  the first min(m,n) columns of U (the left singular
                  vectors) are overwritten on the array A;
          = 'N':  no columns of U (no left singular vectors) are
                  computed.

* **JOBVT** is CHARACTER*1
          Specifies options for computing all or part of the matrix $V^\top$:
          = 'A':  all N rows of $V^\top$ are returned in the array VT;
          = 'S':  the first min(m,n) rows of $V^\top$ (the right singular
                  vectors) are returned in the array VT;
          = 'O':  the first min(m,n) rows of $V^\top$ (the right singular
                  vectors) are overwritten on the array A;
          = 'N':  no rows of $V^\top$ (no right singular vectors) are
                  computed.
          JOBVT and JOBU cannot both be 'O'.

* **M** is INTEGER
          The number of rows of the input matrix A.  M >= 0.

* **N** is INTEGER
          The number of columns of the input matrix A.  N >= 0.

* **A** is DOUBLE PRECISION array, dimension (LDA,N)
          On entry, the M-by-N matrix A.
          On exit,
          if JOBU = 'O',  A is overwritten with the first min(m,n)
                          columns of U (the left singular vectors,
                          stored columnwise);
          if JOBVT = 'O', A is overwritten with the first min(m,n)
                          rows of $V^\top$ (the right singular vectors,
                          stored rowwise);
          if JOBU .ne. 'O' and JOBVT .ne. 'O', the contents of A
                          are destroyed.

* **LDA** is INTEGER
          The leading dimension of the array A.  LDA >= max(1,M).

* **S** is DOUBLE PRECISION array, dimension (min(M,N))
          The singular values of A, sorted so that S(i) >= S(i+1).

* **U** is DOUBLE PRECISION array, dimension (LDU,UCOL)
          (LDU,M) if JOBU = 'A' or (LDU,min(M,N)) if JOBU = 'S'.
          If JOBU = 'A', U contains the M-by-M orthogonal matrix U;
          if JOBU = 'S', U contains the first min(m,n) columns of U
          (the left singular vectors, stored columnwise);
          if JOBU = 'N' or 'O', U is not referenced.

* **LDU** is INTEGER
          The leading dimension of the array U.  LDU >= 1; if
          JOBU = 'S' or 'A', LDU >= M.

* **VT** is DOUBLE PRECISION array, dimension (LDVT,N)
          If JOBVT = 'A', VT contains the N-by-N orthogonal matrix $V^\top$;
          if JOBVT = 'S', VT contains the first min(m,n) rows of
          $V^\top$ (the right singular vectors, stored rowwise);
          if JOBVT = 'N' or 'O', VT is not referenced.

* **LDVT** is INTEGER
          The leading dimension of the array VT.  LDVT >= 1; if
          JOBVT = 'A', LDVT >= N; if JOBVT = 'S', LDVT >= min(M,N).

* **WORK** is DOUBLE PRECISION array, dimension (MAX(1,LWORK))
          On exit, if INFO = 0, WORK(1) returns the optimal LWORK;
          if INFO > 0, WORK(2:MIN(M,N)) contains the unconverged
          superdiagonal elements of an upper bidiagonal matrix B
          whose diagonal is in S (not necessarily sorted). B
          satisfies A = U * B * VT, so it has the same singular values
          as A, and singular vectors related by U and VT.

* **LWORK** is INTEGER
          The dimension of the array WORK.
          LWORK >= MAX(1,5*MIN(M,N)) for the paths (see comments inside code):
             - PATH 1  (M much larger than N, JOBU='N')
             - PATH 1t (N much larger than M, JOBVT='N')
          LWORK >= MAX(1,3*MIN(M,N) + MAX(M,N),5*MIN(M,N)) for the other paths
          For good performance, LWORK should generally be larger.
          If LWORK = -1, then a workspace query is assumed; the routine
          only calculates the optimal size of the WORK array, returns
          this value as the first entry of the WORK array, and no error
          message related to LWORK is issued by XERBLA.

* **INFO** is INTEGER
          = 0:  successful exit.
          < 0:  if INFO = -i, the i-th argument had an illegal value.
          > 0:  if DBDSQR did not converge, INFO specifies how many
                superdiagonals of an intermediate bidiagonal form B
                did not converge to zero. See the description of WORK
                above for details.
"
Class {
	#name : #LapackDgesvd,
	#superclass : #LapackAlgorithm,
	#instVars : [
		'jobU',
		'jobVTransposed',
		'numberOfRows',
		'numberOfColumns',
		'matrixA',
		'leadingDimensionA',
		'singularValues',
		'matrixU',
		'leadingDimensionU',
		'matrixVTransposed',
		'leadingDimensionVTransposed',
		'workArraySize',
		'info'
	],
	#category : #'AI-Lapack-Algorithms'
}

{ #category : #'as yet unclassified' }
LapackDgesvd >> ffiDgesvdJobU: aJobU jobVt: aJobVt m: m n: n a: a lda: lda s: s u: u ldu: ldu vt: vt ldvt: ldvt work: work lwork: lwork info: anInfo [

"Source: http://www.netlib.org/lapack/explore-html/d1/d7e/group__double_g_esing_ga84fdf22a62b12ff364621e4713ce02f2.html

DGESVD computes the singular value decomposition (SVD) of a real
 M-by-N matrix A, optionally computing the left and/or right singular
 vectors. The SVD is written

A = U * Sigma * transpose(V)$

 where SIGMA is an M-by-N matrix which is zero except for its
 min(m,n) diagonal elements, U is an M-by-M orthogonal matrix, and
 V is an N-by-N orthogonal matrix.  The diagonal elements of SIGMA
 are the singular values of A; they are real and non-negative, and
 are returned in descending order.  The first min(m,n) columns of
 U and V are the left and right singular vectors of A.

 Note that the routine returns transpose(V), not V.

### Parameters info:

- JOBU is CHARACTER*1
          Specifies options for computing all or part of the matrix U:
          = 'A':  all M columns of U are returned in array U:
          = 'S':  the first min(m,n) columns of U (the left singular
                  vectors) are returned in the array U;
          = 'O':  the first min(m,n) columns of U (the left singular
                  vectors) are overwritten on the array A;
          = 'N':  no columns of U (no left singular vectors) are
                  computed.

- JOBVT is CHARACTER*1
          Specifies options for computing all or part of the matrix transpose(V):
          = 'A':  all N rows of transpose(V) are returned in the array VT;
          = 'S':  the first min(m,n) rows of transpose(V) (the right singular
                  vectors) are returned in the array VT;
          = 'O':  the first min(m,n) rows of transpose(V) (the right singular
                  vectors) are overwritten on the array A;
          = 'N':  no rows of transpose(V) (no right singular vectors) are
                  computed.
          JOBVT and JOBU cannot both be 'O'.

- M is INTEGER
          The number of rows of the input matrix A.  M >= 0.

- N is INTEGER
          The number of columns of the input matrix A.  N >= 0.

- A is DOUBLE PRECISION array, dimension (LDA,N)
          On entry, the M-by-N matrix A.
          On exit,
          if JOBU = 'O',  A is overwritten with the first min(m,n)
                          columns of U (the left singular vectors,
                          stored columnwise);
          if JOBVT = 'O', A is overwritten with the first min(m,n)
                          rows of transpose(V) (the right singular vectors,
                          stored rowwise);
          if JOBU .ne. 'O' and JOBVT .ne. 'O', the contents of A
                          are destroyed.

- LDA is INTEGER
          The leading dimension of the array A.  LDA >= max(1,M).

- S is DOUBLE PRECISION array, dimension (min(M,N))
          The singular values of A, sorted so that S(i) >= S(i+1).

- U is DOUBLE PRECISION array, dimension (LDU,UCOL)
          (LDU,M) if JOBU = 'A' or (LDU,min(M,N)) if JOBU = 'S'.
          If JOBU = 'A', U contains the M-by-M orthogonal matrix U;
          if JOBU = 'S', U contains the first min(m,n) columns of U
          (the left singular vectors, stored columnwise);
          if JOBU = 'N' or 'O', U is not referenced.

- LDU is INTEGER
          The leading dimension of the array U.  LDU >= 1; if
          JOBU = 'S' or 'A', LDU >= M.

- VT is DOUBLE PRECISION array, dimension (LDVT,N)
          If JOBVT = 'A', VT contains the N-by-N orthogonal matrix transpose(V);
          if JOBVT = 'S', VT contains the first min(m,n) rows of
          $V^\top$ (the right singular vectors, stored rowwise);
          if JOBVT = 'N' or 'O', VT is not referenced.

- LDVT is INTEGER
          The leading dimension of the array VT.  LDVT >= 1; if
          JOBVT = 'A', LDVT >= N; if JOBVT = 'S', LDVT >= min(M,N).

- WORK is DOUBLE PRECISION array, dimension (MAX(1,LWORK))
          On exit, if INFO = 0, WORK(1) returns the optimal LWORK;
          if INFO > 0, WORK(2:MIN(M,N)) contains the unconverged
          superdiagonal elements of an upper bidiagonal matrix B
          whose diagonal is in S (not necessarily sorted). B
          satisfies A = U * B * VT, so it has the same singular values
          as A, and singular vectors related by U and VT.

- LWORK is INTEGER
          The dimension of the array WORK.
          LWORK >= MAX(1,5*MIN(M,N)) for the paths (see comments inside code):
             - PATH 1  (M much larger than N, JOBU='N')
             - PATH 1t (N much larger than M, JOBVT='N')
          LWORK >= MAX(1,3*MIN(M,N) + MAX(M,N),5*MIN(M,N)) for the other paths
          For good performance, LWORK should generally be larger.
          If LWORK = -1, then a workspace query is assumed; the routine
          only calculates the optimal size of the WORK array, returns
          this value as the first entry of the WORK array, and no error
          message related to LWORK is issued by XERBLA.

- INFO is INTEGER
          = 0:  successful exit.
          < 0:  if INFO = -i, the i-th argument had an illegal value.
          > 0:  if DBDSQR did not converge, INFO specifies how many
                superdiagonals of an intermediate bidiagonal form B
                did not converge to zero. See the description of WORK
                above for details."

	^ self ffiCall: #( void dgesvd_(
		void* aJobU,
		void* aJobVt,
		void* m,
    	void* n,
		void* a,
    	void* lda,
		void* s,
    	void* u,
    	void* ldu,
		void* vt,
    	void* ldvt,
		void* work,
    	void* lwork,
    	void* anInfo ) )
]

{ #category : #'as yet unclassified' }
LapackDgesvd >> findOptimalWorkspace: m n: n a: a lda: lda s: s u: u ldu: ldu vt: vt ldvt: ldvt info: anInfo [

	| lworkPtr workPtr |
	lworkPtr := LapackPointerCreator integerPointer:  -1.
	workPtr := LapackPointerCreator doublePointer:  0.

	self ffiDgesvdJobU: 'All' jobVt: 'All' m: m n: n a: a lda: lda s: s u: u ldu: ldu vt: vt ldvt: ldvt work: workPtr lwork: lworkPtr info: anInfo.
	
	^ workPtr value asInteger
]

{ #category : #accessing }
LapackDgesvd >> info [

	^ info
]

{ #category : #initialization }
LapackDgesvd >> initialize [
	super initialize.
	
	jobU := 'All'.
	jobVTransposed := 'All'.
]

{ #category : #accessing }
LapackDgesvd >> leadingDimensionA [

	^ leadingDimensionA ifNil: [ 1 max: self numberOfRows ]
]

{ #category : #accessing }
LapackDgesvd >> leadingDimensionA: aNumber [

	leadingDimensionA := aNumber
]

{ #category : #accessing }
LapackDgesvd >> leadingDimensionU [

	^ leadingDimensionU ifNil: [ 1 max: self numberOfRows ]
]

{ #category : #accessing }
LapackDgesvd >> leadingDimensionU: aNumber [

	leadingDimensionU := aNumber
]

{ #category : #accessing }
LapackDgesvd >> leadingDimensionVTransposed [

	^ leadingDimensionVTransposed ifNil: [ 1 max: self numberOfColumns ]
]

{ #category : #accessing }
LapackDgesvd >> leadingDimensionVTransposed: aNumber [

	leadingDimensionVTransposed := aNumber
]

{ #category : #accessing }
LapackDgesvd >> matrixA: anArray [

	matrixA := anArray asFFIExternalArrayOfType: 'double'
]

{ #category : #accessing }
LapackDgesvd >> matrixU [

	^ matrixU
]

{ #category : #accessing }
LapackDgesvd >> matrixVTransposed [

	^ matrixVTransposed
]

{ #category : #accessing }
LapackDgesvd >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
LapackDgesvd >> numberOfColumns: aNumber [

	numberOfColumns := aNumber
]

{ #category : #accessing }
LapackDgesvd >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
LapackDgesvd >> numberOfRows: aNumber [

	numberOfRows := aNumber
]

{ #category : #accessing }
LapackDgesvd >> singularValues [

	^ singularValues 
]

{ #category : #running }
LapackDgesvd >> solve [

	| singularValuesArray numberOfRowsPointer numberOfColumnsPointer leadingDimensionAPointer leadingDimensionUPointer leadingDimensionVTransposedPointer infoPointer workArray workArraySizePointer |

	singularValuesArray := FFIExternalArray newType: 'double' size: numberOfRows.
	matrixU := FFIExternalArray newType: 'double' size: self leadingDimensionU * numberOfRows.
	matrixVTransposed := FFIExternalArray newType: 'double' size: self leadingDimensionVTransposed * numberOfColumns.
	
	numberOfRowsPointer := LapackPointerCreator integerPointer: numberOfRows.
	numberOfColumnsPointer := LapackPointerCreator integerPointer: numberOfColumns.
	leadingDimensionAPointer := LapackPointerCreator integerPointer: self leadingDimensionA.
	leadingDimensionUPointer := LapackPointerCreator integerPointer: self leadingDimensionU.
	leadingDimensionVTransposedPointer := LapackPointerCreator integerPointer: self leadingDimensionVTransposed.
	infoPointer := LapackPointerCreator integerPointer: 0.
	
	workArraySize := self
		findOptimalWorkspace: numberOfRowsPointer
		n: numberOfColumnsPointer
		a: matrixA
		lda: leadingDimensionAPointer
		s: singularValuesArray
		u: matrixU
		ldu: leadingDimensionUPointer
		vt: matrixVTransposed
		ldvt: leadingDimensionVTransposedPointer
		info: infoPointer.
		
	workArray := FFIExternalArray newType: 'double' size: workArraySize.
	workArraySizePointer := LapackPointerCreator integerPointer: workArraySize.
	
	self
		ffiDgesvdJobU: jobU
		jobVt: jobVTransposed
		m: numberOfRowsPointer
		n: numberOfColumnsPointer
		a: matrixA
		lda: leadingDimensionAPointer
		s: singularValuesArray
		u: matrixU
		ldu: leadingDimensionUPointer 
		vt: matrixVTransposed
		ldvt: leadingDimensionVTransposedPointer 
		work: workArray
		lwork: workArraySizePointer
		info: infoPointer.

	matrixU := matrixU asArray.
	matrixVTransposed := matrixVTransposed asArray.
	singularValues := singularValuesArray asArray.
	info := infoPointer value.
]
