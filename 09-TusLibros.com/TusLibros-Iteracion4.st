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


!classDefinition: #TusLibrosFacadeTest category: #TusLibros!
TestCase subclass: #TusLibrosFacadeTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosFacadeTest methodsFor: 'set up' stamp: 'AD 6/14/2018 20:09:26'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:31:32'!
test01CanNotCreateACartWithAnInvalidUsername

	| facade invalidUsername password |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	invalidUsername _ testObjectsFactory invalidUsername.
	password _  testObjectsFactory validPassword.
	
	self should: [	facade createCartFor: invalidUsername and: password ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: facade class invalidUserMessageText ].! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:31:42'!
test02CanNotCreateACartWithAnInvalidPassword

	| facade username invalidPassword |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	invalidPassword _ testObjectsFactory invalidPassword.
	
	self should: [ facade createCartFor: username	and: invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText	equals: facade class invalidPasswordErrorMessage
		].! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:31:49'!
test03ACartIsCreatedEmpty

	| facade username password cartID itemsList |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ facade createCartFor: username and: password.
	itemsList _ facade listCart: cartID.
	
	self assert: itemsList isEmpty.! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:31:59'!
test04CartRegistersItemsAdded

	| facade username password cartID itemsList book |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ facade createCartFor: username and: password.
	book _ testObjectsFactory itemSoldByTheStore.
	
	facade add: 1 of: book to: cartID.
	itemsList _ facade listCart: cartID.
	
	self deny: itemsList isEmpty.
	self assert: (itemsList at: book) equals: 1.! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:32:13'!
test05CanNotAddProductsToAnInexistentCart

	| facade invalidCartID book |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	book _ testObjectsFactory itemSoldByTheStore.
	
	invalidCartID _ testObjectsFactory invalidCartID.	
	
	self should:  [ facade add: 1 of: book to: invalidCartID. ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: facade class invalidCartIDMessageText.
		].! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:32:22'!
test06CanNotListPurchasesForAnInvalidUsername

	| facade invalidUsername password |
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	invalidUsername _ testObjectsFactory invalidUsername.
	password _  testObjectsFactory validPassword.
	self should:  [ facade listPurchasesFor: invalidUsername with: password.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: facade class invalidUserMessageText.
		].! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:32:30'!
test07CanNotListPurchasesWithAnInvalidPassword

	| facade username invalidPassword |	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	username _ testObjectsFactory validUsername.
	invalidPassword _ testObjectsFactory invalidPassword.
	self should:  [facade listPurchasesFor: username with: invalidPassword.]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [: anError |
			self assert: anError messageText equals: facade class invalidPasswordErrorMessage.
		].! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:32:40'!
test08AUserThatDidntBuyAnythingHasNoPurchasesRegistered

	| facade username password purchasesList |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	purchasesList _ facade listPurchasesFor: username with: password.
	
	self assert: purchasesList isEmpty.! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:32:47'!
test09CanNotCheckOutAnInexistentCart

	| facade invalidCartID |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	invalidCartID _ testObjectsFactory invalidCartID.	
	
	self should:  [ facade checkOutCart: invalidCartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Juan'.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: facade class invalidCartIDMessageText.
		].! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:32:57'!
test10AClientPurchaseIsRegisteredCorrectly

	| facade username password cartID book listOfPurchases |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ facade createCartFor: username and: password.
	
	book _ testObjectsFactory itemSoldByTheStore.
	facade add: 1 of: book to: cartID.
	
	facade checkOutCart: cartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Juan'.
	listOfPurchases _ facade listPurchasesFor: username with: password.
	
	self assert: listOfPurchases size = 1.
	self assert: (listOfPurchases at: 1) totalItemsSold equals: 1.
	self assert: (listOfPurchases at: 1) total equals: testObjectsFactory itemSoldByTheStorePrice.! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:33:03'!
test11CanNotListAnInexistentCart

	| facade invalidCartID |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	invalidCartID _ testObjectsFactory invalidCartID.	
	
	self should:  [ facade listCart: invalidCartID.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: facade class invalidCartIDMessageText.
		].! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:33:20'!
