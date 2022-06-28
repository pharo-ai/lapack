Extension { #name : #AIRowMajorMatrix }

{ #category : #'*Lapack-Algorithms' }
AIRowMajorMatrix >> contentsForLapack [
	
	^ self transposed flattened asFFIExternalArrayOfType: 'double'
]
