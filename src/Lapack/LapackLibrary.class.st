Class {
	#name : #LapackLibrary,
	#superclass : #FFILibrary,
	#category : #Lapack
}

{ #category : #'accessing - platform' }
LapackLibrary >> macLibraryName [
	
	^ FFIMacLibraryFinder new 
		userPaths: { '/usr/local/opt/lapack/lib/' };
		findAnyLibrary: #('liblapacke.dylib').
]
