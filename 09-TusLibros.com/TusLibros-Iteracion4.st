!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:27'!
test02CanNotAddItemsThatDoNotBelongToStore
	| cart |
	cart _ testObjectsFactory createCart.
	self
		should: [ cart add: testObjectsFactory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ].! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore
	| cart |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test04CanNotAddNonPositiveNumberOfItems
	| cart |
	cart _ testObjectsFactory createCart.
	self
		should: [
			cart
				add: 0
				of: testObjectsFactory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ].! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:27'!
test05CanNotAddMoreThanOneItemNotSellByTheStore
	| cart |
	cart _ testObjectsFactory createCart.
	self
		should: [
			cart
				add: 2
				of: testObjectsFactory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ].! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test06CartRemembersAddedItems
	| cart |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	self assert: (cart includes: testObjectsFactory itemSoldByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test07CartDoesNotHoldNotAddedItems
	| cart |
	cart _ testObjectsFactory createCart.
	self deny: (cart includes: testObjectsFactory itemSoldByTheStore).! !

!CartTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test08CartRemembersTheNumberOfAddedItems
	| cart |
	cart _ testObjectsFactory createCart.
	cart
		add: 2
		of: testObjectsFactory itemSoldByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSoldByTheStore) = 2.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:03:06'!
test02CalculatedTotalIsCorrect
	| cart cashier |
	cart _ testObjectsFactory createCart.
	cart
		add: 2
		of: testObjectsFactory itemSoldByTheStore.
	cashier _ Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.
	self assert: cashier checkOut = (testObjectsFactory itemSoldByTheStorePrice * 2).! !

!CashierTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test03CanNotCheckoutWithAnExpiredCreditCart
	| cart salesBook |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	salesBook _ OrderedCollection new.
	self
		should: [
			Cashier
				toCheckout: cart
				charging: testObjectsFactory expiredCreditCard
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test04CheckoutRegistersASale
	| cart cashier salesBook total |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	salesBook _ OrderedCollection new.
	cashier _ Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
	total _ cashier checkOut.
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test05CashierChargesCreditCardUsingMerchantProcessor
	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	creditCard _ testObjectsFactory notExpiredCreditCard.
	salesBook _ OrderedCollection new.
	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
	debitBehavior _ [ :anAmount :aCreditCard |
	debitedAmout _ anAmount.
	debitedCreditCard _ aCreditCard ].
	total _ cashier checkOut.
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'AD 6/14/2018 20:02:46'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit
	| cart cashier salesBook creditCard |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
	creditCard _ testObjectsFactory notExpiredCreditCard.
	salesBook _ OrderedCollection new.
	debitBehavior _ [ :anAmount :aCreditCard |
	self error: Cashier creditCardHasNoCreditErrorMessage ].
	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
	self
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ].! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'set up' stamp: 'AD 6/14/2018 20:09:26'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/14/2018 21:27:48'!
test01

	| restInterface userDatabase invalidUsername password 
	catalog |
	userDatabase _ testObjectsFactory defaultUserDatabase.
	catalog _ testObjectsFactory defaultCatalog.

	restInterface _ RestInterface with: userDatabase acceptingItemsFrom: catalog.
	invalidUsername _ 'An invalid username' .
	password _  '1234'.
	
	self should:  [restInterface createCartWith: invalidUsername and: password]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [: anError |
			self assert: anError messageText equals: restInterface class invalidUserMessageText.
		].
	


	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/14/2018 21:28:23'!
test02

	| restInterface userDatabase username invalidPassword catalog |
	
	userDatabase _ testObjectsFactory defaultUserDatabase.
	catalog _ testObjectsFactory defaultCatalog.

	restInterface _ RestInterface with: userDatabase acceptingItemsFrom: catalog.
	username _ 'John Doe' .
	invalidPassword _  '4321'.
	
	self should:  [restInterface createCartWith: username and: invalidPassword]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [: anError |
			self assert: anError messageText equals: restInterface class invalidPasswordErrorMessage.
		].
	


	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/14/2018 21:28:59'!
