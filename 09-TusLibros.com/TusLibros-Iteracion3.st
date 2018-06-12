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

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/11/2018 20:30:42'!
test10CanNotCreateACashierForAnEmptyCart

	| emptyCart validCard salesBook merchantProcessor |
	
	salesBook _ OrderedCollection new.
	
	emptyCart _ self createEmptyCart.
	validCard _ self createCreditCard.
	merchantProcessor _ MerchantProcessorSimulator new.	
	self should: [	Cashier toCheckOut: emptyCart payingWith: validCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckOutAnEmptyCartErrorMessage .
			self assert: salesBook isEmpty.
			].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/11/2018 20:32:15'!
test11CanNotCreateACashierWithAnExpiredCreditCard

	| cart expiredCard salesBook merchantProcessor | 
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	expiredCard _ self createExpiredCreditCard.
	
	salesBook _ OrderedCollection new.
		
	merchantProcessor _ MerchantProcessorSimulator new.
	self should: [ Cashier toCheckOut: cart payingWith: expiredCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotPayWithAnExpiredCardErrorMessage.
			self assert: salesBook isEmpty.
			].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/11/2018 20:30:55'!
test12CheckoutForACartWithOneProductReturnsTheCorrectPurchaseTotal

	| cart creditCard cashier saleTotal salesBook merchantProcessor |
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	creditCard _ self createCreditCard.
	
	salesBook _ OrderedCollection  new.
	
	merchantProcessor _ MerchantProcessorSimulator new.
	cashier _ Cashier toCheckOut: cart payingWith: creditCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor.
	
	saleTotal _ cashier checkOut.
	

		
	self assert: saleTotal equals: 10.
	self assert: (salesBook at: 1) equals: 10! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/11/2018 20:31:00'!
test13CheckoutForACartWithMoreThanOneOfTheSameProductReturnsTheCorrectPurchaseTotal

	| cart creditCard cashier saleTotal catalog salesBook merchantProcessor |	
	
	catalog _ Dictionary new.
	catalog at: 'aBook' put: 10.
	
	cart _ Cart acceptingItemsOf: catalog.
	
	cart add: 2 of: 'aBook'.
	
	creditCard _ self createCreditCard.
	
	salesBook _ OrderedCollection new.
	
	merchantProcessor _ MerchantProcessorSimulator new.
	
	cashier _ Cashier toCheckOut: cart payingWith: creditCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor.
	
	saleTotal _ cashier checkOut.
		
	self assert: saleTotal equals: 20.
	self assert: (salesBook at:1) equals:20
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/11/2018 20:31:04'!
test14CheckoutForACartWithDifferentProductsReturnsTheCorrectPurchaseTotal

	| cart creditCard cashier saleTotal catalog salesBook merchantProcessor |	
	
	catalog _ Dictionary new.
	catalog at: 'aBook' put: 10; at: 'otherBook' put: 20.
	
	cart _ Cart acceptingItemsOf: catalog.
	
	cart add: 'aBook'.
	cart add: 'otherBook'.
	
	creditCard _ self createCreditCard.
	
	salesBook _ OrderedCollection new.
	
	merchantProcessor _ MerchantProcessorSimulator new.
	
	cashier _  Cashier toCheckOut: cart payingWith: creditCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor.
	
	saleTotal _ cashier checkOut.
		
	self assert: saleTotal equals: 30.
	self assert: (salesBook at: 1) equals: 30! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/12/2018 08:23:03'!
test15ASaleIsNotRegisteredWhenPayingWithAStolenCard

	| cart validCard salesBook cashier merchantProcessor stolenCardErrorMessage |
	stolenCardErrorMessage _ 'The Credit Card is stolen'.
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	validCard _ self createCreditCard.
	
	salesBook _ OrderedCollection new.
	
	merchantProcessor _ MerchantProcessorSimulator answering: [self error: stolenCardErrorMessage ].
	cashier _ Cashier toCheckOut: cart payingWith: validCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor.
	self should: [cashier checkOut]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = stolenCardErrorMessage.
			self assert: salesBook isEmpty.
			].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/12/2018 08:23:09'!
test16ASaleIsNotRegisteredWhenPayingWithACreditCardWithoutEnoughMoney

	| cart validCard salesBook cashier merchantProcessor notEnoughMoneyInCardErrorMessage |
	notEnoughMoneyInCardErrorMessage _ 'The Credit Card doesnt have enough money'.
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	validCard _ self createCreditCard.
	
	salesBook _ OrderedCollection new.
	
	merchantProcessor _ MerchantProcessorSimulator answering: [self error: notEnoughMoneyInCardErrorMessage ].
	cashier _ Cashier toCheckOut: cart payingWith: validCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor.
	self should: [cashier checkOut]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = notEnoughMoneyInCardErrorMessage.
			self assert: salesBook isEmpty.
			].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/12/2018 08:33:27'!
test17ASaleIsNotRegisteredWhenPayingWithACreditCardWithANameLongerThan30Characters

	| cart validCard salesBook cashier merchantProcessor ownerNameTooLongErrorMessage |
	ownerNameTooLongErrorMessage _ 'The Credit Card has an owner name longer than 30 characters'.
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	validCard _ self createLongNameCreditCard.
	
	salesBook _ OrderedCollection new.
	
	merchantProcessor _ MerchantProcessorSimulator answering: [self error: ownerNameTooLongErrorMessage ].
	cashier _ Cashier toCheckOut: cart payingWith: validCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor.
	self should: [cashier checkOut]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = ownerNameTooLongErrorMessage.
			self assert: salesBook isEmpty.
			].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'AD 6/12/2018 08:33:21'!
