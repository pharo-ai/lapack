Extension { #name : #Collection }

{ #category : #'*AI-Lapack' }
Collection >> asFFIExternalArrayOfType: aType [
	"Converts collection to FFIExternalArray.
	
	Example:
	#(1 2 3) asFFIExternalArrayOfType: 'int'"
	
	^ self asFFIExternalArrayOfType: aType size: self size
]

{ #category : #'*AI-Lapack' }
Collection >> asFFIExternalArrayOfType: aType size: aNumber [
	"Converts collection to FFIExternalArray.
	The size must be greater or equal to the size of self.
	This allows to allocate extra memory for an array.
	
	Example:
	#(1 2 3) asFFIExternalArrayOfType: 'int' size: 10"
	
	| array |
	array := FFIExternalArray newType: aType size: aNumber.
	self withIndexDo: [ :each :index | array at: index put: each ].
	^ array
]
