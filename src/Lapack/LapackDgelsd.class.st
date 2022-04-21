"
Source: http://www.netlib.org/lapack/explore-html/d7/d3b/group__double_g_esolve_ga94bd4a63a6dacf523e25ff617719f752.html
	
DGELSD computes the minimum-norm solution to a real linear least squares problem:
	   minimize 2-norm(| b - A*x |)
using the singular value decomposition (SVD) of A. A is an M-by-N matrix which may be rank-deficient.

How to use me:
First, you have to initialize me and set some parameteres, like:

algorithm := LapackDgelsd new
	numberOfRows: fixture numberOfRows;
	numberOfColumns: fixture numberOfColumns;
	numberOfRightHandSides: fixture numberOfRightHandSides;
	matrixA: fixture matrixA;
	matrixB: fixture matrixB;
	yourself.
algorithm solve

And then, just call the method solve. To get the answer call my accessor methods.
For more info, take a look at my test class.

Parameters info:
	- M is INTEGER
          The number of rows of A. M >= 0.

	- N is INTEGER
          The number of columns of A. N >= 0.

	- NRHS is INTEGER
          The number of right hand sides, i.e., the number of columns
          of the matrices B and X. NRHS >= 0.

	- A is DOUBLE PRECISION array, dimension (LDA,N)
          On entry, the M-by-N matrix A.
          On exit, A has been destroyed.

	- LDA is INTEGER
          The leading dimension of the array A.  LDA >= max(1,M).

	- B is DOUBLE PRECISION array, dimension (LDB,NRHS)
          On entry, the M-by-NRHS right hand side matrix B.
          On exit, B is overwritten by the N-by-NRHS solution
          matrix X.  If m >= n and RANK = n, the residual
          sum-of-squares for the solution in the i-th column is given
          by the sum of squares of elements n+1:m in that column.

	- LDB is INTEGER
          The leading dimension of the array B. LDB >= max(1,max(M,N)).

	- S is DOUBLE PRECISION array, dimension (min(M,N))
          The singular values of A in decreasing order.
          The condition number of A in the 2-norm = S(1)/S(min(m,n)).

	- RCOND is DOUBLE PRECISION
          RCOND is used to determine the effective rank of A.
          Singular values S(i) <= RCOND*S(1) are treated as zero.
          If RCOND < 0, machine precision is used instead.

	- RANK is INTEGER
          The effective rank of A, i.e., the number of singular values
          which are greater than RCOND*S(1).

	- WORK is DOUBLE PRECISION array, dimension (MAX(1,LWORK))
          On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

	- LWORK is INTEGER
          The dimension of the array WORK. LWORK must be at least 1.
          The exact minimum amount of workspace needed depends on M,
          N and NRHS. As long as LWORK is at least
              12*N + 2*N*SMLSIZ + 8*N*NLVL + N*NRHS + (SMLSIZ+1)**2,
          if M is greater than or equal to N or
              12*M + 2*M*SMLSIZ + 8*M*NLVL + M*NRHS + (SMLSIZ+1)**2,
          if M is less than N, the code will execute correctly.
          SMLSIZ is returned by ILAENV and is equal to the maximum
          size of the subproblems at the bottom of the computation
          tree (usually about 25), and
             NLVL = MAX( 0, INT( LOG_2( MIN( M,N )/(SMLSIZ+1) ) ) + 1 )
          For good performance, LWORK should generally be larger.

          If LWORK = -1, then a workspace query is assumed; the routine
          only calculates the optimal size of the WORK array, returns
          this value as the first entry of the WORK array, and no error
          message related to LWORK is issued by XERBLA.

	- IWORK is INTEGER array, dimension (MAX(1,LIWORK))
          LIWORK >= max(1, 3 * MINMN * NLVL + 11 * MINMN),
          where MINMN = MIN( M,N ).
          On exit, if INFO = 0, IWORK(1) returns the minimum LIWORK.

	- INFO is INTEGER
          = 0:  successful exit
          < 0:  if INFO = -i, the i-th argument had an illegal value.
          > 0:  the algorithm for computing the SVD failed to converge;
                if INFO = i, i off-diagonal elements of an intermediate
                bidiagonal form did not converge to zero.
"
Class {
	#name : #LapackDgelsd,
	#superclass : #LapackAlgorithm,
	#instVars : [
		'matrixA',
		'matrixB',
		'numberOfRows',
		'numberOfColumns',
		'numberOfRightHandSides',
		'leadingDimensionA',
		'leadingDimensionB',
		'singularValues',
		'rank',
		'info',
		'reciprocalConditionNumber',
		'workArraySize',
		'minimumNormSolution',
		'iworkArray'
	],
	#category : #Lapack
}

