!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'AD 6/4/2018 21:17:10'!
test01ANewCartIsEmpty

	| cart  |
	
	cart _ Cart new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AD 6/4/2018 21:37:29'!
test02ABookIsAddedToACartCorrectly

	| cart  aBook |
	
	cart _ Cart new.
	
	aBook := '1234'.
	
	cart add: aBook.
	
	
	self deny: cart isEmpty.
	self assert: cart amountOfBooks equals: 1.
	self assert: (cart includes: aBook).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AD 6/4/2018 21:43:40'!
test03

	| cart  aBook |
	
	cart _ Cart new.
	
	aBook := '5678'.
	
	self should:  [cart  add: aBook] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart cantAddABookThatIsNotInCatalogErrorMessage.
		
			self assert: cart isEmpty.
		
		].
	
	
! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'cartItems catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'AD 6/4/2018 21:50:26'!
initialize

	cartItems _ OrderedCollection  new.
	catalog _ OrderedCollection with: '1234'! !


!Cart methodsFor: 'testing' stamp: 'AD 6/4/2018 21:37:06'!
includes: aBook

	^ cartItems includes: aBook .
	
	! !

!Cart methodsFor: 'testing' stamp: 'AD 6/4/2018 21:24:55'!
isEmpty
	
	^ cartItems size = 0.! !


!Cart methodsFor: 'adding' stamp: 'AD 6/4/2018 21:48:43'!
add: aBook

	(catalog includes: aBook) ifFalse:[self error: self class cantAddABookThatIsNotInCatalogErrorMessage].

	cartItems add: aBook.
	
	! !


!Cart methodsFor: 'amounts' stamp: 'AD 6/4/2018 21:33:33'!
amountOfBooks
	
	^ cartItems size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'AD 6/4/2018 21:51:31'!
cantAddABookThatIsNotInCatalogErrorMessage
	
	^ 'Can not add a book that doesnt belong to the editorial'! !
