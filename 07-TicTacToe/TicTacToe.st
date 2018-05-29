!classDefinition: #TicTacToeTest category: #TicTacToeStep1!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 18:52:40'!
test01ANewGameIsEmpty

	|game|
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 21:19:46'!
test02WhenAPositionIsMarkedWithXItsAddedToTheGame
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	self
		assert: 1
		equals: game Xs size.
	self assert: (game hasPlayerXMarkedAt: 1 @ 1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 21:20:15'!
test03APositionCanBeMarkedWithOCorrectlyAfterMarkingAnX
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	self
		assert: 1
		equals: game Os size.
	self assert: (game hasPlayerOMarkedAt: 2 @ 2).
	self
		assert: 1
		equals: game Xs size.
	self assert: (game hasPlayerXMarkedAt: 1 @ 1).! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 21:20:31'!
test04APlayerCantMarkTwiceInARow
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe playerCantMarkTwiceErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game hasPlayerXMarkedAt: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 21:10:40'!
test05CanNotMarkAnInvalidPosition

	| game |
	
	game _ TicTacToe new.
		
	self
		should: [ game markWithXAt: 0 @ 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe invalidPositionErrorMessage equals: anError messageText.
			self assert: game Xs isEmpty ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 21:20:50'!
test06CantMarkAPositionThatIsOccupied
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game hasPlayerXMarkedAt: 1 @ 1).
			self
				assert: 1
				equals: game Os size ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 19:41:44'!
test10AnUnfinishedMatchHasNoWinner
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 2 @ 3.
	self deny: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 19:41:43'!
test11APlayerWinsWhenHasCompletedARow
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 1 @ 3.
	self deny: game hasPlayerOWon.
	self assert: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 19:41:44'!
test14APlayerWinsWhenHasCompletedAColumn
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 3 @ 1.
	self deny: game hasPlayerOWon.
	self assert: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 19:41:44'!
test15APlayerWinsWhenHasCompletedTheDownDiagonal
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 3.
	game markWithXAt: 3 @ 3.
	self deny: game hasPlayerOWon.
	self assert: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 19:41:44'!
test16APlayerWinsWhenHasCompletedTheUpDiagonal
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 1 @ 3.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 21:21:20'!
test18CanNotPlayWhenGameIsOver
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 1 @ 3.
	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assert: 2
				equals: game Os size.
			self assert: (game hasPlayerOMarkedAt: 2 @ 1).
			self assert: (game hasPlayerOMarkedAt: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 19:41:44'!
test20AGameEndsAsTiedWhenThereAreNoAvailablePositionsAndThereIsNoWinner
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 2.
	game markWithXAt: 3 @ 3.
	self assert: game isGameOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isGameTied.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/28/2018 19:41:44'!
test21APlayerCanWinWhenThereIsOnlyOnePositionAvailable
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 3 @ 3.
	self assert: game isGameOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isGameTied.! !


!classDefinition: #TicTacToe category: #TicTacToeStep1!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs winner state'
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

!TicTacToe methodsFor: 'initialization' stamp: 'AD 5/28/2018 21:10:12'!
initialize

	xs := Set new.
	os := Set new.
	state := PlayerXTurn for: self.
! !


!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 20:50:28'!
hasCompletedColumn: aPlayersMarkedPositions
		
		^ (1 to: 3) anySatisfy: [:y | (aPlayersMarkedPositions count:  [:position | position y = y]) = 3]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/24/2018 21:19:48'!
hasCompletedDownDiagonal: positions
	
	^(1 to: 3) allSatisfy: [:n | positions includes: n@n]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 20:51:28'!
hasCompletedRow: aPlayersMarkedPositions
		
		^ (1 to: 3) anySatisfy: [:x | (aPlayersMarkedPositions count:  [:position | position x = x]) = 3]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/27/2018 23:13:24'!
hasCompletedUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 21:19:03'!
hasPlayerOMarkedAt: aPosition

	^ os includes: aPosition.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 20:53:43'!
hasPlayerOWon
	^ self hasWinningPositions: os.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 21:19:20'!
hasPlayerXMarkedAt: aPosition

	^ xs includes: aPosition.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 20:53:43'!
hasPlayerXWon
	^ self hasWinningPositions: xs.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 19:42:39'!
isGameOver
	^ self isThereWinner or: [self isGameTied ].! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 19:42:50'!
isGameTied

	^ xs size = 5 and: [
		os size = 4 and: [ self hasPlayerXWon not ]].! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 19:42:19'!
isThereWinner

	^ self hasPlayerXWon or: [ self hasPlayerOWon ].! !


!TicTacToe methodsFor: 'game' stamp: 'AD 5/28/2018 20:38:55'!
markWithOAt: aPosition

	state markWithOAt: aPosition .
"
	self assertGameIsNotOver.
	self assertIsPlayerOTurn.
	self assertIsAvailable: aPosition.
	os add: aPosition.
	(self hasWon: os) ifTrue: [ winner _ #o ].
	turn _ #x.
"! !

!TicTacToe methodsFor: 'game' stamp: 'AD 5/28/2018 20:59:30'!
markWithXAt: aPosition

	self assertIsValidPosition: aPosition.

	state markWithXAt: aPosition.! !


!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/28/2018 19:34:06'!
assertGameIsNotOver

	self isGameOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].! !

!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/28/2018 19:29:29'!
assertIsAvailable: aPosition

	((xs includes: aPosition) or: (os includes: aPosition)) ifTrue: [ ^ self error: self class positionTakenErrorMessage ].! !

!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/28/2018 21:06:20'!
assertIsValidPosition: aPosition 
	
	(aPosition between: 1@1 and: 3@3) ifFalse: [self error: self class invalidPositionErrorMessage ] ! !


!TicTacToe methodsFor: 'private' stamp: 'AD 5/28/2018 20:43:30'!
safeMarkWithOAt: aPosition 
	
	os add: aPosition.
	
	state _ PlayerXTurn for: self.! !

!TicTacToe methodsFor: 'private' stamp: 'AD 5/28/2018 20:41:12'!
safeMarkWithXAt: aPosition 
	
	xs add: aPosition.
	
	state _ PlayerOTurn for: self.! !


!TicTacToe methodsFor: 'as yet unclassified' stamp: 'AD 5/28/2018 20:53:43'!
hasWinningPositions: positions
	^ (self hasCompletedRow: positions) or: [
		(self hasCompletedColumn: positions) or: [
			(self hasCompletedDownDiagonal: positions) or: [ self hasCompletedUpDiagonal: positions ]]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToeStep1!
TicTacToe class
	instanceVariableNames: ''!


!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/24/2018 21:26:33'!
canNotPlayWhenGameIsOverErrorMessage

	^ 'the game has finished'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/28/2018 21:05:39'!
invalidPositionErrorMessage

	^ 'Can not mark an invalid position.'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/28/2018 19:38:10'!
playerCantMarkTwiceErrorMessage

	^ 'A player cant mark two positions in a row'.! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/24/2018 19:58:58'!
positionTakenErrorMessage

	^ 'Positon already taken'! !


!classDefinition: #TicTacToeState category: #TicTacToeStep1!
Object subclass: #TicTacToeState
	instanceVariableNames: 'match'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!TicTacToeState methodsFor: 'marking positions' stamp: 'AD 5/28/2018 20:21:58'!
markWithOAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking positions' stamp: 'AD 5/28/2018 20:21:50'!
markWithXAt: aPosition

	self subclassResponsibility ! !


!TicTacToeState methodsFor: 'initialization' stamp: 'AD 5/28/2018 20:30:51'!
initializeFor: aTicTacToeMatch

	match _ aTicTacToeMatch ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToeStep1!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'instance creation' stamp: 'AD 5/28/2018 20:29:39'!
for: aTicTacToeMatch

	^ self new initializeFor: aTicTacToeMatch ! !


!classDefinition: #PlayerOTurn category: #TicTacToeStep1!
TicTacToeState subclass: #PlayerOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!PlayerOTurn methodsFor: 'marking positions' stamp: 'AD 5/28/2018 20:42:18'!
markWithOAt: aPosition
	
	match assertGameIsNotOver.
	match assertIsAvailable: aPosition.
	
	match safeMarkWithOAt: aPosition.! !

!PlayerOTurn methodsFor: 'marking positions' stamp: 'AD 5/28/2018 20:24:26'!
markWithXAt: aPosition

	self error: TicTacToe playerCantMarkTwiceErrorMessage.! !


!classDefinition: #PlayerXTurn category: #TicTacToeStep1!
TicTacToeState subclass: #PlayerXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!PlayerXTurn methodsFor: 'marking positions' stamp: 'AD 5/28/2018 20:31:57'!
markWithOAt: aPosition

	self error: match class playerCantMarkTwiceErrorMessage.! !

!PlayerXTurn methodsFor: 'marking positions' stamp: 'AD 5/28/2018 20:37:52'!
markWithXAt: aPosition

	match assertGameIsNotOver.
	match assertIsAvailable: aPosition.
	
	match safeMarkWithXAt: aPosition.
	
	! !