test12AClientMultiplePurchasesAreRegisteredCorrectly

	| facade username password cartID book listOfPurchases anotherCartID |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ facade createCartFor: username and: password.
	
	book _ testObjectsFactory itemSoldByTheStore.
	facade add: 1 of: book to: cartID.
	
	facade checkOutCart: cartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Juan'.
	listOfPurchases _ facade listPurchasesFor: username with: password.
	
	anotherCartID _ facade createCartFor: username and: password.
	
	facade add: 10 of: book to: anotherCartID.
	
	facade checkOutCart: anotherCartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Juan'.
	listOfPurchases _ facade listPurchasesFor: username with: password.
	
	self assert: (cartID = anotherCartID) not.
	self assert: listOfPurchases size = 2.
	self assert: (listOfPurchases at: 1) totalItemsSold equals: 1.
	self assert: (listOfPurchases at: 1) total equals: testObjectsFactory itemSoldByTheStorePrice.
	self assert: (listOfPurchases at: 2) totalItemsSold equals: 10.
	self assert: (listOfPurchases at: 2) total equals: testObjectsFactory itemSoldByTheStorePrice * 10.! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:33:39'!
test13MultipleClientsPurchasesAreRegisteredCorrectly

	| facade book johnDoeCartID johnDoePassword johnDoeUsername johnDoeListOfPurchases thomasSmithCartID thomasSmithListOfPurchases thomasSmithPassword thomasSmithUsername |
	
	facade _ testObjectsFactory defaultInterfaceChargingThrough: self.
	book _ testObjectsFactory itemSoldByTheStore.
	
	johnDoeUsername _ testObjectsFactory validUsername.
	johnDoePassword _ testObjectsFactory validPassword.
	
	thomasSmithUsername _ 'Thomas Smith'.
	thomasSmithPassword _ '5678'.
	
	johnDoeCartID _ facade createCartFor: johnDoeUsername and: johnDoePassword.
	thomasSmithCartID _ facade createCartFor: thomasSmithUsername and: thomasSmithPassword.
	

	facade add: 1 of: book to: johnDoeCartID.
	facade add: 10 of: book to: thomasSmithCartID.
	
	facade checkOutCart: johnDoeCartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'John Doe'.
	johnDoeListOfPurchases _ facade listPurchasesFor: johnDoeUsername with: johnDoePassword.
	
	facade checkOutCart: thomasSmithCartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Thomas Smith'.
	thomasSmithListOfPurchases _ facade listPurchasesFor: thomasSmithUsername with: thomasSmithPassword.

	self assert: (johnDoeCartID = thomasSmithCartID) not.
	
	self assert: johnDoeListOfPurchases size = 1.
	self assert: (johnDoeListOfPurchases at: 1) totalItemsSold equals: 1.
	self assert: (johnDoeListOfPurchases at: 1) total equals: testObjectsFactory itemSoldByTheStorePrice.
	
	self assert: thomasSmithListOfPurchases size = 1.
	self assert: (thomasSmithListOfPurchases at: 1) totalItemsSold equals: 10.
	self assert: (thomasSmithListOfPurchases at: 1) total equals:  testObjectsFactory itemSoldByTheStorePrice * 10.
	
! !

!TusLibrosFacadeTest methodsFor: 'tests' stamp: 'AD 6/18/2018 14:40:42'!
test14CanNotAddItemsToAnExpiredCart

	| facade username password cartID book manualClock |
	
	manualClock _ ManualClock new.
	
	facade _ TusLibrosFacade
		with: testObjectsFactory defaultUserDatabase
		acceptingItemsFrom: testObjectsFactory defaultCatalog
		chargingThrough: self
		watchingTimeOn: manualClock.
		
	book _ testObjectsFactory itemSoldByTheStore.
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ facade
		createCartFor: username
		and: password.
		
	"Pasan 60 minutos ..............."
	manualClock forward: 60 minutes.
	
	self should: [	facade add: 1 of: book to: cartID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: facade class cartExpiredErrorMessage ].! !


!TusLibrosFacadeTest methodsFor: 'merchant processor protocol' stamp: 'AD 6/17/2018 15:37:16'!
debit: anAmount from: aCreditCard 
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items owner clock lastTimeUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'AD 6/18/2018 11:45:40'!
cartExpiredErrorMessage

	^ 'Cart has expired due to 30 minutes of inactivity time'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'AD 6/18/2018 11:46:12'!
assertHasNotExpired


	 (self hasExpired) ifTrue: [self error: self cartExpiredErrorMessage].! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'AD 6/18/2018 13:39:45'!
