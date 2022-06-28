Extension { #name : #AIPharoFloatContiguousColumnMajorMatrix }

{ #category : #'*Lapack-Algorithms' }
AIPharoFloatContiguousColumnMajorMatrix >> contentsForLapack [

	"Take the pharo float array and transform it to a native float array"
	^ contents asFFIExternalArrayOfType: 'double'
]