{ #category : #ffi }
LapackDgelsd >> ffiDgelsdM: m n: n nrhs: nrhs a: a lda: lda b: b ldb: ldb s: s rcond: rcond rank: aRank work: work lwork: lwork iwork: iwork info: anInfo [
 
	"Source: http://www.netlib.org/lapack/explore-html/d7/d3b/group__double_g_esolve_ga94bd4a63a6dacf523e25ff617719f752.html
	
	DGELSD computes the minimum-norm solution to a real linear least squares problem:
	    minimize 2-norm(| b - A*x |)
   using the singular value decomposition (SVD) of A. A is an M-by-N matrix
   which may be rank-deficient.

	- M is INTEGER
          The number of rows of A. M >= 0.

	- N is INTEGER
          The number of columns of A. N >= 0.

	- NRHS is INTEGER
          The number of right hand sides, i.e., the number of columns
          of the matrices B and X. NRHS >= 0.

	- A is DOUBLE PRECISION array, dimension (LDA,N)
          On entry, the M-by-N matrix A.
          On exit, A has been destroyed.

	- LDA is INTEGER
          The leading dimension of the array A.  LDA >= max(1,M).

	- B is DOUBLE PRECISION array, dimension (LDB,NRHS)
          On entry, the M-by-NRHS right hand side matrix B.
          On exit, B is overwritten by the N-by-NRHS solution
          matrix X.  If m >= n and RANK = n, the residual
          sum-of-squares for the solution in the i-th column is given
          by the sum of squares of elements n+1:m in that column.

	- LDB is INTEGER
          The leading dimension of the array B. LDB >= max(1,max(M,N)).

	- S is DOUBLE PRECISION array, dimension (min(M,N))
          The singular values of A in decreasing order.
          The condition number of A in the 2-norm = S(1)/S(min(m,n)).

	- RCOND is DOUBLE PRECISION
          RCOND is used to determine the effective rank of A.
          Singular values S(i) <= RCOND*S(1) are treated as zero.
          If RCOND < 0, machine precision is used instead.

	- RANK is INTEGER
          The effective rank of A, i.e., the number of singular values
          which are greater than RCOND*S(1).

	- WORK is DOUBLE PRECISION array, dimension (MAX(1,LWORK))
          On exit, if INFO = 0, WORK(1) returns the optimal LWORK.

	- LWORK is INTEGER
          The dimension of the array WORK. LWORK must be at least 1.
          The exact minimum amount of workspace needed depends on M,
          N and NRHS. As long as LWORK is at least
              12*N + 2*N*SMLSIZ + 8*N*NLVL + N*NRHS + (SMLSIZ+1)**2,
          if M is greater than or equal to N or
              12*M + 2*M*SMLSIZ + 8*M*NLVL + M*NRHS + (SMLSIZ+1)**2,
          if M is less than N, the code will execute correctly.
          SMLSIZ is returned by ILAENV and is equal to the maximum
          size of the subproblems at the bottom of the computation
          tree (usually about 25), and
             NLVL = MAX( 0, INT( LOG_2( MIN( M,N )/(SMLSIZ+1) ) ) + 1 )
          For good performance, LWORK should generally be larger.

          If LWORK = -1, then a workspace query is assumed; the routine
          only calculates the optimal size of the WORK array, returns
          this value as the first entry of the WORK array, and no error
          message related to LWORK is issued by XERBLA.

	- IWORK is INTEGER array, dimension (MAX(1,LIWORK))
          LIWORK >= max(1, 3 * MINMN * NLVL + 11 * MINMN),
          where MINMN = MIN( M,N ).
          On exit, if INFO = 0, IWORK(1) returns the minimum LIWORK.

	- INFO is INTEGER
          = 0:  successful exit
          < 0:  if INFO = -i, the i-th argument had an illegal value.
          > 0:  the algorithm for computing the SVD failed to converge;
                if INFO = i, i off-diagonal elements of an intermediate
                bidiagonal form did not converge to zero."

	^ self ffiCall: #( void dgelsd_(
		void* m,
		void* n,
		void* nrhs,
    	void* a,
		void* lda,
    	void* b,
		void* ldb,
    	void* s,
    	void* rcond,
		void* aRank,
    	void* work,
		void* lwork,
    	void* iwork,
    	void* anInfo ) )
]

