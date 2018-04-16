!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'assertions' stamp: 'AD 4/16/2018 09:53:51'!
assert: aConditionalBlock and: anotherConditionalBlock 

	self assert: aConditionalBlock .
	self assert: anotherConditionalBlock! !

!IdiomTest methodsFor: 'assertions' stamp: 'AD 4/16/2018 09:52:51'!
assert: aBlockToMeasureTime doesntTakeMoreThanMilisecondsToRun: anAmountOfMiliseconds
	
	self assert: (aBlockToMeasureTime durationToRun totalMilliseconds ) < anAmountOfMiliseconds! !

!IdiomTest methodsFor: 'assertions' stamp: 'AD 4/13/2018 19:23:51'!
fail: aBlockToFail on: anError do: aBlockToDo  
		
	[ aBlockToFail value.
	self fail ]
		on: anError 
		do: [ :anErr | aBlockToDo value: anErr ]! !


!IdiomTest methodsFor: 'testing' stamp: 'AD 4/16/2018 09:55:46'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	| customerBook|
	customerBook := CustomerBook  new.
	self assert: [customerBook addCustomerNamed: 'John Lennon'.]
				doesntTakeMoreThanMilisecondsToRun: 50
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'AD 4/16/2018 09:55:39'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	| customerBook paulMcCartney|
	customerBook := CustomerBook  new.
	
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: [customerBook removeCustomerNamed: paulMcCartney.]
				doesntTakeMoreThanMilisecondsToRun: 100
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'AD 4/16/2018 09:54:12'!
test03CanNotAddACustomerWithEmptyName 
		
	| customerBook |		
	customerBook := CustomerBook new.
		
	self fail: [customerBook addCustomerNamed: ''.]
		 on: Error 
		 do: [:anError | 
			self assert: [
				anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.] 
				and: [customerBook isEmpty]
			]! !

!IdiomTest methodsFor: 'testing' stamp: 'AD 4/16/2018 09:54:18'!
test04CanNotRemoveAnInvalidCustomer
			
	| customerBook johnLennon|
			
	customerBook := CustomerBook new.
	
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self fail: [customerBook removeCustomerNamed: 'Paul McCartney'.] 
		on: NotFound 
		do: [:anError | 
				self assert:  [ customerBook numberOfCustomers = 1.] 
				and:[customerBook includesCustomerNamed: johnLennon]
			] 
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
