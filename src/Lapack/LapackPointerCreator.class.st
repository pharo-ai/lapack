Class {
	#name : #LapackPointerCreator,
	#superclass : #Object,
	#category : #Lapack
}

{ #category : #'as yet unclassified' }
LapackPointerCreator class >> doublePointer: aNumber [

	^ (FFIExternalValueHolder ofType: 'double') new value: aNumber
]

{ #category : #'as yet unclassified' }
LapackPointerCreator class >> integerPointer: aNumber [

	^ (FFIExternalValueHolder ofType: 'int') new value: aNumber
]
