!classDefinition: #TicTacToeTest category: #TicTacToeStep1!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:24:44'!
test01ANewGameIsEmpty

	|game|
	game := TicTacToe new.
	
	self assert: game hasNoPositionsMarkedWithX .
	self assert: game hasNoPositionsMarkedWithO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:29:23'!
test02WhenAPositionIsMarkedWithXItsAddedToTheGame

	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	
	self assert: game amountOfPositionsMarkedWithX = 1.
	self assert: (game hasPlayerXMarkedAt: 1 @ 1).
	self assert: game hasNoPositionsMarkedWithO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:31:25'!
test03APositionCanBeMarkedWithOCorrectlyAfterMarkingAnX
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	
	self assert: game amountOfPositionsMarkedWithO = 1.
	self assert: (game hasPlayerOMarkedAt: 2 @ 2).
	self assert: game amountOfPositionsMarkedWithX = 1.
	self assert: (game hasPlayerXMarkedAt: 1 @ 1).! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:31:58'!
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
			self assert: game amountOfPositionsMarkedWithX = 1.
			self assert: (game hasPlayerXMarkedAt: 1 @ 1).
			self assert: game hasNoPositionsMarkedWithO ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:25:41'!
test05CanNotMarkAnInvalidPosition

	| game |
	
	game _ TicTacToe new.
		
	self
		should: [ game markWithXAt: 0 @ 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe invalidPositionErrorMessage equals: anError messageText.
			self assert: game hasNoPositionsMarkedWithX ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:33:16'!
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
			self assert: game amountOfPositionsMarkedWithX = 1.
			self assert: (game hasPlayerXMarkedAt: 1 @ 1).
			self assert: game amountOfPositionsMarkedWithO = 1.].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:33:28'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:33:34'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:33:38'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:33:44'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:33:48'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:34:09'!
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
			self assert: game amountOfPositionsMarkedWithO = 2.
			self assert: (game hasPlayerOMarkedAt: 2 @ 1).
			self assert: (game hasPlayerOMarkedAt: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:34:17'!
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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/30/2018 14:34:22'!
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

!TicTacToe methodsFor: 'initialization' stamp: 'AD 5/30/2018 14:05:45'!
initialize

	xs := Set new.
	os := Set new.
	state := PlayerXTurn new.
! !


!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:43:33'!
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

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:27:19'!
hasNoPositionsMarkedWithO
	^ self amountOfPositionsMarkedWithO = 0.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:27:36'!
hasNoPositionsMarkedWithX
	^ self amountOfPositionsMarkedWithX = 0.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 21:19:03'!
hasPlayerOMarkedAt: aPosition

	^ os includes: aPosition.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:10:56'!
hasPlayerOWon

	^ self hasWinningPositions: os.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 21:19:20'!
hasPlayerXMarkedAt: aPosition

	^ xs includes: aPosition.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:10:49'!
hasPlayerXWon

	^ self hasWinningPositions: xs.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:10:21'!
hasWinningPositions: positions

	^ (self hasCompletedRow: positions) or: [
		(self hasCompletedColumn: positions) or: [
			(self hasCompletedDownDiagonal: positions) or: [ self hasCompletedUpDiagonal: positions ]]].! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:10:39'!
isGameOver

	^ self isThereWinner or: [self isGameTied ].! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 19:42:50'!
isGameTied

	^ xs size = 5 and: [
		os size = 4 and: [ self hasPlayerXWon not ]].! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 19:42:19'!
isThereWinner

	^ self hasPlayerXWon or: [ self hasPlayerOWon ].! !


!TicTacToe methodsFor: 'game' stamp: 'AD 5/30/2018 14:04:18'!
markWithOAt: aPosition

	state markWithOAt: aPosition On: self.
! !

!TicTacToe methodsFor: 'game' stamp: 'AD 5/30/2018 14:04:30'!
markWithXAt: aPosition

	self assertIsValidPosition: aPosition.

	state markWithXAt: aPosition On: self.! !


!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/28/2018 19:34:06'!
assertGameIsNotOver

	self isGameOver ifTrue: [ self error: self class canNotPlayWhenGameIsOverErrorMessage ].! !

!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/30/2018 14:57:33'!
assertIsAvailable: aPosition

	((self hasPlayerXMarkedAt: aPosition) or: [self hasPlayerOMarkedAt: aPosition]) ifTrue: [ ^ self error: self class positionTakenErrorMessage ].! !

!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/28/2018 21:06:20'!
assertIsValidPosition: aPosition 
	
	(aPosition between: 1@1 and: 3@3) ifFalse: [self error: self class invalidPositionErrorMessage ] ! !


!TicTacToe methodsFor: 'private' stamp: 'AD 5/30/2018 14:06:12'!
safeMarkWithOAt: aPosition 
	
	os add: aPosition.
	
	state _ PlayerXTurn new.! !

!TicTacToe methodsFor: 'private' stamp: 'AD 5/30/2018 14:06:18'!
safeMarkWithXAt: aPosition 
	
	xs add: aPosition.
	
	state _ PlayerOTurn new.! !


!TicTacToe methodsFor: 'size' stamp: 'AD 5/30/2018 14:27:43'!
amountOfPositionsMarkedWithO

	^ os size.! !

!TicTacToe methodsFor: 'size' stamp: 'AD 5/30/2018 14:27:47'!
amountOfPositionsMarkedWithX

	^ xs size.! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!TicTacToeState methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:00:03'!
markWithOAt: aPosition On: aTicTacToeMatch

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:00:20'!
markWithXAt: aPosition On: aTicTacToeMatch

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToeStep1!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'instance creation' stamp: 'AD 5/31/2018 10:35:24'!
new

	self subclassResponsibility! !


!classDefinition: #PlayerOTurn category: #TicTacToeStep1!
TicTacToeState subclass: #PlayerOTurn
	instanceVariableNames: 'uniqueInstance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!PlayerOTurn methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:01:31'!
markWithOAt: aPosition On: aTicTacToeMatch
	
	aTicTacToeMatch assertGameIsNotOver.
	aTicTacToeMatch assertIsAvailable: aPosition.
	
	aTicTacToeMatch safeMarkWithOAt: aPosition.! !

!PlayerOTurn methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:02:58'!
markWithXAt: aPosition On: aTicTacToeMatch

	self error: aTicTacToeMatch class playerCantMarkTwiceErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerOTurn class' category: #TicTacToeStep1!
PlayerOTurn class
	instanceVariableNames: 'uniqueInstance'!

!PlayerOTurn class methodsFor: 'instance creation' stamp: 'AD 5/31/2018 10:34:17'!
new
	
	uniqueInstance ifNil:[uniqueInstance := self basicNew].
	
	^ uniqueInstance ! !


!classDefinition: #PlayerXTurn category: #TicTacToeStep1!
TicTacToeState subclass: #PlayerXTurn
	instanceVariableNames: 'uniqueInstance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToeStep1'!

!PlayerXTurn methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:02:02'!
markWithOAt: aPosition On: aTicTacToeMatch

	self error: aTicTacToeMatch class playerCantMarkTwiceErrorMessage.! !

!PlayerXTurn methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:02:26'!
markWithXAt: aPosition On: aTicTacToeMatch

	aTicTacToeMatch assertGameIsNotOver.
	aTicTacToeMatch assertIsAvailable: aPosition.
	
	aTicTacToeMatch safeMarkWithXAt: aPosition.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerXTurn class' category: #TicTacToeStep1!
PlayerXTurn class
	instanceVariableNames: 'uniqueInstance'!

!PlayerXTurn class methodsFor: 'instance creation' stamp: 'AD 5/31/2018 10:34:36'!
new
	
	uniqueInstance ifNil:[uniqueInstance := self basicNew].
	
	^ uniqueInstance! !
