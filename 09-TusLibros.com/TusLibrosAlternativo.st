!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/9/2018 20:57:51'!
test09CanNotCreateACashierForAnEmptyCart

	| cart validCard |
	
	cart _ self createCart.
	validCard _ self createCreditCard.
	
	self should: [	Cashier for: cart payingWith: validCard using: (self defaultPriceList )]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier CartIsEmptyErrorMessage .
			]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/9/2018 20:57:39'!
test10CanNotCreateACashierWithAnExpiredCreditCard

	| cart expiredCard |
	
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	expiredCard _ self createExpiredCreditCard.
	
	self should: [	Cashier for: cart payingWith: expiredCard  using: (self defaultPriceList)]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier ExpiredCreditCardErrorMessage .
			]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/9/2018 21:14:48'!
test11TheTotalPurchaseOfOneItemIsReturnedCorrectlyAfterACheckout

	| cart validCard cashier totalPurchase |
	
	
	cart _ self createCart.
	cart add: self itemSellByTheStore .
	
	validCard _ self createCreditCard.
	
	cashier _ Cashier for: cart payingWith: validCard using: (self defaultPriceList).
	
	totalPurchase _ cashier checkOut.
	
	self assert: totalPurchase = 10. 
		
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/9/2018 21:14:37'!
test12TheTotalPurchaseOfAnAmountGreaterThanOneOfAnItemIsReturnedCorrectlyAfterACheckout

	| cart validCard cashier totalPurchase |
	
	
	cart _ self createCart.
	cart add: 5 of: self itemSellByTheStore .
	
	validCard _ self createCreditCard.
	
	cashier _ Cashier for: cart payingWith: validCard using: (self defaultPriceList).
	
	totalPurchase _ cashier checkOut.
	
	self assert: totalPurchase = 50. 
		
	
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/9/2018 21:06:01'!
test13TheTotalPurchaseODifferentItemsIsReturnedCorrectlyAfterACheckout

	| cart creditCard cashier totalPurchase catalog priceList |	
	
	catalog _ OrderedCollection new.
	catalog add: 'aBook'; add: 'anotherBook'.
	
	priceList _ Dictionary new.
	priceList at: 'aBook' put: 10; at: 'anotherBook' put: 20.
	
	cart _ Cart acceptingItemsOf: catalog.
	
	cart add: 'aBook'.
	cart add: 'anotherBook'.
	
	creditCard _ self createCreditCard.
	
	cashier _ Cashier for: cart payingWith: creditCard using: priceList.
	
	totalPurchase _ cashier checkOut.
		
	self assert: totalPurchase equals: 30.
		
	
! !


!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/11/2018 09:23:15'!
createCreditCard
	
	^ CreditCard withExpiration: (FixedGregorianDate today monthOfYear) next! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/11/2018 09:23:42'!
createExpiredCreditCard
	
	^ CreditCard withExpiration: (FixedGregorianDate today monthOfYear) previous! !

!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/9/2018 20:42:01'!
defaultPriceList
	| priceList |
	priceList _ Dictionary new.
	priceList at: (self itemSellByTheStore) put: 10.
	
	^ priceList! !

!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'AD 6/9/2018 21:10:42'!
assertIsValidQuantity: aQuantity

	((aQuantity isInteger) and: [ aQuantity strictlyPositive ]) ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'AD 6/9/2018 20:47:42'!
items

	^ items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'AD 6/9/2018 20:39:24'!
initializeFor: aCart payingWith: aCreditCard using: aPriceList.

	cart _ aCart.
	creditCard _ aCreditCard.
	priceList _ aPriceList! !


!Cashier methodsFor: 'check out' stamp: 'AD 6/9/2018 21:11:18'!
checkOut

	| totalPurchase |
		
	totalPurchase _ cart items sum: [:item | priceList at: item].
	
	self debit: totalPurchase from: creditCard.
	
	^ totalPurchase! !


!Cashier methodsFor: 'debit' stamp: 'AD 6/9/2018 20:56:21'!
debit: aTotalPurchase from: aCreditCard 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AD 6/9/2018 20:38:39'!
for: aCart payingWith: aCreditCard using: aPriceList

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard.
	
	^ self new initializeFor: aCart payingWith: aCreditCard using: aPriceList.! !


!Cashier class methodsFor: 'error messages' stamp: 'AD 6/9/2018 19:43:42'!
CartIsEmptyErrorMessage
	
	^ 'The cart is empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'AD 6/9/2018 19:54:39'!
ExpiredCreditCardErrorMessage
	
	^ 'The credit card is expired'! !


!Cashier class methodsFor: 'assertions' stamp: 'AD 6/9/2018 20:00:06'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue:[self error: self CartIsEmptyErrorMessage]! !

!Cashier class methodsFor: 'assertions' stamp: 'AD 6/9/2018 20:06:19'!
assertIsNotExpired: aCreditCard

	aCreditCard hasExpired ifTrue: [ self error: self ExpiredCreditCardErrorMessage]! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'AD 6/11/2018 09:22:22'!
initilalizeWithExpiration: aMonthOfYear
	expirationMonth _ aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'AD 6/11/2018 09:22:22'!
hasExpired
	^ expirationMonth < FixedGregorianDate today monthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AD 6/11/2018 09:12:47'!
withExpiration: aMonthOfYear

	^ self new initilalizeWithExpiration: aMonthOfYear.! !
