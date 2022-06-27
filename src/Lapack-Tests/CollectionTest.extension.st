Extension { #name : #CollectionTest }

{ #category : #'*Lapack-Tests' }
CollectionTest >> testAsFFIExternalArrayOfType [

	| collection externalArray |
	
	collection := #(2.1 -2 0 0.3).
	externalArray := collection asFFIExternalArrayOfType: 'double'.
	
	self assert: externalArray class equals: FFIExternalArray.
	self assert: externalArray asArray equals: collection.
]
