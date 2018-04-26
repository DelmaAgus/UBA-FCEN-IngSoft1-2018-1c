!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'length topPiece'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'AD 4/23/2018 16:27:19'!
isEmpty
	^(length = 0)! !


!OOStack methodsFor: 'accesing' stamp: 'AD 4/26/2018 12:05:07'!
pop

	|actualTopContent|
	actualTopContent := self top.
	
	topPiece := topPiece belowStackPiece.
	length := length -1.
	
	^actualTopContent
! !

!OOStack methodsFor: 'accesing' stamp: 'AD 4/26/2018 15:11:50'!
push: aContent
	topPiece _ OOStackDisk
		stackContent: aContent
		over: topPiece.
	length _ length + 1.! !

!OOStack methodsFor: 'accesing' stamp: 'AD 4/23/2018 10:32:35'!
size

	^length! !

!OOStack methodsFor: 'accesing' stamp: 'AD 4/26/2018 15:15:34'!
top

	^topPiece pieceContent.! !


!OOStack methodsFor: 'initialization' stamp: 'AD 4/26/2018 12:04:26'!
initialize

	length := 0.
	topPiece := OOStackBase new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
OOStackPiece subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accessing' stamp: 'AD 4/26/2018 15:07:30'!
belowStackPiece

	^self error: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'accessing' stamp: 'AD 4/26/2018 15:13:16'!
pieceContent

	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackDisk category: #'Stack-Exercise'!
OOStackPiece subclass: #OOStackDisk
	instanceVariableNames: 'pieceBelow content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackDisk methodsFor: 'initialization' stamp: 'AD 4/26/2018 15:06:30'!
stackContent: aContent over: aStackPiece
	
	pieceBelow := aStackPiece.
	content := aContent
	
	


	! !


!OOStackDisk methodsFor: 'accessing' stamp: 'AD 4/26/2018 14:13:47'!
belowStackPiece

	^pieceBelow! !

!OOStackDisk methodsFor: 'accessing' stamp: 'AD 4/26/2018 14:03:58'!
pieceContent

	^content! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackDisk class' category: #'Stack-Exercise'!
OOStackDisk class
	instanceVariableNames: ''!

!OOStackDisk class methodsFor: 'initialization' stamp: 'AD 4/26/2018 14:13:05'!
stackContent: aContent over: aStackPiece

	^self new stackContent: aContent over: aStackPiece! !


!classDefinition: #OOStackPiece category: #'Stack-Exercise'!
Object subclass: #OOStackPiece
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackPiece methodsFor: 'accessing' stamp: 'AD 4/26/2018 15:10:42'!
belowStackPiece

	^self subclassResponsibility! !

!OOStackPiece methodsFor: 'accessing' stamp: 'AD 4/26/2018 15:19:07'!
pieceContent

	^self subclassResponsibility ! !
