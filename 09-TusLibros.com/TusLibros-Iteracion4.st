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


!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:08:55'!
test01CanNotCreateACartWithAnInvalidUsername

	| restInterface invalidUsername password |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	invalidUsername _ testObjectsFactory invalidUsername.
	password _  testObjectsFactory validPassword.
	
	self should: [	restInterface createCartFor: invalidUsername and: password ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: restInterface class invalidUserMessageText ].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:08:59'!
test02CanNotCreateACartWithAnInvalidPassword

	| restInterface username invalidPassword |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	invalidPassword _ testObjectsFactory invalidPassword.
	
	self should: [ restInterface createCartFor: username	and: invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText	equals: restInterface class invalidPasswordErrorMessage
		].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:09:03'!
test03ACartIsCreatedEmpty

	| restInterface username password cartID itemsList |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ restInterface createCartFor: username and: password.
	itemsList _ restInterface listCart: cartID.
	
	self assert: itemsList isEmpty.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:09:06'!
test04CartRegistersItemsAdded

	| restInterface username password cartID itemsList book |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ restInterface createCartFor: username and: password.
	book _ testObjectsFactory itemSoldByTheStore.
	
	restInterface add: 1 of: book to: cartID.
	itemsList _ restInterface listCart: cartID.
	
	self deny: itemsList isEmpty.
	self assert: (itemsList at: book) equals: 1.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:10:54'!
test05CanNotAddProductsToAnInexistentCart

	| restInterface invalidCartID book |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	book _ testObjectsFactory itemSoldByTheStore.
	
	invalidCartID _ testObjectsFactory invalidCartID.	
	
	self should:  [ restInterface add: 1 of: book to: invalidCartID. ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: restInterface class invalidCartIDMessageText.
		].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:09:12'!
test06CanNotListPurchasesForAnInvalidUsername

	| restInterface invalidUsername password |
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	invalidUsername _ testObjectsFactory invalidUsername.
	password _  testObjectsFactory validPassword.
	self should:  [ restInterface listPurchasesFor: invalidUsername with: password.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: restInterface class invalidUserMessageText.
		].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:09:16'!
test07CanNotListPurchasesWithAnInvalidPassword

	| restInterface username invalidPassword |	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	username _ testObjectsFactory validUsername.
	invalidPassword _ testObjectsFactory invalidPassword.
	self should:  [restInterface listPurchasesFor: username with: invalidPassword.]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [: anError |
			self assert: anError messageText equals: restInterface class invalidPasswordErrorMessage.
		].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:09:21'!
test08AUserThatDidntBuyAnythingHasNoPurchasesRegistered

	| restInterface username password purchasesList |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	purchasesList _ restInterface listPurchasesFor: username with: password.
	
	self assert: purchasesList isEmpty.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:10:37'!
test09CanNotCheckOutAnInexistentCart

	| restInterface invalidCartID |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	invalidCartID _ testObjectsFactory invalidCartID.	
	
	self should:  [ restInterface checkOutCart: invalidCartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Juan'.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: restInterface class invalidCartIDMessageText.
		].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 19:48:52'!
test10AClientPurchasesAreRegisteredCorrectly

	| restInterface username password cartID book listOfPurchases |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ restInterface createCartFor: username and: password.
	
	book _ testObjectsFactory itemSoldByTheStore.
	restInterface add: 1 of: book to: cartID.
	
	restInterface checkOutCart: cartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Juan'.
	listOfPurchases _ restInterface listPurchasesFor: username with: password.
	
	self assert: listOfPurchases size = 1.
	self assert: (listOfPurchases at: 1) totalItemsSold equals: 1.
	self assert: (listOfPurchases at: 1) total equals: testObjectsFactory itemSoldByTheStorePrice.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 18:10:10'!
test11CanNotListAnInexistentCart

	| restInterface invalidCartID |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	
	invalidCartID _ testObjectsFactory invalidCartID.	
	
	self should:  [ restInterface listCart: invalidCartID.]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [: anError |
			self assert: anError messageText equals: restInterface class invalidCartIDMessageText.
		].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 20:07:43'!
