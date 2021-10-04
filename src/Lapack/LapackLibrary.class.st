Class {
	#name : #LapackLibrary,
	#superclass : #FFILibrary,
	#category : #Lapack
}

{ #category : #'accessing - platform' }
LapackLibrary >> macLibraryName [
	
	"^ FFIMacLibraryFinder new 
		userPaths: { '/usr/local/opt/lapack/lib/' };
		findAnyLibrary: #('liblapack.dylib')."
	
	^ '/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libLAPACK.dylib'
]