initializeFor: anOwner acceptingItemsOf: aCatalog watchingTimeOn: aClock
	self.
	owner _ anOwner.
	catalog _ aCatalog.
	items _ OrderedCollection new.
	clock _ aClock.
	lastTimeUsed _ clock time.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'AD 6/18/2018 13:39:45'!
hasExpired
	^ (clock time - lastTimeUsed) totalMinutes > 30.! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'AD 6/18/2018 11:49:59'!
total	
	self assertHasNotExpired.
	
	self updateLastTimeUsed.
	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'AD 6/18/2018 11:49:25'!
add: aQuantity of: anItem
	self assertHasNotExpired.
	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	1 to: aQuantity do: [ :aNumber | items add: anItem ].
	
	self updateLastTimeUsed
	! !


!Cart methodsFor: 'listing' stamp: 'AD 6/18/2018 11:49:44'!
itemList
		
	| list |
	self assertHasNotExpired.
	list _ Dictionary new.
	
	items do: [ :item | list at: item ifAbsent: [list at: item put: (items occurrencesOf: item)]].
	self updateLastTimeUsed.	
	^ list. ! !

!Cart methodsFor: 'listing' stamp: 'AD 6/17/2018 17:02:50'!
itemListRaw		
	^ items copy.! !


!Cart methodsFor: 'accessing' stamp: 'AD 6/17/2018 17:00:06'!
owner

	^ owner! !


!Cart methodsFor: 'time' stamp: 'AD 6/18/2018 13:39:45'!
lastTimeUsed
	^ lastTimeUsed.! !

!Cart methodsFor: 'time' stamp: 'AD 6/18/2018 13:39:45'!
updateLastTimeUsed
	lastTimeUsed _ clock time.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AD 6/18/2018 11:24:55'!
for: aClient acceptingItemsOf: aCatalog watchingTimeOn: aClock
	
	^ self new initializeFor: aClient acceptingItemsOf: aCatalog watchingTimeOn: aClock.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total buyer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AD 6/17/2018 16:54:13'!
createSale
	^ Sale for: cart.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AD 6/17/2018 17:05:36'!
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


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'accessing' stamp: 'AD 6/18/2018 14:07:58'!
date
	
	self subclassResponsibility.! !

!Clock methodsFor: 'accessing' stamp: 'AD 6/18/2018 14:07:50'!
time
	
	self subclassResponsibility.! !


!classDefinition: #ManualClock category: #TusLibros!
Clock subclass: #ManualClock
	instanceVariableNames: 'dateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'accessing' stamp: 'AD 6/18/2018 14:10:24'!
date

	^ dateAndTime date.! !

!ManualClock methodsFor: 'accessing' stamp: 'AD 6/18/2018 14:10:31'!
time

	^ dateAndTime time.! !


!ManualClock methodsFor: 'initialization' stamp: 'AD 6/18/2018 14:13:20'!
initialize

	"Set to the Christ's birthday. Halleluja!!"
	
	dateAndTime _ DateAndTime year: 1 month: 1 day: 1 hour: 0 minute: 0 second: 1.! !


!ManualClock methodsFor: 'modifiers' stamp: 'AD 6/18/2018 14:13:50'!
forward: aPeriodOfTime

	dateAndTime _ dateAndTime + aPeriodOfTime! !

!ManualClock methodsFor: 'modifiers' stamp: 'AD 6/18/2018 14:09:39'!
setTo: aDate

	dateAndTime _ aDate.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'AD 6/17/2018 15:31:14'!
isExpiredOn: aDate 
	
	^expiration < (GregorianMonthOfYear yearNumber: aDate yearNumber monthNumber: aDate monthIndex)! !


!CreditCard methodsFor: 'initialization' stamp: 'AD 6/17/2018 15:19:06'!
initializeWithNumber: creditCardNumber expiringOn: aMonthOfYear ownedBy: ownerName

	number _ creditCardNumber.
	
	expiration _ aMonthOfYear.
	
	owner _ ownerName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AD 6/17/2018 15:17:50'!
number: number expiringOn: aMonthOfYear ownedBy: owner 
	
	^ self new initializeWithNumber: number expiringOn: aMonthOfYear ownedBy: owner ! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'saleCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'AD 6/17/2018 16:59:09'!
total
	^ saleCart total.! !