test12MultipleClientsPurchasesAreRegisteredCorrectly

	| restInterface book johnDoeCartID johnDoePassword johnDoeUsername johnDoeListOfPurchases thomasSmithCartID thomasSmithListOfPurchases thomasSmithPassword thomasSmithUsername |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	book _ testObjectsFactory itemSoldByTheStore.
	
	johnDoeUsername _ testObjectsFactory validUsername.
	johnDoePassword _ testObjectsFactory validPassword.
	
	johnDoeCartID _ restInterface createCartFor: johnDoeUsername and: johnDoePassword.
	

	restInterface add: 1 of: book to: johnDoeCartID.
	
	restInterface checkOutCart: johnDoeCartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'John Doe'.
	johnDoeListOfPurchases _ restInterface listPurchasesFor: johnDoeUsername with: johnDoePassword.
	
	thomasSmithUsername _ 'Thomas Smith'.
	thomasSmithPassword _ '5678'.
	
	thomasSmithCartID _ restInterface createCartFor: thomasSmithUsername and: thomasSmithPassword.
	

	restInterface add: 10 of: book to: thomasSmithCartID.
	
	restInterface checkOutCart: thomasSmithCartID payingWithCard: testObjectsFactory defaultCreditCardNumber expiringOn: testObjectsFactory futureExpirationDate ownedBy: 'Thomas Smith'.
	thomasSmithListOfPurchases _ restInterface listPurchasesFor: thomasSmithUsername with: thomasSmithPassword.

	self assert: (johnDoeCartID = thomasSmithCartID) not.
	
	self assert: johnDoeListOfPurchases size = 1.
	self assert: (johnDoeListOfPurchases at: 1) totalItemsSold equals: 1.
	self assert: (johnDoeListOfPurchases at: 1) total equals: testObjectsFactory itemSoldByTheStorePrice.
	
	self assert: thomasSmithListOfPurchases size = 1.
	self assert: (thomasSmithListOfPurchases at: 1) totalItemsSold equals: 10.
	self assert: (thomasSmithListOfPurchases at: 1) total equals:  testObjectsFactory itemSoldByTheStorePrice * 10.
	
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'AD 6/17/2018 23:11:43'!
test13ACartCantBeUsedAfter30MinutesOfInactivity

	| restInterface username password cartID book |
	
	restInterface _ testObjectsFactory defaultInterfaceChargingThrough: self.
	book _ testObjectsFactory itemSoldByTheStore.
	
	username _ testObjectsFactory validUsername.
	password _ testObjectsFactory validPassword.
	
	cartID _ restInterface createCartFor: username and: password.

	
	"Pasan 60 minutos ..............."
	restInterface updateLastUseOf: cartID to: testObjectsFactory anHourAgo.
	
	
	self should: [	restInterface add: 1 of: book to: cartID.] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError|
			self assert: anError messageText equals: restInterface class cartExpiredErrorMessage.
		].
	

	
	
! !


!RestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'AD 6/17/2018 15:37:16'!
debit: anAmount from: aCreditCard 
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items owner'
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


!Cart methodsFor: 'initialization' stamp: 'AD 6/17/2018 16:51:07'!
initializeFor: anOwner acceptingItemsOf: aCatalog 
		
	owner _ anOwner.
		
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

!Cart methodsFor: 'listing' stamp: 'AD 6/17/2018 17:02:50'!
itemListRaw		
	^ items copy.! !


!Cart methodsFor: 'accessing' stamp: 'AD 6/17/2018 17:00:06'!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AD 6/17/2018 16:51:47'!
for: aClient acceptingItemsOf: aCatalog 
	
	^ self new initializeFor: aClient acceptingItemsOf: aCatalog ! !


!classDefinition: #CartSystemInfo category: #TusLibros!
Object subclass: #CartSystemInfo
	instanceVariableNames: 'cart lastTimeUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSystemInfo methodsFor: 'update' stamp: 'AD 6/17/2018 22:43:26'!
updateLastTimeUsedTo: aTime

	lastTimeUsed _ aTime! !