test03

	| restInterface userDatabase username password cartID itemsList catalog |
	
	userDatabase _ testObjectsFactory defaultUserDatabase.
	catalog _ testObjectsFactory defaultCatalog.

	restInterface _ RestInterface with: userDatabase acceptingItemsFrom: catalog.
	username _ 'John Doe' .
	password _  '1234'.
	
	cartID _ restInterface createCartWith: username and: password.
	
	itemsList _ restInterface list: cartID.
	
	self assert: itemsList isEmpty.
	


	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/14/2018 21:26:39'!
test04

	| restInterface userDatabase username password cartID itemsList book catalog |
	
	userDatabase _ testObjectsFactory defaultUserDatabase.
	catalog _ testObjectsFactory defaultCatalog.

	restInterface _ RestInterface with: userDatabase acceptingItemsFrom: catalog.
	username _ 'John Doe' .
	password _  '1234'.
	
	cartID _ restInterface createCartWith: username and: password.
	book _ testObjectsFactory itemSoldByTheStore.
	
	restInterface add: 1 of: book to: cartID.  
	
	itemsList _ restInterface list: cartID.
	
	self deny: itemsList isEmpty.
	self assert: (itemsList at: book) equals: 1.
	


	! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'listing' stamp: 'AD 6/14/2018 21:16:56'!
itemList
		
	| list |
	
	list _ Dictionary new.
	
	items do: [ :item | list at: item ifAbsent: [list at: item put: (items occurrencesOf: item)]].
	
	^ list. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'userDatabase carts catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'AD 6/14/2018 21:06:17'!
initializeWith: aUserDatabase

	userDatabase _ aUserDatabase.
	
	carts _ Dictionary new.
	! !

!RestInterface methodsFor: 'initialization' stamp: 'AD 6/14/2018 21:24:57'!
initializeWith: userDataBase acceptingItemsFrom: aCatalog 
	
	userDatabase _ userDataBase.
	
	catalog _ aCatalog.
	
	carts _ Dictionary new.! !


!RestInterface methodsFor: 'operations' stamp: 'AD 6/14/2018 21:05:15'!
createCartWith: aUser and: aPassword

	| cart cartID |
	
	(userDatabase keys includes: aUser) ifFalse: [ self error: self class invalidUserMessageText. ].
	
	((userDatabase at: aUser) = aPassword) ifFalse: [self error: self class invalidPasswordErrorMessage].
	
	cart _ Cart acceptingItemsOf: catalog.
	
	cartID _ 1.
	
	carts at: cartID put: cart.
	
	^ cartID.! !

!RestInterface methodsFor: 'operations' stamp: 'AD 6/14/2018 21:02:11'!
list: aCartID 
	
	^ (carts at: aCartID) itemList.! !


!RestInterface methodsFor: 'as yet unclassified' stamp: 'AD 6/14/2018 21:18:51'!
add: anAmount of: aBook to: aCart

	| cart |
	
	cart _ carts at: aCart.
	
	cart add: anAmount of: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'AD 6/14/2018 21:22:46'!
with: userDataBase acceptingItemsFrom: catalog

		^ self new initializeWith: userDataBase acceptingItemsFrom: catalog.
	
	! !


!RestInterface class methodsFor: 'error messages' stamp: 'AD 6/14/2018 20:35:37'!
invalidPasswordErrorMessage
	
	^ 'Invalid password.'! !

!RestInterface class methodsFor: 'error messages' stamp: 'AD 6/14/2018 20:32:22'!
invalidUserMessageText
	
	^ 'Invalid Username'! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AD 6/14/2018 20:02:27'!
itemNotSoldByTheStore
	^ 'invalidBook'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AD 6/14/2018 20:02:46'!
itemSoldByTheStore
	^ 'validBook'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AD 6/14/2018 20:03:06'!
itemSoldByTheStorePrice
	^ 10.! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AD 6/14/2018 20:03:06'!
defaultCatalog
	^ Dictionary new
		
			at: self itemSoldByTheStore
			put: self itemSoldByTheStorePrice;
		yourself.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AD 6/14/2018 20:50:42'!
defaultUserDatabase
	^ Dictionary new
		
			at: 'John Doe'
			put: '1234';
		yourself. ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