!Sale methodsFor: 'initialization' stamp: 'AD 6/17/2018 17:08:17'!
initializeFor: aCart

	saleCart _ aCart copy.! !


!Sale methodsFor: 'accessing' stamp: 'AD 6/17/2018 16:59:09'!
buyer
	^ saleCart owner.! !


!Sale methodsFor: 'queries' stamp: 'AD 6/17/2018 17:03:04'!
totalItemsSold
	
	^ saleCart itemListRaw size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AD 6/17/2018 16:55:21'!
for: saleCart 
	
	^ self new initializeFor: saleCart.! !


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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AD 6/18/2018 11:47:47'!
createCart
	
	^Cart for: 'SomeClient' acceptingItemsOf: self defaultCatalog watchingTimeOn: self defaultClock! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AD 6/17/2018 17:52:15'!
defaultCatalog
	^ Dictionary new
	
			at: self itemSoldByTheStore
			put: self itemSoldByTheStorePrice;
		yourself.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AD 6/17/2018 19:40:44'!
defaultUserDatabase
	|userDatabase|
	
	userDatabase _ Dictionary new.
	userDatabase at: self validUsername put: self validPassword.
	userDatabase at: 'Thomas Smith' put: '5678'.
	
	^ userDatabase! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AD 6/17/2018 18:10:25'!
invalidCartID
	
	^ '47'! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AD 6/17/2018 17:48:35'!
defaultCreditCardNumber
	
	^ '1234567890123456'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AD 6/17/2018 17:49:51'!
expiredCreditCard
	^CreditCard number: self defaultCreditCardNumber 
					expiringOn: self pastExpirationDate
					ownedBy: 'John Doe'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AD 6/17/2018 17:49:47'!
notExpiredCreditCard
	
	^CreditCard number: self defaultCreditCardNumber 
					expiringOn: self futureExpirationDate
					ownedBy: 'John Doe'.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'AD 6/18/2018 13:36:45'!
initialize
	today _ DateAndTime now.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AD 6/17/2018 17:43:11'!
futureExpirationDate

	^ (GregorianMonthOfYear yearNumber: today yearNumber monthNumber: today monthIndex) next! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AD 6/17/2018 17:44:14'!
pastExpirationDate

	^ (GregorianMonthOfYear yearNumber: today yearNumber monthNumber: today monthIndex) previous! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'usernames and passwords' stamp: 'AD 6/17/2018 17:51:33'!
invalidPassword

	^ '4321'! !

!StoreTestObjectsFactory methodsFor: 'usernames and passwords' stamp: 'AD 6/17/2018 17:50:57'!
invalidUsername

	^ 'not John Doe'! !

!StoreTestObjectsFactory methodsFor: 'usernames and passwords' stamp: 'AD 6/17/2018 17:51:21'!
validPassword

	^ '1234'! !

!StoreTestObjectsFactory methodsFor: 'usernames and passwords' stamp: 'AD 6/17/2018 17:50:30'!
validUsername

	^ 'John Doe'! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'AD 6/18/2018 14:30:43'!
defaultInterfaceChargingThrough: aMerchantProcessor
	^ TusLibrosFacade
		with: self defaultUserDatabase
		acceptingItemsFrom: self defaultCatalog
		chargingThrough: aMerchantProcessor
		watchingTimeOn: self defaultClock.! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'AD 6/18/2018 14:36:33'!
defaultClock
	^ ManualClock new setTo: DateAndTime now.! !


!classDefinition: #TusLibrosFacade category: #TusLibros!
Object subclass: #TusLibrosFacade
	instanceVariableNames: 'userDatabase carts catalog merchantProcessor salesBook lastCartID clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosFacade methodsFor: 'initialization' stamp: 'AD 6/18/2018 11:18:38'!
initializeWith: userDataBase acceptingItemsFrom: aCatalog chargingThrough: aMerchantProcessor watchingTimeOn: aClock 

	
	userDatabase _ userDataBase.
	
	catalog _ aCatalog.
	
	merchantProcessor _ aMerchantProcessor.
	
	carts _ Dictionary new.
	
	salesBook _ OrderedCollection new.
	
	clock _ aClock.
	
	lastCartID _ 0.! !


!TusLibrosFacade methodsFor: 'operations' stamp: 'AD 6/18/2018 11:48:44'!
add: anAmount of: aBook to: aCartID
	| cart |	

	cart _ self cartFor: aCartID.

	cart add: anAmount of: aBook.
	
