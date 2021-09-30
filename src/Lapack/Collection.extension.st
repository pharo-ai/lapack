Extension { #name : #Collection }

{ #category : #'*Lapack' }
Collection >> asFFIExternalArrayOfType: aType [
	"Converts collection to FFIExternalArray.
	
	Example:
	#(1 2 3) asFFIExternalArrayOfType: 'int'"
	
	| array |
	array := FFIExternalArray newType: aType size: self size.
	self withIndexDo: [ :each :index | array at: index put: each ].
	^ array
]
