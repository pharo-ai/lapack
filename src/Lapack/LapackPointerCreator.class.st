Class {
	#name : #LapackPointerCreator,
	#superclass : #Object,
	#classVars : [
		'DoublePointerClass',
		'IntegerPointerClass'
	],
	#category : #Lapack
}

{ #category : #factory }
LapackPointerCreator class >> doublePointer: aNumber [

	^ DoublePointerClass new value: aNumber
]

{ #category : #'class initialization' }
LapackPointerCreator class >> initialize [
	
	DoublePointerClass := FFIExternalValueHolder ofType: 'double'.
	IntegerPointerClass := FFIExternalValueHolder ofType: 'int'
]

{ #category : #factory }
LapackPointerCreator class >> integerPointer: aNumber [

	^ IntegerPointerClass new value: aNumber
]