!CartSystemInfo methodsFor: 'accesing' stamp: 'AD 6/17/2018 22:41:03'!
cart

	^ cart! !

!CartSystemInfo methodsFor: 'accesing' stamp: 'AD 6/17/2018 22:41:14'!
lastTimeUsed

	^ lastTimeUsed! !


!CartSystemInfo methodsFor: 'initialization' stamp: 'AD 6/17/2018 22:40:31'!
initializeFor: aCart On: aTime

	cart _ aCart.
	lastTimeUsed _ aTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSystemInfo class' category: #TusLibros!
CartSystemInfo class
	instanceVariableNames: ''!

!CartSystemInfo class methodsFor: 'instance creation' stamp: 'AD 6/17/2018 22:38:37'!
for: aCart on: aTime

	^ self new initializeFor: aCart On: aTime! !


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


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'userDatabase carts catalog merchantProcessor salesBook lastCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'AD 6/17/2018 22:49:14'!
initializeWith: userDataBase acceptingItemsFrom: aCatalog chargingThrough: aMerchantProcessor 
	
	userDatabase _ userDataBase.
	
	catalog _ aCatalog.
	
	merchantProcessor _ aMerchantProcessor.
	
	carts _ Dictionary new.
	
	salesBook _ OrderedCollection new.
	
	lastCartID _ 0.
	

	! !


!RestInterface methodsFor: 'operations' stamp: 'AD 6/17/2018 22:57:40'!
add: anAmount of: aBook to: aCartID
	| cart |	

	cart _ self cartFor: aCartID.
	self assertHasNotExpired: aCartID.
	cart add: anAmount of: aBook.
	
	self updateLastUseOf: aCartID to: self now.! !

!RestInterface methodsFor: 'operations' stamp: 'AD 6/17/2018 22:57:52'!
checkOutCart: cartID payingWithCard: creditCardNumber expiringOn: aMonthOfYear ownedBy: owner 
	
	| cart cashier creditCard sale transactionID |
	
	cart _ self cartFor: cartID.
	self assertHasNotExpired: cartID.
	
	creditCard _ CreditCard number: creditCardNumber expiringOn: aMonthOfYear ownedBy: owner.
	
	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		throught: merchantProcessor
		on: self today
		registeringOn: salesBook.
		
	sale _ cashier checkOut.
	
	self updateLastUseOf: cartID to: self now..
		
	transactionID _ sale hash.
	
		
	^ transactionID.! !

!RestInterface methodsFor: 'operations' stamp: 'AD 6/17/2018 22:47:20'!
createCartFor: aUser and: aPassword

	| cart cartID cartSystemInfo |
	
	self assertIsValid: aUser andMatches: aPassword.
	
	cart _ Cart for: aUser acceptingItemsOf: catalog.
	
	cartID _ self nextCartID .
	
	cartSystemInfo _ CartSystemInfo for: cart on: self now.
	
	carts at: cartID put: cartSystemInfo.
	
	^ cartID.! !

!RestInterface methodsFor: 'operations' stamp: 'AD 6/17/2018 22:58:01'!
listCart: aCartID

	| cart |
	cart _ self cartFor: aCartID.
	
	self assertHasNotExpired: aCartID.
	
	self updateLastUseOf: aCartID  to: self now.

	^ cart itemList.! !

!RestInterface methodsFor: 'operations' stamp: 'AD 6/17/2018 15:57:33'!
listPurchasesFor: aUsername with: aPassword 

	self assertIsValid: aUsername andMatches: aPassword.
	
	^ salesBook select: [:sale | sale buyer = aUsername].! !


!RestInterface methodsFor: 'assertions' stamp: 'AD 6/17/2018 14:46:43'!
assert: aPassword isCorrectFor: aUsername
	
	((userDatabase at: aUsername) = aPassword) ifFalse: [self error: self class invalidPasswordErrorMessage].! !

!RestInterface methodsFor: 'assertions' stamp: 'AD 6/17/2018 23:06:22'!
assertHasNotExpired: aCartID
	
	 (self hasNotBeenUsed: aCartID forMinutes: 30) ifTrue: [self error: self class cartExpiredErrorMessage].! !

