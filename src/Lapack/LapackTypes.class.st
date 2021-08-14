Class {
	#name : #LapackTypes,
	#superclass : #SharedPool,
	#classVars : [
		'hid_t'
	],
	#category : #Lapack
}

{ #category : #initialization }
LapackTypes class >> initialize [
	
	hid_t := #int64.
]
