Class {
	#name : #LapackTypes,
	#superclass : #SharedPool,
	#classVars : [
		'lapack_int'
	],
	#category : #Lapack
}

{ #category : #initialization }
LapackTypes class >> initialize [
	"self initialize"
	
	lapack_int := #int.
]
