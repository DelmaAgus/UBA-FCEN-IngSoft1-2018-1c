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

!OOStack methodsFor: 'testing' stamp: 'AD 4/26/2018 16:21:35'!
isEmpty

	^ (length = 0)! !


!OOStack methodsFor: 'accesing' stamp: 'AD 4/26/2018 16:53:49'!
pop
	| pieceOnTop |
	pieceOnTop _ topPiece.
	topPiece _ topPiece pieceBelow.
	length _ length - 1.
	^ pieceOnTop value.! !

!OOStack methodsFor: 'accesing' stamp: 'AD 4/26/2018 16:55:30'!
push: aValueToPush
	topPiece _ OOStackDisk
		withValue: aValueToPush
		over: topPiece.
	length _ length + 1.! !

!OOStack methodsFor: 'accesing' stamp: 'AD 4/26/2018 16:35:51'!
size

	^ length! !

!OOStack methodsFor: 'accesing' stamp: 'AD 4/26/2018 16:53:49'!
top
	^ topPiece value.! !


!OOStack methodsFor: 'initialization' stamp: 'AD 4/26/2018 16:34:38'!
initialize
	length _ 0.
	topPiece _ OOStackBase new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackPiece category: #'Stack-Exercise'!
Object subclass: #OOStackPiece
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackPiece methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:18:00'!
pieceBelow

	^ self subclassResponsibility.! !

!OOStackPiece methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:53:49'!
value
	^ self subclassResponsibility.! !


!classDefinition: #OOStackDisk category: #'Stack-Exercise'!
OOStackPiece subclass: #OOStackDisk
	instanceVariableNames: 'pieceBelow value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackDisk methodsFor: 'initialization' stamp: 'AD 4/26/2018 16:54:44'!
withValue: aValue over: aStackPiece
	pieceBelow _ aStackPiece.
	value _ aValue.! !


!OOStackDisk methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:17:03'!
pieceBelow

	^ pieceBelow.! !

!OOStackDisk methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:54:30'!
value
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackDisk class' category: #'Stack-Exercise'!
OOStackDisk class
	instanceVariableNames: ''!

!OOStackDisk class methodsFor: 'initialization' stamp: 'AD 4/26/2018 16:54:12'!
withValue: aContent over: aStackPiece
	^ self new
		withValue: aContent
		over: aStackPiece.! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
OOStackPiece subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:47:54'!
pieceBelow

	self signalStackIsEmpty ! !

!OOStackBase methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:53:49'!
value
	self signalStackIsEmpty.! !


!OOStackBase methodsFor: 'error signals' stamp: 'AD 4/26/2018 16:47:42'!
signalStackIsEmpty

	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStackDisk category: #'Stack-Exercise'!
OOStackPiece subclass: #OOStackDisk
	instanceVariableNames: 'pieceBelow value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackDisk methodsFor: 'initialization' stamp: 'AD 4/26/2018 16:54:44'!
withValue: aValue over: aStackPiece
	pieceBelow _ aStackPiece.
	value _ aValue.! !


!OOStackDisk methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:17:03'!
pieceBelow

	^ pieceBelow.! !

!OOStackDisk methodsFor: 'accessing' stamp: 'AD 4/26/2018 16:54:30'!
value
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackDisk class' category: #'Stack-Exercise'!
OOStackDisk class
	instanceVariableNames: ''!

!OOStackDisk class methodsFor: 'initialization' stamp: 'AD 4/26/2018 16:54:12'!
withValue: aContent over: aStackPiece
	^ self new
		withValue: aContent
		over: aStackPiece.! !
