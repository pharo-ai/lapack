"
I am a superclass for the lapack routines, or algorithms, that will be ported to Pharo.
"
Class {
	#name : #LapackAlgorithm,
	#superclass : #Object,
	#category : #Lapack
}

{ #category : #accessing }
LapackAlgorithm >> ffiLibrary [ 

	^ LapackLibrary
]
