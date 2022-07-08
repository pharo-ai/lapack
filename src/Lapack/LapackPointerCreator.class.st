"
I am a class that facilitates the constructions of integer and double pointers. Those pointers are needed to be sent to lapack.
"
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
