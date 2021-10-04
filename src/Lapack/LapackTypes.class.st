Class {
	#name : #LapackTypes,
	#superclass : #SharedPool,
	#classVars : [
		'LapackDoublePointerClass',
		'LapackIntegerPointerClass'
	],
	#category : #Lapack
}

{ #category : #initialization }
LapackTypes class >> initialize [
	"self initialize"
	
	LapackIntegerPointerClass := FFIExternalValueHolder ofType: 'int'.
	LapackDoublePointerClass := FFIExternalValueHolder ofType: 'double'.
]