!RestInterface methodsFor: 'assertions' stamp: 'AD 6/17/2018 14:45:54'!
assertIsValid: aUsername
	
	(userDatabase keys includes: aUsername) ifFalse: [ self error: self class invalidUserMessageText.].! !

!RestInterface methodsFor: 'assertions' stamp: 'AD 6/17/2018 14:46:55'!
assertIsValid: aUsername andMatches: aPassword
	
	self assertIsValid: aUsername.
	self assert: aPassword isCorrectFor: aUsername.! !


!RestInterface methodsFor: 'time' stamp: 'AD 6/17/2018 20:18:34'!
now

	^ DateAndTime now.! !

!RestInterface methodsFor: 'time' stamp: 'AD 6/17/2018 20:16:23'!
today

	^ Date today.! !

!RestInterface methodsFor: 'time' stamp: 'AD 6/17/2018 22:57:01'!
updateLastUseOf: aCartID to: aTime

	| cartSystemInfo |
	cartSystemInfo _ carts at: aCartID.

	cartSystemInfo updateLastTimeUsedTo: aTime.! !


!RestInterface methodsFor: 'private' stamp: 'AD 6/17/2018 22:50:20'!
cartFor: aCartID
	
	| cartSystemInfo |
	cartSystemInfo _ carts at: aCartID ifAbsent: [self error: self class invalidCartIDMessageText ].
	^ cartSystemInfo cart.! !

!RestInterface methodsFor: 'private' stamp: 'AD 6/17/2018 22:16:35'!
nextCartID
	
	lastCartID _ lastCartID + 1.
	
	^lastCartID
	
	
	! !


!RestInterface methodsFor: 'testing' stamp: 'AD 6/17/2018 23:11:21'!
hasNotBeenUsed: aCartID forMinutes: anAmountOfMinutes

	| cartSystemInfo |
	
	cartSystemInfo _ carts at: aCartID.

	^ (self now - (cartSystemInfo lastTimeUsed))  totalMinutes > anAmountOfMinutes.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'AD 6/17/2018 15:34:42'!
with: userDatabase acceptingItemsFrom: catalog chargingThrough: merchantProcessor 
	
	^ self new initializeWith: userDatabase acceptingItemsFrom: catalog chargingThrough: merchantProcessor! !


!RestInterface class methodsFor: 'error messages' stamp: 'AD 6/17/2018 21:30:30'!
cartExpiredErrorMessage

	^ 'Cart has expired due to 30 minutes of inactivity time'! !

!RestInterface class methodsFor: 'error messages' stamp: 'AD 6/17/2018 15:01:36'!
invalidCartIDMessageText
	
	^ 'Invalid cart ID.'! !

!RestInterface class methodsFor: 'error messages' stamp: 'AD 6/14/2018 20:35:37'!
invalidPasswordErrorMessage
	
	^ 'Invalid password.'! !

!RestInterface class methodsFor: 'error messages' stamp: 'AD 6/14/2018 20:32:22'!
invalidUserMessageText
	
	^ 'Invalid Username'! !


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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AD 6/17/2018 17:04:13'!
createCart
	
	^Cart for: 'SomeClient' acceptingItemsOf: self defaultCatalog! !

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


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AD 6/17/2018 23:00:20'!
anHourAgo
	
	^ DateAndTime now - 60 minutes.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AD 6/17/2018 17:43:11'!
futureExpirationDate

	^ (GregorianMonthOfYear yearNumber: today yearNumber monthNumber: today monthIndex) next! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'AD 6/17/2018 22:34:43'!
now
	
	^ DateAndTime now.! !

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


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AD 6/17/2018 18:08:12'!
defaultInterfaceChargingThrough: aMerchantProcessor 
 
	^ RestInterface with: self defaultUserDatabase
						  acceptingItemsFrom: self defaultCatalog
						  chargingThrough: aMerchantProcessor.
	! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'AD 6/17/2018 18:10:25'!
invalidCartID
	
	^ '47'! !
