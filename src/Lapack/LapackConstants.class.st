Class {
	#name : #LapackConstants,
	#superclass : #SharedPool,
	#classVars : [
		'HBP_DEFAULT'
	],
	#category : #Lapack
}

{ #category : #initialization }
LapackConstants class >> initialize [

	HBP_DEFAULT := 0.
]
