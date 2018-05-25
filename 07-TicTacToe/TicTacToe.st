!classDefinition: #TicTacToeTest category: #TicTacToeStep1!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 19:10:48'!
test01

	|game|
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 19:20:02'!
test02

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 19:36:58'!
test03

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self assert: 1 equals: game Os size.
	self assert: (game Os includes: 2@2).
	self assert: 1 equals: game Xs size.
	self assert: (game Xs includes: 1@1).! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 19:34:03'!
test04

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		
		self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty.		
		].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 19:35:56'!
test05

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self
	should: [game putOAt: 3@3]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		
		self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: 1 equals: game Os size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Os includes: 2@2).
		self deny: (game Os includes: 3@3).		
		].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 20:15:41'!
test06

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.	
		].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 19:58:00'!
test07

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self
	should: [game putXAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).	
		self deny: (game Xs includes: 2@2).		
		].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 20:02:51'!
test08

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	
	self
	should: [game putOAt: 1@1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 1 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: game Os isEmpty .
		].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 20:16:39'!
test09

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	
	self
	should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		
		self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
		self assert: 2 equals: game Xs size.
		self assert: (game Xs includes: 1@1).
		self assert: (game Xs includes: 3@3).
		self assert: 1 equals: game Os size.
		self assert: (game Os includes: 2@2).		
		].
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 20:35:40'!
test10

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 2@3.	
	
	self deny: game OHasWon.
	self deny: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 20:34:50'!
test11

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.	
	
	self deny: game OHasWon.
	self assert: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 20:36:10'!
test12

	|game|
	game := TicTacToe new.
	
	game putXAt: 2@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 3@3.
	game putXAt: 2@3.	
	
	self deny: game OHasWon.
	self assert: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 20:36:30'!
test13

	|game|
	game := TicTacToe new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 2@3.
	game putXAt: 3@3.	
	
	self deny: game OHasWon.
	self assert: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 21:01:31'!
test14

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.	
	
	self deny: game OHasWon.
	self assert: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 21:02:11'!
test15

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 1@3.
	game putXAt: 3@3.	
	
	self deny: game OHasWon.
	self assert: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 21:18:53'!
test16

	|game|
	game := TicTacToe new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	game putOAt: 1@3.	
	
	self assert: game OHasWon.
	self deny: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 21:20:58'!
test17

	|game|
	game := TicTacToe new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	game putOAt: 1@3.	
	
	self assert: game OHasWon.
	self deny: game XHasWon.
! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 21:26:02'!
test18

	|game|
	game := TicTacToe new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 3@1.
	game putXAt: 1@3.

	self should: [game putOAt: 2@2]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
		self assert: 2 equals: game Os size.
		self assert: (game Os includes: 2@1).
		self assert: (game Os includes: 3@1).
		].
		! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 21:44:55'!
test20

	|game|
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game putXAt: 1@2.
	game putOAt: 3@2.
	game putXAt: 3@3.

	self assert: game isOver.
	self deny: game XHasWon .
	self deny: game OHasWon .
	self assert: game isTied.
	! !

!TicTacToeTest methodsFor: 'as yet unclassified' stamp: 'AD 5/24/2018 21:45:29'!
test21

	|game|
	game := TicTacToe new.
	
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	game putXAt: 3@3.

	self assert: game isOver.
	self assert: game XHasWon .
	self deny: game OHasWon .
	self deny: game isTied.
	! !


!classDefinition: #TicTacToe category: #TicTacToeStep1!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs turn winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!TicTacToe methodsFor: 'initialization' stamp: 'AD 5/24/2018 19:17:27'!
Os

	^ os copy
! !

!TicTacToe methodsFor: 'initialization' stamp: 'AD 5/24/2018 19:17:19'!
Xs

	^ xs copy
! !

!TicTacToe methodsFor: 'initialization' stamp: 'AD 5/24/2018 19:42:00'!
initialize

	xs := Set new.
	os := Set new.
	turn := #x
! !


!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 20:32:36'!
OHasWon
	
	^ winner = #o! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 20:32:50'!
XHasWon
	
	^ winner = #x! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:03:09'!
hasCompletedColumn: aSetOfPositions
		
		^ (1 to: 3) anySatisfy: [:y | (aSetOfPositions count:  [:posicion | posicion y=y]) = 3]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:17:54'!
hasCompletedDiagonal: aSetOfPositions
		
		^ ((aSetOfPositions includes: 1@1) and: (aSetOfPositions includes: 2@2) and: (aSetOfPositions includes: 3@3))
			or: ((aSetOfPositions includes: 3@1) and: (aSetOfPositions includes: 2@2) and: (aSetOfPositions includes: 1@3)).
			
			"^(1 to: 3) allSatisfy: [self]"! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:19:48'!
hasCompletedDownDiagonal: positions
	
	^(1 to: 3) allSatisfy: [:n | positions includes: n@n]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 20:59:21'!
hasCompletedRow: aSetOfPositions
		
		^ (1 to: 3) anySatisfy: [:x | (aSetOfPositions count:  [:posicion | posicion x=x]) = 3]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:30:27'!
hasCompletedUpDiagonal: positions
	
	^ (positions includes: 2@2) and: (positions includes: 1@3) and: (positions includes: 3@1).! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:29:34'!
hasWin: positions
		
		^ (self hasCompletedRow: positions) or: (self hasCompletedColumn: positions) or: (self hasCompletedDownDiagonal: positions) or: (self hasCompletedDownDiagonal: positions).! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:31:22'!
isGameOver
	
	^ winner = #x or: [winner = #o]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:35:45'!
isOver
	
	^ (self isGameOver) or: [self isTied].! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:39:51'!
isTied
	
	^ xs size = 5 and: [os size = 4 and: [self XHasWon not]]! !


!TicTacToe methodsFor: 'game' stamp: 'AD 5/24/2018 21:42:34'!
putOAt: aPosition
	
	self checkIsTurnOfO.
	self checkIsOccupied: aPosition.
	(self isOver ) ifTrue: [self error: self class canNotPlayWhenGameIsOverErrorMessage].
	os add: aPosition.
	(self hasWin: os) ifTrue: [winner := #o].
	turn := #x
	! !

!TicTacToe methodsFor: 'game' stamp: 'AD 5/24/2018 21:42:28'!
putXAt: aPosition
	
	self checkIsTurnOfX.
	self checkIsOccupied: aPosition.
	(self isOver ) ifTrue: [self error: self class canNotPlayWhenGameIsOverErrorMessage].
	xs add: aPosition.
	(self hasWin: xs) ifTrue: [winner := #x].
	turn := #o.! !


!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/24/2018 20:09:19'!
checkIsOccupied: aPosition

	((xs includes: aPosition ) or: (os includes: aPosition)) ifTrue: [^ self error: self class positionTakenErrorMessage].! !

!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/24/2018 20:13:23'!
checkIsTurnOfO

	(turn = #o) ifFalse: [^ self error: self class notOTurnErrorMessage ].

! !

!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/24/2018 20:12:02'!
checkIsTurnOfX

	(turn = #x) ifFalse: [^ self error: self class notXTurnErrorMessage ].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToeStep1!
TicTacToe class
	instanceVariableNames: ''!


!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/24/2018 21:26:33'!
canNotPlayWhenGameIsOverErrorMessage

	^ 'the game has finished'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/24/2018 19:46:55'!
notOTurnErrorMessage

	^ 'Is not O turn'.! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/24/2018 19:46:49'!
notXTurnErrorMessage

	^ 'Is not X turn'.! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/24/2018 19:58:58'!
positionTakenErrorMessage

	^ 'Positon already taken'! !
