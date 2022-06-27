Class {
	#name : #LapackeLibrary,
	#superclass : #FFILibrary,
	#category : #'AI-Lapack'
}

{ #category : #'accessing - platform' }
LapackeLibrary >> macLibraryName [
	
	^ FFIMacLibraryFinder new 
		userPaths: { '/usr/local/opt/lapack/lib/' };
		findAnyLibrary: #('liblapacke.dylib').
]

{ #category : #'accessing - platform' }
LapackeLibrary >> win32LibraryName [

	^ FFIWindowsLibraryFinder new
		userPaths: { '/usr/local/opt/lapack/lib/' };
		findAnyLibrary: #( 'liblapacke.dylib' )
]
