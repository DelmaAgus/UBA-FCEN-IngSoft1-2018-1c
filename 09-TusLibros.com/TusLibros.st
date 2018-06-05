!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'AD 6/4/2018 21:17:10'!
test01ANewCartIsEmpty

	| cart  |
	
	cart _ Cart new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/5/2018 11:43:42'!
test02ABookIsAddedToACartCorrectly
	| cart aBook |
	cart _ Cart new.
	aBook _ 'Un libro que está en el catálogo'.
	cart add: aBook.
	
	self deny: cart isEmpty.
	self assert: cart amountOfBookRequests equals: 1.
	self assert: (cart includes: aBook).! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/5/2018 10:21:29'!
test03CantAddABookThatIsNotInCatalog

	| cart  aBook |
	
	cart _ Cart new.
	
	aBook := 'Un libro que no está en el catálogo'.
	
	self should:  [cart  add: aBook] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart cantAddABookThatIsNotInCatalogErrorMessage.
			self assert: cart isEmpty.
		].
	
	
! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/5/2018 11:44:09'!
test04AnAmountOfBooksIsAddedToACartCorrectly
	| cart aBook |
	cart _ Cart new.
	aBook _ 'Un libro que está en el catálogo'.
	cart add: 5 of: aBook.
	
	self deny: cart isEmpty.
	self assert: cart amountOfBookRequests equals: 1.
	self assert: (cart amountOf: aBook) equals: 5.
	self assert: (cart includes: aBook).! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/5/2018 10:03:57'!
test05CantAddLessThanOneBookToACart

	| cart  aBook |
	
	cart _ Cart new.
	
	aBook := 'Un libro que está en el catálogo'.
	
	self should: [cart add: 0 of: aBook]
	 raise: Error - MessageNotUnderstood 
	 withExceptionDo: [:anError|
		self assert: anError messageText equals: Cart cantAddLessThanOneBookErrorMessage.
		self assert: cart isEmpty.
		].
	
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/5/2018 11:43:16'!
test06CanListAllTheRequestedBooksCorrectly

	| cart  aBook anotherBook requestedBooks|
	
	cart _ Cart new.
	
	aBook := 'Un libro que está en el catálogo'.
	anotherBook := 'Otro libro que está en el catálogo'.
	
	cart add: 5 of: aBook.
	cart add: 3 of: anotherBook.
	
	requestedBooks _ cart requestedBooks.
	
	self assert: requestedBooks size equals: 2.
	self assert: (requestedBooks includesKey: aBook).
	self assert: (requestedBooks at: aBook) equals: 5.
	self assert: (requestedBooks includesKey: anotherBook).
	self assert: (requestedBooks at: anotherBook) equals: 3.
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog bookRequests'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'AD 6/5/2018 11:49:53'!
initialize

	bookRequests _ Dictionary new.
	catalog _ OrderedCollection with: 'Un libro que está en el catálogo' with: 'Otro libro que está en el catálogo'.! !


!Cart methodsFor: 'testing' stamp: 'AD 6/5/2018 11:45:34'!
includes: aBook

	^ bookRequests includesKey: aBook.! !

!Cart methodsFor: 'testing' stamp: 'AD 6/5/2018 11:45:49'!
isEmpty

	^ bookRequests size = 0.! !


!Cart methodsFor: 'adding' stamp: 'AD 6/5/2018 11:49:10'!
add: aBook

	self add: 1 of: aBook.! !

!Cart methodsFor: 'adding' stamp: 'AD 6/5/2018 11:56:21'!
add: anAmountOfBooks of: aBook

	self assertIsInCatalog: aBook.
	self assertAddingPositive: anAmountOfBooks .
	bookRequests add: aBook -> anAmountOfBooks.! !


!Cart methodsFor: 'amounts' stamp: 'AD 6/5/2018 11:45:24'!
amountOf: aBook

	^ bookRequests at: aBook.! !

!Cart methodsFor: 'amounts' stamp: 'AD 6/5/2018 11:45:28'!
amountOfBookRequests

	^ bookRequests size.! !


!Cart methodsFor: 'accessing' stamp: 'AD 6/5/2018 11:38:30'!
requestedBooks
	
	^ bookRequests copy.! !


!Cart methodsFor: 'asserting' stamp: 'AD 6/5/2018 11:55:52'!
assertAddingPositive: anAmountOfBooks

	anAmountOfBooks > 0 ifFalse: [ self error: self class cantAddLessThanOneBookErrorMessage ].! !

!Cart methodsFor: 'asserting' stamp: 'AD 6/5/2018 11:55:55'!
assertIsInCatalog: aBook

	(catalog includes: aBook) ifFalse: [ self error: self class cantAddABookThatIsNotInCatalogErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'AD 6/4/2018 21:51:31'!
cantAddABookThatIsNotInCatalogErrorMessage
	
	^ 'Can not add a book that doesnt belong to the editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'AD 6/5/2018 10:05:42'!
cantAddLessThanOneBookErrorMessage
	
	^ 'Can not add less than one book to the cart'! !
