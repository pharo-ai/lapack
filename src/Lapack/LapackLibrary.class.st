"
I am a class for that provides the Lapack library user path.
"
Class {
	#name : #LapackLibrary,
	#superclass : #FFILibrary,
	#category : #Lapack
}

{ #category : #'accessing - platform' }
LapackLibrary >> macLibraryName [
	
	^ FFIMacLibraryFinder new 
		userPaths: { '/usr/local/opt/lapack/lib/'. '/opt/homebrew/opt/lapack/lib/' };
		findAnyLibrary: #('liblapack.dylib').
]

{ #category : #'accessing - platform' }
LapackLibrary >> unix32LibraryName [

	^ FFIUnix32LibraryFinder findLibrary: 'liblapack.so.3'
]

{ #category : #'accessing - platform' }
LapackLibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder findLibrary: 'liblapack.so.3'
]

{ #category : #'accessing - platform' }
LapackLibrary >> win32LibraryName [

	^ FFIWindowsLibraryFinder new
		userPaths: { '/usr/local/opt/lapack/lib/' };
		findAnyLibrary: #( 'liblapack.dylib' )
]