{ #category : #ffi }
LapackDgelsd >> findOptimalWorkspace: m n: n nrhs: nrhs a: a lda: lda b: b ldb: ldb s: s rcond: rcond rank: aRank work: work iwork: iwork info: anInfo [

	| lworkPtr workPtr |
	lworkPtr := LapackPointerCreator integerPointer:  -1.
	workPtr := LapackPointerCreator doublePointer:  0.

	self ffiDgelsdM: m n: n nrhs: nrhs a: a lda: lda b: b ldb: ldb s: s rcond: rcond rank: aRank work: workPtr lwork: lworkPtr iwork: iwork info: anInfo.
	
	^ workPtr value asInteger
]

{ #category : #accessing }
LapackDgelsd >> info [

	^ info
]

{ #category : #accessing }
LapackDgelsd >> leadingDimensionA [

	^ leadingDimensionA ifNil: [ self numberOfRows ]
]

{ #category : #accessing }
LapackDgelsd >> leadingDimensionA: aNumber [

	leadingDimensionA := aNumber 
]

{ #category : #accessing }
LapackDgelsd >> leadingDimensionB [

	^ leadingDimensionB ifNil: [ self numberOfRows max: self numberOfColumns ]
]

{ #category : #accessing }
LapackDgelsd >> leadingDimensionB: aNumber [

	leadingDimensionB := aNumber 
]

{ #category : #accessing }
LapackDgelsd >> matrixA: anArray [

	matrixA := anArray asFFIExternalArrayOfType: 'double'
]

{ #category : #accessing }
LapackDgelsd >> matrixB: anArray [

	matrixB := anArray
		asFFIExternalArrayOfType: 'double'
		size: (anArray size max: (numberOfRightHandSides * numberOfColumns))
]

{ #category : #accessing }
LapackDgelsd >> minimumNormSolution [
	
	^ minimumNormSolution
]

{ #category : #accessing }
LapackDgelsd >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
LapackDgelsd >> numberOfColumns: aNumber [

	numberOfColumns := aNumber
]

{ #category : #accessing }
LapackDgelsd >> numberOfRightHandSides [

	^ numberOfRightHandSides
]

{ #category : #accessing }
LapackDgelsd >> numberOfRightHandSides: aNumber [

	numberOfRightHandSides := aNumber
]

{ #category : #accessing }
LapackDgelsd >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
LapackDgelsd >> numberOfRows: aNumber [

	numberOfRows := aNumber
]

{ #category : #accessing }
LapackDgelsd >> optimalWorkArraySize [

	^ workArraySize
]

{ #category : #accessing }
LapackDgelsd >> rank [
	
	^ rank
]

{ #category : #accessing }
LapackDgelsd >> reciprocalConditionNumber [

	"Negative rcond means using default (machine precision) value"
	^ reciprocalConditionNumber ifNil: [ -1.0 ]
]

{ #category : #accessing }
LapackDgelsd >> reciprocalConditionNumber: aNumber [

	reciprocalConditionNumber := aNumber
]

{ #category : #accessing }
LapackDgelsd >> singularValues [
	
	^ singularValues
]

{ #category : #running }
LapackDgelsd >> solve [

	| singularValuesArray numberOfRowsPointer numberOfColumnsPointer numberOfRightHandSidesPointer leadingDimensionAPointer leadingDimensionBPointer rankPointer infoPointer reciprocalConditionNumberPointer workArray workArraySizePointer |

	singularValuesArray := FFIExternalArray newType: 'double' size: numberOfRows.
	
	"iwork dimension should be at least 3*min(m,n)*nlvl + 11*min(m,n),
   where nlvl = max( 0, int( log_2( min(m,n)/(smlsiz+1) ) )+1 )
   and smlsiz = 25"
	iworkArray := FFIExternalArray newType: 'int' size: 11 * numberOfRows.
	
	numberOfRowsPointer := LapackPointerCreator integerPointer: numberOfRows.
	numberOfColumnsPointer := LapackPointerCreator integerPointer: numberOfColumns.
	numberOfRightHandSidesPointer := LapackPointerCreator integerPointer: numberOfRightHandSides.
	leadingDimensionAPointer := LapackPointerCreator integerPointer: self leadingDimensionA.
	leadingDimensionBPointer := LapackPointerCreator integerPointer: self leadingDimensionB.
	rankPointer := LapackPointerCreator integerPointer: 0.
	infoPointer := LapackPointerCreator integerPointer: 0.
	reciprocalConditionNumberPointer := LapackPointerCreator doublePointer: self reciprocalConditionNumber. 
	
	workArraySize := self
		findOptimalWorkspace: numberOfRowsPointer 
		n: numberOfColumnsPointer 
		nrhs: numberOfRightHandSidesPointer
		a: matrixA 
		lda: leadingDimensionAPointer 
		b: matrixB 
		ldb: leadingDimensionBPointer 
		s: singularValuesArray
		rcond: reciprocalConditionNumberPointer 
		rank: rankPointer 
		work: nil  
		iwork: iworkArray 
		info: infoPointer.
		
	workArray := FFIExternalArray newType: 'double' size: workArraySize.
	workArraySizePointer := LapackPointerCreator integerPointer: workArraySize.
	
	self
		ffiDgelsdM: numberOfRowsPointer 
		n: numberOfColumnsPointer 
		nrhs: numberOfRightHandSidesPointer
		a: matrixA 
		lda: leadingDimensionAPointer 
		b: matrixB 
		ldb: leadingDimensionBPointer 
		s: singularValuesArray
		rcond: reciprocalConditionNumberPointer 
		rank: rankPointer
		work: workArray 
		lwork: workArraySizePointer 
		iwork: iworkArray 
		info: infoPointer.

	minimumNormSolution := matrixB asArray.
	singularValues := singularValuesArray asArray.
	rank := rankPointer value.
	info := infoPointer value.
]
