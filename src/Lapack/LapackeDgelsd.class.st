Class {
	#name : #LapackeDgelsd,
	#superclass : #LapackDgelsd,
	#category : #Lapack
}

{ #category : #'as yet unclassified' }
LapackeDgelsd >> ffiDgelsdMatrixLayout: layout m: m n: n nrhs: nrhs a: a lda: lda b: b ldb: ldb s: s rcond: rcond rank: aRank [

	^ self ffiCall: #( int _LAPACKE_dgelsd(
		void* layout,
		void* m,
		void* n,
		void* nrhs,
    	void* a,
		void* lda,
    	void* b,
		void* ldb,
    	void* s,
    	void* rcond,
		void* aRank ) )
]

{ #category : #running }
LapackeDgelsd >> solve [

	| layoutPointer singularValuesArray numberOfRowsPointer numberOfColumnsPointer numberOfRightHandSidesPointer leadingDimensionAPointer leadingDimensionBPointer rankPointer reciprocalConditionNumberPointer |

	singularValuesArray := FFIExternalArray newType: 'double' size: numberOfRows.
	
	layoutPointer := LapackPointerCreator integerPointer: 101.
	numberOfRowsPointer := LapackPointerCreator integerPointer: numberOfRows.
	numberOfColumnsPointer := LapackPointerCreator integerPointer: numberOfColumns.
	numberOfRightHandSidesPointer := LapackPointerCreator integerPointer: numberOfRightHandSides.
	leadingDimensionAPointer := LapackPointerCreator integerPointer: self leadingDimensionA.
	leadingDimensionBPointer := LapackPointerCreator integerPointer: self leadingDimensionB.
	rankPointer := LapackPointerCreator integerPointer: 0.
	reciprocalConditionNumberPointer := LapackPointerCreator doublePointer: self reciprocalConditionNumber. 
	
	self
		ffiDgelsdMatrixLayout: layoutPointer
		m: numberOfRowsPointer 
		n: numberOfColumnsPointer 
		nrhs: numberOfRightHandSidesPointer
		a: matrixA 
		lda: leadingDimensionAPointer 
		b: matrixB 
		ldb: leadingDimensionBPointer 
		s: singularValuesArray
		rcond: reciprocalConditionNumberPointer 
		rank: rankPointer.

	minimumNormSolution := matrixB asArray.
	singularValues := singularValuesArray asArray.
	rank := rankPointer value.
]
