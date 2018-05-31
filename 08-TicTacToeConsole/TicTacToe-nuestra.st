!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/31/2018 12:15:12'!
test01ANewGameIsEmpty
	| game |
	game _ TicTacToe new.
	self deny: game hasPositionsMarkedWithX.
	self deny: game hasPositionsMarkedWithO.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/31/2018 12:14:11'!
test02WhenAPositionIsMarkedWithXItsAddedToTheGame
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	self assert: game amountOfPositionsMarkedWithX = 1.
	self assert: (game hasPlayerXMarkedAt: 1 @ 1).
	self deny: game hasPositionsMarkedWithO.! !

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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/31/2018 12:14:18'!
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
			self deny: game hasPositionsMarkedWithO ].! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/31/2018 12:15:22'!
test05CanNotMarkAnInvalidPosition
	| game |
	game _ TicTacToe new.
	self
		should: [ game markWithXAt: 0 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe invalidPositionErrorMessage
				equals: anError messageText.
			self deny: game hasPositionsMarkedWithX ].! !

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

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/31/2018 12:11:17'!
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
	self assert: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'tests' stamp: 'AD 5/31/2018 12:11:17'!
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
	self assert: game isOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs winner state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'AD 5/30/2018 14:05:45'!
initialize

	xs := Set new.
	os := Set new.
	state := PlayerXTurn new.
! !


!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:22:06'!
hasAllPositionsTaken
	^ self amountOfPositionsMarkedWithX = 5.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/30/2018 14:43:33'!
hasCompletedColumn: aPlayersMarkedPositions
		
		^ (1 to: 3) anySatisfy: [:y | (aPlayersMarkedPositions count:  [:position | position y = y]) = 3]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:31:20'!
hasCompletedDownDiagonal: aPlayersMarkedPositions

	^(1 to: 3) allSatisfy: [:n | aPlayersMarkedPositions includes: n@n]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/28/2018 20:51:28'!
hasCompletedRow: aPlayersMarkedPositions
		
		^ (1 to: 3) anySatisfy: [:x | (aPlayersMarkedPositions count:  [:position | position x = x]) = 3]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:31:33'!
