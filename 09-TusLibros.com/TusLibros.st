!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:53:32'!
test02CanNotAddItemsThatDoNotBelongToStore
	| cart |
	cart _ self createCart.
	self
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:53:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore
	| cart |
	cart _ self createCart.
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:53:10'!
test04CanNotAddNonPositiveNumberOfItems
	| cart |
	cart _ self createCart.
	self
		should: [
			cart
				add: 0
				of: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:55:01'!
test05CanNotAddMoreThanOneItemNotSoldByTheStore

	| cart |
	
	cart _ self createCart.
	
	self should: [	cart add: 2 of: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:54:35'!
test06CartRemembersAddedItems

	| cart |
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	self assert: (cart includes: self itemSoldByTheStore).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:54:28'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart _ self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:54:20'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart _ self createCart.
	cart add: 2 of: self itemSoldByTheStore.
	
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 18:58:17'!
test09CanNotAddNonIntegerNumberOfItems

	| cart |
	
	cart _ self createCart.
	
	self should: [	cart add: 1.5 of: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 20:11:36'!
test10CanNotCreateACashierForAnEmptyCart

	| emptyCart validCard |
	
	emptyCart _ self createEmptyCart.
	validCard _ self createCreditCard.
	
	self should: [	Cashier for: emptyCart payingWith: validCard on: Date today ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckOutAnEmptyCartErrorMessage .
			].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 20:11:47'!
test11CanNotCreateACashierWithAnExpiredCreditCard

	| cart expiredCard |
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	expiredCard _ self createExpiredCreditCard.
	
	self should: [	Cashier for: cart payingWith: expiredCard on: Date today ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotPayWithAnExpiredCardErrorMessage.
			].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 20:18:17'!
test12

	| cart creditCard cashier purchaseTotal |
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	creditCard _ self createCreditCard.
	
	cashier _ Cashier for: cart payingWith: creditCard on: Date today.
	
	purchaseTotal _ cashier checkOut.
		
	self assert: purchaseTotal equals: 10.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 20:43:35'!
test13

	| cart creditCard cashier purchaseTotal catalog |	
	
	catalog _ Dictionary new.
	catalog at: 'aBook' put: 10.
	
	cart _ Cart acceptingItemsOf: catalog.
	
	cart add: 2 of: 'aBook'.
	
	creditCard _ self createCreditCard.
	
	cashier _ Cashier for: cart payingWith: creditCard on: Date today.
	
	purchaseTotal _ cashier checkOut.
		
	self assert: purchaseTotal equals: 20.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/7/2018 20:43:03'!
test14

	| cart creditCard cashier purchaseTotal catalog |	
	
	catalog _ Dictionary new.
	catalog at: 'aBook' put: 10; at: 'otherBook' put: 20.
	
	cart _ Cart acceptingItemsOf: catalog.
	
	cart add: 'aBook'.
	cart add: 'otherBook'.
	
	creditCard _ self createCreditCard.
	
	cashier _ Cashier for: cart payingWith: creditCard on: Date today.
	
	purchaseTotal _ cashier checkOut.
		
	self assert: purchaseTotal equals: 30.! !


!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/7/2018 19:41:26'!
createCreditCard
	
	^ CreditCard expiringOn: (Date tomorrow).! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/7/2018 19:08:10'!
createEmptyCart
	
	^ Cart acceptingItemsOf: self defaultCatalog.! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/7/2018 19:40:19'!
createExpiredCreditCard
	
	^ CreditCard expiringOn: (Date yesterday).! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/7/2018 20:01:45'!
defaultCatalog
	
	| catalog |
	
	catalog _ Dictionary new.
	
	catalog at: self itemSoldByTheStore put: 10.
	
	^ catalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/7/2018 18:53:32'!
itemNotSoldByTheStore
	^ 'invalidBook'.! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/7/2018 18:53:10'!
itemSoldByTheStore
	^ 'validBook'.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'AD 6/7/2018 20:02:40'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'AD 6/7/2018 19:01:06'!
assertIsValidQuantity: aQuantity

	((aQuantity isInteger) and: [ aQuantity strictlyPositive ]) ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'AD 6/7/2018 19:21:56'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'AD 6/7/2018 20:42:04'!
total
	
	^ items sum: [:item | catalog at: item]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'AD 6/7/2018 19:22:56'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'AD 6/7/2018 20:06:19'!
initializeFor: aCart payingWith: aCreditCard 
	
	cart _ aCart.
	creditCard _ aCreditCard.! !


!Cashier methodsFor: 'check out' stamp: 'AD 6/7/2018 20:54:21'!
checkOut

	| purchaseTotal |
	
	purchaseTotal _ cart total.
	
	self debit: purchaseTotal from: creditCard.
	
	^ purchaseTotal.! !


!Cashier methodsFor: 'debiting' stamp: 'AD 6/7/2018 20:42:45'!
debit: anAmount from: aCreditCard 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AD 6/7/2018 20:09:10'!
for: aCart payingWith: aCreditCard on: aDate 
	
	self assertIsNotEmpty: aCart.
	self assert: aCreditCard isNotExpiredOn: aDate.
	
	^ self new initializeFor: aCart payingWith: aCreditCard ! !


!Cashier class methodsFor: 'assertions' stamp: 'AD 6/7/2018 19:34:31'!
assert: aCreditCard isNotExpiredOn: aDate 
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotPayWithAnExpiredCardErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'AD 6/7/2018 19:15:04'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self canNotCheckOutAnEmptyCartErrorMessage]! !


!Cashier class methodsFor: 'error messages' stamp: 'AD 6/7/2018 19:15:40'!
canNotCheckOutAnEmptyCartErrorMessage
	
	^ 'Can not check out an empty cart.'! !

!Cashier class methodsFor: 'error messages' stamp: 'AD 6/7/2018 19:36:11'!
canNotPayWithAnExpiredCardErrorMessage
	
	^ 'Can not pay with an expired credit card.'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'AD 6/7/2018 19:30:53'!
initializeExpiringOn: aDate 
	
	expirationDate _ aDate.! !


!CreditCard methodsFor: 'queries' stamp: 'AD 6/7/2018 20:04:41'!
isExpiredOn: aDate 
	
	^ expirationDate < aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AD 6/7/2018 19:35:04'!
expiringOn: aDate 
	
	^ self new initializeExpiringOn: aDate! !
