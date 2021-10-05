Class {
	#name : #LapackPointerCreator,
	#superclass : #Object,
	#classVars : [
		'DoublePointerClass',
		'IntegerPointerClass'
	],
	#category : #Lapack
}

{ #category : #'as yet unclassified' }
LapackPointerCreator class >> doublePointer: aNumber [

	^ DoublePointerClass new value: aNumber
]

{ #category : #initialization }
LapackPointerCreator class >> initialize [
	
	DoublePointerClass := FFIExternalValueHolder ofType: 'double'.
	IntegerPointerClass := FFIExternalValueHolder ofType: 'int'.
]

{ #category : #'as yet unclassified' }
LapackPointerCreator class >> integerPointer: aNumber [

	^ IntegerPointerClass new value: aNumber
]