hasCompletedUpDiagonal: aPlayersMarkedPositions

	^(1 to: 3) allSatisfy: [ :n | aPlayersMarkedPositions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:21:17'!
hasPlayerOMarkedAt: aPosition

	^ os includes: aPosition.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:19:37'!
hasPlayerOWon

	^ state hasPlayerOWonIn: self.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:19:44'!
hasPlayerXMarkedAt: aPosition

	^ xs includes: aPosition.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:19:50'!
hasPlayerXWon
	^ state hasPlayerXWonIn: self.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:19:57'!
hasPositionsMarkedWithO

	^ self amountOfPositionsMarkedWithO > 0.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:20:03'!
hasPositionsMarkedWithX

	^ self amountOfPositionsMarkedWithX > 0.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:20:16'!
hasWinner

	^ self OhasWinningPositions or: [ self XhasWinningPositions ].! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:20:30'!
isOver

	^ state isOver: self.! !

!TicTacToe methodsFor: 'testing' stamp: 'AD 5/31/2018 14:20:35'!
isTied

	^ state isTied: self! !


!TicTacToe methodsFor: 'game' stamp: 'AD 5/31/2018 14:06:11'!
markWithOAt: aPosition
	self assertIsValid: aPosition.
	state
		markWithOAt: aPosition
		On: self.! !

!TicTacToe methodsFor: 'game' stamp: 'AD 5/31/2018 14:06:11'!
markWithXAt: aPosition
	self assertIsValid: aPosition.
	state
		markWithXAt: aPosition
		On: self.! !


!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/31/2018 14:18:59'!
assertIsAvailable: aPosition

	((self hasPlayerXMarkedAt: aPosition) or: [self hasPlayerOMarkedAt: aPosition]) ifTrue: [ ^ self error: self class positionTakenErrorMessage ].! !

!TicTacToe methodsFor: 'asserting' stamp: 'AD 5/31/2018 14:06:11'!
assertIsValid: aPosition
	(aPosition
		between: 1 @ 1
		and: 3 @ 3) ifFalse: [ self error: self class invalidPositionErrorMessage ].! !


!TicTacToe methodsFor: 'private' stamp: 'AD 5/31/2018 14:09:41'!
OhasWinningPositions
	
	^ self hasWinningPositions: os! !

!TicTacToe methodsFor: 'private' stamp: 'AD 5/31/2018 14:09:50'!
XhasWinningPositions
	
	^ self hasWinningPositions: xs! !

!TicTacToe methodsFor: 'private' stamp: 'AD 5/31/2018 13:35:43'!
changeStateTo: aState

	state _ aState.! !

!TicTacToe methodsFor: 'private' stamp: 'AD 5/31/2018 14:18:31'!
hasWinningPositions: positions

	^ (self hasCompletedRow: positions) or: [
		(self hasCompletedColumn: positions) or: [
			(self hasCompletedDownDiagonal: positions) or: [ self hasCompletedUpDiagonal: positions ]]].! !

!TicTacToe methodsFor: 'private' stamp: 'AD 5/31/2018 14:18:22'!
safeMarkWithOAt: aPosition 

	os add: aPosition.! !

!TicTacToe methodsFor: 'private' stamp: 'AD 5/31/2018 14:18:16'!
safeMarkWithXAt: aPosition 

	xs add: aPosition.! !


!TicTacToe methodsFor: 'size' stamp: 'AD 5/31/2018 12:32:19'!
amountOfPositionsMarkedWithO

	^ os size.! !

!TicTacToe methodsFor: 'size' stamp: 'AD 5/31/2018 12:32:26'!
amountOfPositionsMarkedWithX

	^ xs size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/31/2018 12:50:51'!
canNotPlayWhenGameIsOverErrorMessage

	^ 'The game has finished'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/28/2018 21:05:39'!
invalidPositionErrorMessage

	^ 'Can not mark an invalid position.'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/28/2018 19:38:10'!
playerCantMarkTwiceErrorMessage

	^ 'A player cant mark two positions in a row'.! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 5/24/2018 19:58:58'!
positionTakenErrorMessage

	^ 'Positon already taken'! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:00:03'!
markWithOAt: aPosition On: aTicTacToeMatch

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking positions' stamp: 'AD 5/30/2018 14:00:20'!
markWithXAt: aPosition On: aTicTacToeMatch

	self subclassResponsibility ! !


!TicTacToeState methodsFor: 'error signals' stamp: 'AD 5/31/2018 12:51:14'!
signalCanNotPlayWhenGameIsOver

	self error: TicTacToe canNotPlayWhenGameIsOverErrorMessage.! !

!TicTacToeState methodsFor: 'error signals' stamp: 'AD 5/31/2018 12:25:00'!
signalPlayerCantMarkTwiceInARow

	self error: TicTacToe playerCantMarkTwiceErrorMessage.! !


!TicTacToeState methodsFor: 'testing' stamp: 'AD 5/31/2018 13:31:22'!
hasPlayerOWonIn: aTictacToeGame

	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'AD 5/31/2018 13:31:33'!
hasPlayerXWonIn: aTictacToeGame

	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'AD 5/31/2018 13:29:30'!
isOver: aTictacToeGame

	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'testing' stamp: 'AD 5/31/2018 13:31:11'!
isTied: aTictacToeGame

	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'states' stamp: 'AD 5/31/2018 13:36:42'!
changeStateIn: aTicTacToeGame

	aTicTacToeGame changeStateTo: (self nextStateFor: aTicTacToeGame)! !

!TicTacToeState methodsFor: 'states' stamp: 'AD 5/31/2018 13:33:44'!
nextStateFor: aTicTacToeGame

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: 'uniqueInstance'!

!TicTacToeState class methodsFor: 'instance creation' stamp: 'AD 5/31/2018 11:56:43'!
new
	
	^ self uniqueInstance.! !


!TicTacToeState class methodsFor: 'unique instance' stamp: 'AD 5/31/2018 11:56:26'!
uniqueInstance
	
	uniqueInstance ifNil:[uniqueInstance := self basicNew].
	
	^ uniqueInstance! !


!classDefinition: #GameOver category: #TicTacToe!
TicTacToeState subclass: #GameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOver methodsFor: 'marking positions' stamp: 'AD 5/31/2018 12:51:29'!
markWithOAt: aPosition On: aTicTacToeMatch

	self signalCanNotPlayWhenGameIsOver.! !

!GameOver methodsFor: 'marking positions' stamp: 'AD 5/31/2018 12:51:35'!
markWithXAt: aPosition On: aTicTacToeMatch

	self signalCanNotPlayWhenGameIsOver.! !


!GameOver methodsFor: 'testing' stamp: 'AD 5/31/2018 14:11:47'!
hasPlayerOWonIn: aTicTacToeGame

	^ aTicTacToeGame OhasWinningPositions.! !

!GameOver methodsFor: 'testing' stamp: 'AD 5/31/2018 14:11:54'!
hasPlayerXWonIn: aTicTacToeGame

	^ aTicTacToeGame XhasWinningPositions.! !

!GameOver methodsFor: 'testing' stamp: 'AD 5/31/2018 13:30:40'!
isOver: aTicTacToeGame

	^ true! !

!GameOver methodsFor: 'testing' stamp: 'AD 5/31/2018 14:23:22'!
isTied: aTictacToeGame

	^ aTictacToeGame hasAllPositionsTaken
		and: [
			aTictacToeGame XhasWinningPositions not ].! !


!GameOver methodsFor: 'states' stamp: 'AD 5/31/2018 13:33:55'!
nextStateFor: aTicTacToeGame

	^ self! !


!classDefinition: #PlayerOTurn category: #TicTacToe!
TicTacToeState subclass: #PlayerOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOTurn methodsFor: 'marking positions' stamp: 'AD 5/31/2018 13:37:26'!
markWithOAt: aPosition On: aTicTacToeMatch

	aTicTacToeMatch assertIsAvailable: aPosition.
	
	aTicTacToeMatch safeMarkWithOAt: aPosition.
	
	self changeStateIn: aTicTacToeMatch.! !

!PlayerOTurn methodsFor: 'marking positions' stamp: 'AD 5/31/2018 12:25:37'!
markWithXAt: aPosition On: aTicTacToeMatch

	self signalPlayerCantMarkTwiceInARow! !


!PlayerOTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:31:58'!
hasPlayerOWonIn: aTictacToeGame

	^ false! !

!PlayerOTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:32:03'!
hasPlayerXWonIn: aTictacToeGame

	^ false! !

!PlayerOTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:29:58'!
isOver: aTictacToeGame

	^ false! !

!PlayerOTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:30:15'!
isTied: aTictacToeGame

	^ false! !


!PlayerOTurn methodsFor: 'states' stamp: 'AD 5/31/2018 14:27:58'!
nextStateFor: aTicTacToeGame

	(aTicTacToeGame hasWinner or: [ aTicTacToeGame hasAllPositionsTaken ])
		ifTrue: [ ^ GameOver new ].
		
	^ PlayerXTurn new.! !


!classDefinition: #PlayerXTurn category: #TicTacToe!
TicTacToeState subclass: #PlayerXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXTurn methodsFor: 'marking positions' stamp: 'AD 5/31/2018 12:25:48'!
markWithOAt: aPosition On: aTicTacToeMatch

	self signalPlayerCantMarkTwiceInARow! !

!PlayerXTurn methodsFor: 'marking positions' stamp: 'AD 5/31/2018 13:37:39'!
markWithXAt: aPosition On: aTicTacToeMatch

	aTicTacToeMatch assertIsAvailable: aPosition.
	
	aTicTacToeMatch safeMarkWithXAt: aPosition.	
	
	self changeStateIn: aTicTacToeMatch.! !


!PlayerXTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:32:15'!
hasPlayerOWonIn: aTictacToeGame

	^ false! !

!PlayerXTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:32:18'!
hasPlayerXWonIn: aTictacToeGame

	^ false! !

!PlayerXTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:29:47'!
isOver: aTictacToeGame

	^ false! !

!PlayerXTurn methodsFor: 'testing' stamp: 'AD 5/31/2018 13:31:01'!
isTied: aTictacToeGame

	^ false! !


!PlayerXTurn methodsFor: 'states' stamp: 'AD 5/31/2018 14:27:38'!
nextStateFor: aTicTacToeGame

	(aTicTacToeGame hasWinner or: [ aTicTacToeGame hasAllPositionsTaken ])
		ifTrue: [ ^ GameOver new ].
		
	^ PlayerOTurn new.! !