! !

!TusLibrosFacade methodsFor: 'operations' stamp: 'AD 6/18/2018 14:16:14'!
checkOutCart: cartID payingWithCard: creditCardNumber expiringOn: aMonthOfYear ownedBy: owner 
	
	| cart cashier creditCard sale transactionID |
	
	cart _ self cartFor: cartID.
	
	creditCard _ CreditCard number: creditCardNumber expiringOn: aMonthOfYear ownedBy: owner.
	
	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		throught: merchantProcessor
		on: clock date
		registeringOn: salesBook.
		
	sale _ cashier checkOut.
		
	transactionID _ sale hash.
	
		
	^ transactionID.! !

!TusLibrosFacade methodsFor: 'operations' stamp: 'AD 6/18/2018 11:27:21'!
createCartFor: aUser and: aPassword
	| cart cartID |
	self
		assertIsValid: aUser
		andMatches: aPassword.
	cart _ Cart
		for: aUser
		acceptingItemsOf: catalog
		watchingTimeOn: clock.
	cartID _ self nextCartID.
	carts
		at: cartID
		put: cart.
	^ cartID.! !

!TusLibrosFacade methodsFor: 'operations' stamp: 'AD 6/18/2018 11:48:57'!
listCart: aCartID

	| cart |
	cart _ self cartFor: aCartID.
	
	
	^ cart itemList.! !

!TusLibrosFacade methodsFor: 'operations' stamp: 'AD 6/17/2018 15:57:33'!
listPurchasesFor: aUsername with: aPassword 

	self assertIsValid: aUsername andMatches: aPassword.
	
	^ salesBook select: [:sale | sale buyer = aUsername].! !


!TusLibrosFacade methodsFor: 'assertions' stamp: 'AD 6/17/2018 14:46:43'!
assert: aPassword isCorrectFor: aUsername
	
	((userDatabase at: aUsername) = aPassword) ifFalse: [self error: self class invalidPasswordErrorMessage].! !

!TusLibrosFacade methodsFor: 'assertions' stamp: 'AD 6/17/2018 14:45:54'!
assertIsValid: aUsername
	
	(userDatabase keys includes: aUsername) ifFalse: [ self error: self class invalidUserMessageText.].! !

!TusLibrosFacade methodsFor: 'assertions' stamp: 'AD 6/17/2018 14:46:55'!
assertIsValid: aUsername andMatches: aPassword
	
	self assertIsValid: aUsername.
	self assert: aPassword isCorrectFor: aUsername.! !


!TusLibrosFacade methodsFor: 'private' stamp: 'AD 6/18/2018 11:20:55'!
cartFor: aCartID
	
	^ carts at: aCartID ifAbsent: [self error: self class invalidCartIDMessageText ].! !

!TusLibrosFacade methodsFor: 'private' stamp: 'AD 6/17/2018 22:16:35'!
nextCartID
	
	lastCartID _ lastCartID + 1.
	
	^lastCartID
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosFacade class' category: #TusLibros!
TusLibrosFacade class
	instanceVariableNames: ''!

!TusLibrosFacade class methodsFor: 'instance creation' stamp: 'AD 6/18/2018 11:13:48'!
with: userDatabase acceptingItemsFrom: catalog chargingThrough: merchantProcessor watchingTimeOn: aClock 

	^ self new initializeWith: userDatabase acceptingItemsFrom: catalog chargingThrough: merchantProcessor watchingTimeOn: aClock.
	! !


!TusLibrosFacade class methodsFor: 'error messages' stamp: 'AD 6/17/2018 21:30:30'!
cartExpiredErrorMessage

	^ 'Cart has expired due to 30 minutes of inactivity time'! !

!TusLibrosFacade class methodsFor: 'error messages' stamp: 'AD 6/17/2018 15:01:36'!
invalidCartIDMessageText
	
	^ 'Invalid cart ID.'! !

!TusLibrosFacade class methodsFor: 'error messages' stamp: 'AD 6/14/2018 20:35:37'!
invalidPasswordErrorMessage
	
	^ 'Invalid password.'! !

!TusLibrosFacade class methodsFor: 'error messages' stamp: 'AD 6/14/2018 20:32:22'!
invalidUserMessageText
	
	^ 'Invalid Username'! !
