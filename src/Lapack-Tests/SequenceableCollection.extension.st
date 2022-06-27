Extension { #name : #SequenceableCollection }

{ #category : #'*Lapack-Tests' }
SequenceableCollection >> closeTo: aCollection precision: aPrecision [

	self with: aCollection do: [ :each :other |
		(each closeTo: other precision: aPrecision)
			ifFalse: [ ^ false ] ].
		
	^ true
]
