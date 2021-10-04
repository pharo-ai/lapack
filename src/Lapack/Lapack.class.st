Class {
	#name : #Lapack,
	#superclass : #Object,
	#pools : [
		'LapackConstants',
		'LapackTypes'
	],
	#category : #Lapack
}

{ #category : #accessing }
Lapack class >> ffiLibrary [

	^ LapackLibrary
]

{ #category : #ffi }
Lapack >> allocateOptimalWorkspaceOfSize: n [

	^ FFIExternalArray newType: 'double' size: n 
]

{ #category : #ffi }
Lapack >> ffiDgelsdM: m n: n nrhs: nrhs a: a lda: lda b: b ldb: ldb s: s rcond: rcond rank: rank work: work lwork: lwork iwork: iwork info: info [
 
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

	^ self ffiCall: #(void dgelsd_(
    	void* m, void* n, void* nrhs,
    	void* a, void* lda,
    	void* b, void* ldb,
    	void* s,
    	void* rcond, void* rank,
    	void* work, void* lwork,
    	void* iwork,
    	void* info)).
]

{ #category : #ffi }
Lapack >> ffiLibrary [ 

	^ LapackLibrary
]

{ #category : #ffi }
Lapack >> findOptimalWorkspace: m n: n nrhs: nrhs a: a lda: lda b: b ldb: ldb s: s rcond: rcond rank: rank work: work iwork: iwork info: info [

	| lworkPtr workPtr |
	lworkPtr := (FFIExternalValueHolder ofType: 'int') new value: -1.
	workPtr := (FFIExternalValueHolder ofType: 'double') new value: -1.0.
	info value: 10.

	self ffiDgelsdM: m n: n nrhs: nrhs a: a lda: lda b: b ldb: ldb s: s rcond: rcond rank: rank work: workPtr lwork: lworkPtr iwork: iwork info: info.
	
	^ workPtr value asInteger.
	
	" /* Locals */
        int m = M, n = N, nrhs = NRHS, lda = LDA, ldb = LDB, info, lwork, rank;
        /* Negative rcond means using default (machine precision) value */
        double rcond = -1.0;
        double wkopt;
        double* work;
        /* Local arrays */
        /* iwork dimension should be at least 3*min(m,n)*nlvl + 11*min(m,n),
                where nlvl = max( 0, int( log_2( min(m,n)/(smlsiz+1) ) )+1 )
                and smlsiz = 25 */
        int iwork[3*M*0+11*M];
        double s[M];
        double a[LDA*N] = {
            0.12, -6.91, -3.33,  3.97,
           -8.19,  2.22, -8.94,  3.33,
            7.69, -5.12, -6.72, -2.74,
           -2.26, -9.08, -4.40, -7.92,
           -4.71,  9.96, -9.98, -3.20
        };
        double b[LDB*NRHS] = {
            7.30,  1.33,  2.68, -9.62,  0.00,
            0.47,  6.58, -1.71, -0.79,  0.00,
           -6.28, -3.42,  3.46,  0.41,  0.00
        };
        /* Executable statements */
        printf( "" DGELSD Example Program Results\n"" );
        /* Query and allocate the optimal workspace */
        lwork = -1;
        dgelsd( &m, &n, &nrhs, a, &lda, b, &ldb, s, &rcond, &rank, &wkopt, &lwork,
                        iwork, &info );
        lwork = (int)wkopt;
        work = (double*)malloc( lwork*sizeof(double) );"
]