test18CanNotCheckOutACartMoreThanOneTime

	| cart validCard cashier saleTotal salesBook merchantProcessor |
	
	cart _ self createCart.
	
	cart add: self itemSoldByTheStore.
	
	validCard _ self createCreditCard.
	
	salesBook _ OrderedCollection  new.
	
	merchantProcessor _ MerchantProcessorSimulator new.
	cashier _ Cashier toCheckOut: cart payingWith: validCard on: Date today registeringOn: salesBook processingPaymentWith: merchantProcessor.
	saleTotal _ cashier checkOut.
	
	self assert: saleTotal equals: 10.
	self assert: (salesBook at: 1) equals: 10.
	
	self should: [saleTotal _ saleTotal + cashier checkOut]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckOutACartMoreThanOneTimeErrorMessage.
			self assert: saleTotal equals: 10.
			self assert: (salesBook at: 1) equals: 10.
			self assert: salesBook size = 1.
			].! !


!TusLibrosTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/12/2018 08:32:20'!
createCreditCard
	
	^ CreditCard withOwner: 'John Doe' expiringOn: (FixedGregorianDate today monthOfYear ) next.! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/7/2018 19:08:10'!
createEmptyCart
	
	^ Cart acceptingItemsOf: self defaultCatalog.! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/12/2018 08:32:01'!
createExpiredCreditCard
	
	^ CreditCard withOwner: 'John Doe' expiringOn: (FixedGregorianDate today monthOfYear) previous.! !

!TusLibrosTest methodsFor: 'support' stamp: 'AD 6/12/2018 08:31:22'!
createLongNameCreditCard
	
	^ CreditCard withOwner: 'A very very long name of an owner' expiringOn: (FixedGregorianDate today monthOfYear ) next.! !

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
	instanceVariableNames: 'cart creditCard date salesBook merchantProcessor saleIsProcessed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'AD 6/11/2018 20:30:02'!
initializeToCheckOut: aCart payingWith: aCreditCard on: aDate registeringOn: aSalesBook processingPaymentWith: aMerchantProcessorSimulator
	cart _ aCart.
	creditCard _ aCreditCard.
	date _ aDate.
	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessorSimulator.
	saleIsProcessed _ false.! !


!Cashier methodsFor: 'check out' stamp: 'AD 6/11/2018 20:29:32'!
checkOut

	| saleTotal |
	saleIsProcessed ifTrue: [ self error: self class canNotCheckOutACartMoreThanOneTimeErrorMessage ].
	
	saleTotal _ cart total.
	merchantProcessor debit: saleTotal from: creditCard.
	
	salesBook add: saleTotal.
	saleIsProcessed _ true.
	
	^ saleTotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AD 6/11/2018 20:30:24'!
toCheckOut: aCart payingWith: aCreditCard on: aDate registeringOn: aSalesBook processingPaymentWith: aMerchantProcessorSimulator 

	self assertIsNotEmpty: aCart.
	self assert: aCreditCard isNotExpiredOn: aDate.
	
	^ self new initializeToCheckOut: aCart payingWith: aCreditCard on: aDate registeringOn: aSalesBook processingPaymentWith: aMerchantProcessorSimulator
	! !


!Cashier class methodsFor: 'assertions' stamp: 'AD 6/7/2018 19:34:31'!
assert: aCreditCard isNotExpiredOn: aDate 
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotPayWithAnExpiredCardErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'AD 6/7/2018 19:15:04'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self canNotCheckOutAnEmptyCartErrorMessage]! !


!Cashier class methodsFor: 'error messages' stamp: 'AD 6/11/2018 20:21:39'!
canNotCheckOutACartMoreThanOneTimeErrorMessage
	
	^ 'Can not checkout a cart more than one time.'! !

!Cashier class methodsFor: 'error messages' stamp: 'AD 6/7/2018 19:15:40'!
canNotCheckOutAnEmptyCartErrorMessage
	
	^ 'Can not check out an empty cart.'! !

!Cashier class methodsFor: 'error messages' stamp: 'AD 6/7/2018 19:36:11'!
canNotPayWithAnExpiredCardErrorMessage
	
	^ 'Can not pay with an expired credit card.'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonth owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'AD 6/12/2018 08:29:39'!
initializeWithOwner: aName ExpiringOn: aMonthOfYear

	owner _ aName.
	expirationMonth _ aMonthOfYear.! !


!CreditCard methodsFor: 'queries' stamp: 'AD 6/11/2018 09:40:23'!
isExpiredOn: aDate

	^ expirationMonth < ((FixedGregorianDate fromDate: aDate) monthOfYear).! !

!CreditCard methodsFor: 'queries' stamp: 'AD 6/12/2018 08:37:01'!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AD 6/12/2018 08:28:58'!
withOwner: aName expiringOn: aMonthOfYear 
	
	^ self new initializeWithOwner: aName ExpiringOn: aMonthOfYear! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'response'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'AD 6/12/2018 08:22:07'!
initialize

	response _ [].! !

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'AD 6/12/2018 08:22:13'!
initializeAnswering: aResponseBlock

	response _ aResponseBlock.! !


!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'AD 6/12/2018 08:21:40'!
debit: anAmount from: aCreditCard 
	
	response value.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'AD 6/11/2018 19:38:43'!
answering: aResponseBlock 

	^ self new initializeAnswering: aResponseBlock.! !
