!classDefinition: #TicTacToeObserverTest category: #TicTacToe!
TestCase subclass: #TicTacToeObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:33:20'!
test01AConsoleLogsTheFirstMovementCorrectly

	| console game |
	console _ TicTacToeConsole new.
	game _ TicTacToe new.
	
	game attach: console.
	
	game markWithXAt: 2 @ 2.
	
	self assert: (console log at: 1)	equals: 'X marcó en 2@2'.
	self assert: (console log at: 2) equals: 'Estado: Jugando O'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:33:59'!
test02AConsoleLogsTheFirstTwoMovementsCorrectly

	| console game |
	
	console _ TicTacToeConsole new.
	game _ TicTacToe new.
	
	game attach: console.
	
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	
	self
		assert: (console log at: 1)
		equals: 'X marcó en 2@2'.
	self
		assert: (console log at: 2)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 3)
		equals: 'O marcó en 1@1'.
	self
		assert: (console log at: 4)
		equals: 'Estado: Jugando X'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:34:20'!
test03AConsoleLogsTheFirstThreeMovementsCorrectly

	| console game |
	
	console _ TicTacToeConsole new.
	game _ TicTacToe new.
	
	game attach: console.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 3}.
	
	self
		assert: (console log at: 1)
		equals: 'X marcó en 2@2'.
	self
		assert: (console log at: 2)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 3)
		equals: 'O marcó en 1@1'.
	self
		assert: (console log at: 4)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 5)
		equals: 'X marcó en 1@3'.
	self
		assert: (console log at: 6)
		equals: 'Estado: Jugando O'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:34:54'!
test04AConsoleLogsWhenPlayerXWinsCorrectly

	| console game |
	
	console _ TicTacToeConsole new.
	game _ TicTacToe new.
	
	game attach: console.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 3. 1 @ 2. 3 @ 1}.
	
	self
		assert: (console log at: 1)
		equals: 'X marcó en 2@2'.
	self
		assert: (console log at: 2)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 3)
		equals: 'O marcó en 1@1'.
	self
		assert: (console log at: 4)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 5)
		equals: 'X marcó en 1@3'.
	self
		assert: (console log at: 6)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 7)
		equals: 'O marcó en 1@2'.
	self
		assert: (console log at: 8)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 9)
		equals: 'X marcó en 3@1'.
	self
		assert: (console log at: 10)
		equals: 'Estado: Juego terminado - Ganó X!!'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:35:14'!
test05AConsoleLogsWhenPlayerOWinsCorrectly

	| console game |
	
	console _ TicTacToeConsole new.
	game _ TicTacToe new.
	
	game attach: console.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 2. 2 @ 1. 3 @ 3. 3 @ 1}.
	
	self
		assert: (console log at: 1)
		equals: 'X marcó en 2@2'.
	self
		assert: (console log at: 2)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 3)
		equals: 'O marcó en 1@1'.
	self
		assert: (console log at: 4)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 5)
		equals: 'X marcó en 1@2'.
	self
		assert: (console log at: 6)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 7)
		equals: 'O marcó en 2@1'.
	self
		assert: (console log at: 8)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 9)
		equals: 'X marcó en 3@3'.
	self
		assert: (console log at: 10)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 11)
		equals: 'O marcó en 3@1'.
	self
		assert: (console log at: 12)
		equals: 'Estado: Juego terminado - Ganó O!!'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:35:38'!
test06AConsoleLogsWhenTheGameIsTiedCorrectly

	| console game |
	console _ TicTacToeConsole new.
	game _ TicTacToe new.
	
	game attach: console.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 3. 3 @ 1. 2 @ 1. 2 @ 3. 1 @ 2. 3 @ 2. 3 @ 3}.
	
	self
		assert: (console log at: 1)
		equals: 'X marcó en 2@2'.
	self
		assert: (console log at: 2)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 3)
		equals: 'O marcó en 1@1'.
	self
		assert: (console log at: 4)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 5)
		equals: 'X marcó en 1@3'.
	self
		assert: (console log at: 6)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 7)
		equals: 'O marcó en 3@1'.
	self
		assert: (console log at: 8)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 9)
		equals: 'X marcó en 2@1'.
	self
		assert: (console log at: 10)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 11)
		equals: 'O marcó en 2@3'.
	self
		assert: (console log at: 12)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 13)
		equals: 'X marcó en 1@2'.
	self
		assert: (console log at: 14)
		equals: 'Estado: Jugando O'.
	self
		assert: (console log at: 15)
		equals: 'O marcó en 3@2'.
	self
		assert: (console log at: 16)
		equals: 'Estado: Jugando X'.
	self
		assert: (console log at: 17)
		equals: 'X marcó en 3@3'.
	self
		assert: (console log at: 18)
		equals: 'Estado: Juego terminado - Empate!!'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:38:37'!
test07AVisualizerShowsTheBoardAndStateAfterTheFirstMovementCorrectly

	| visualizer game boardView |
	
	visualizer _ TicTacToeVisualizer new.
	game _ TicTacToe new.
	
	game attach: visualizer.
	
	game markWithXAt: 2 @ 2.
	
	boardView _ visualizer view.
	
	self
		assert: (boardView at: 1)
		equals: ' | | '.
	self
		assert: (boardView at: 2)
		equals: '-----'.
	self
		assert: (boardView at: 3)
		equals: ' |X| '.
	self
		assert: (boardView at: 4)
		equals: '-----'.
	self
		assert: (boardView at: 5)
		equals: ' | | '.
	self
		assert: (boardView at: 6)
		equals: 'Playing O'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:38:47'!
test08AVisualizerShowsTheBoardAndStateAfterTheFirstTwoMovementsCorrectly

	| visualizer game boardView |
	
	visualizer _ TicTacToeVisualizer new.
	game _ TicTacToe new.
	
	game attach: visualizer.
	
	game markAll: {2 @ 2. 1 @ 1}.
	
	boardView _ visualizer view.
	
	self
		assert: (boardView at: 1)
		equals: ' | | '.
	self
		assert: (boardView at: 2)
		equals: '-----'.
	self
		assert: (boardView at: 3)
		equals: ' |X| '.
	self
		assert: (boardView at: 4)
		equals: '-----'.
	self
		assert: (boardView at: 5)
		equals: 'O| | '.
	self
		assert: (boardView at: 6)
		equals: 'Playing X'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:38:56'!
test09AVisualizerShowsTheBoardAndStateAfterTheFirstThreeMovementsCorrectly

	| visualizer game boardView |
	
	visualizer _ TicTacToeVisualizer new.
	game _ TicTacToe new.
	game attach: visualizer.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 3}.
	
	boardView _ visualizer view.
	
	self
		assert: (boardView at: 1)
		equals: 'X| | '.
	self
		assert: (boardView at: 2)
		equals: '-----'.
	self
		assert: (boardView at: 3)
		equals: ' |X| '.
	self
		assert: (boardView at: 4)
		equals: '-----'.
	self
		assert: (boardView at: 5)
		equals: 'O| | '.
	self
		assert: (boardView at: 6)
		equals: 'Playing O'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:38:18'!
test10AVisualizerShowsTheBoardAndStateOfAMatchWonByXCorrectly

	| visualizer game boardView |
	
	visualizer _ TicTacToeVisualizer new.
	game _ TicTacToe new.
	
	game attach: visualizer.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 3. 1 @ 2. 3 @ 1}.
	
	boardView _ visualizer view.
	
	self
		assert: (boardView at: 1)
		equals: 'X| | '.
	self
		assert: (boardView at: 2)
		equals: '-----'.
	self
		assert: (boardView at: 3)
		equals: 'O|X| '.
	self
		assert: (boardView at: 4)
		equals: '-----'.
	self
		assert: (boardView at: 5)
		equals: 'O| |X'.
	self
		assert: (boardView at: 6)
		equals: 'X Won!!'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:39:21'!
test11AVisualizerShowsTheBoardAndStateOfAMatchWonByOCorrectly

	| visualizer game boardView |
	
	visualizer _ TicTacToeVisualizer new.
	game _ TicTacToe new.
	
	game attach: visualizer.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 2. 2 @ 1. 3 @ 3. 3 @ 1}.
	
	boardView _ visualizer view.
	
	self
		assert: (boardView at: 1)
		equals: ' | |X'.
	self
		assert: (boardView at: 2)
		equals: '-----'.
	self
		assert: (boardView at: 3)
		equals: 'X|X| '.
	self
		assert: (boardView at: 4)
		equals: '-----'.
	self
		assert: (boardView at: 5)
		equals: 'O|O|O'.
	self
		assert: (boardView at: 6)
		equals: 'O Won!!'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:39:45'!
test12AVisualizerShowsTheBoardAndStateOfATiedMatchCorrectly

	| visualizer game boardView |
	
	visualizer _ TicTacToeVisualizer new.
	game _ TicTacToe new.
	
	game attach: visualizer.
	
	game markAll: {2 @ 2. 1 @ 1. 1 @ 3. 3 @ 1. 2 @ 1. 2 @ 3. 1 @ 2. 3 @ 2. 3 @ 3}.
	
	boardView _ visualizer view.
	
	self
		assert: (boardView at: 1)
		equals: 'X|O|X'.
	self
		assert: (boardView at: 2)
		equals: '-----'.
	self
		assert: (boardView at: 3)
		equals: 'X|X|O'.
	self
		assert: (boardView at: 4)
		equals: '-----'.
	self
		assert: (boardView at: 5)
		equals: 'O|X|O'.
	self
		assert: (boardView at: 6)
		equals: 'Game Tied!!'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 21:36:58'!
test13MoreThanOneObserversCanObserveSimultaneously

	| console visualizer game boardView |
	
	console _ TicTacToeConsole new.
	visualizer _ TicTacToeVisualizer new.
	game _ TicTacToe new.
	
	game attach: console; attach: visualizer.
	
	game markWithXAt: 2 @ 2.
	
	boardView _ visualizer view.
	
	self assert: game numberOfObservers equals: 2.
	self assert: (console log at: 1)	equals: 'X marcó en 2@2'.
	self assert: (console log at: 2)	equals: 'Estado: Jugando O'.
	self assert: (boardView at: 1) equals: ' | | '.
	self assert: (boardView at: 2) equals: '-----'.
	self assert: (boardView at: 3) equals: ' |X| '.
	self assert: (boardView at: 4) equals: '-----'.
	self assert: (boardView at: 5) equals: ' | | '.
	self assert: (boardView at: 6) equals: 'Playing O'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:22:49'!
test14ADetachedObserverIsntUpdatedAnyMore

	| console game |
	
	console _ TicTacToeConsole new.
	game _ TicTacToe new attach: console.
	
	game markWithXAt: 2 @ 2.
	
	game detach: console.
	
	game markWithOAt: 1 @ 1.
	
	self assert: console log size equals: 2.
	self assert: (console log at: 1) equals: 'X marcó en 2@2'.
	self assert: (console log at: 2) equals: 'Estado: Jugando O'.! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 20:13:58'!
test15CanNotDetachAnObserverThatWasntAttached

	| console game |
	
	console _ TicTacToeConsole new.
	game _ TicTacToe new.	
	
	self should: [game detach: console.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:error |
				self assert: error messageText equals: TicTacToe canNotDetachAndUnattachedObserverErrorMessage]! !

!TicTacToeObserverTest methodsFor: 'tests' stamp: 'AD 6/3/2018 21:35:27'!
test16CanNotAttachAnObserverThatWasAlreadyAttached

	| console game |
	
	console _ TicTacToeConsole new.
	game _ TicTacToe new.	
	
	game attach: console.
	
	self should: [game attach: console.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:error |
				self assert: error messageText equals: TicTacToe observerAlreadyAttachedErrorMessage.
				self assert: game numberOfObservers equals: 1]! !


!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'AD 6/3/2018 19:56:58'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	state _ PlayingX for: self.
	observers _ OrderedCollection new.! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:30:17'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithOAt: aPosition.! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 10/27/2017 10:24:49'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	state markWithXAt: aPosition.! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:41:25'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self
	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'AD 6/3/2018 21:32:52'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'AD 6/3/2018 21:15:59'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.
	self notifyObservers: [ :anObserver |
		anObserver updatePlayerOmarkedAt: aPosition ].
	state updateObservers.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'AD 6/3/2018 21:16:40'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.
	self notifyObservers: [ :anObserver |
		anObserver updatePlayerXmarkedAt: aPosition ].
	state updateObservers.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:44:57'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'observers' stamp: 'AD 6/3/2018 20:19:10'!
attach: anObserver

	self assertNotAlreadyAttached: anObserver .

	observers add: anObserver.! !

!TicTacToe methodsFor: 'observers' stamp: 'AD 6/3/2018 20:20:20'!
detach: anObserver

	self assertIsAttached: anObserver.
	
	observers remove: anObserver.! !

!TicTacToe methodsFor: 'observers' stamp: 'AD 6/3/2018 21:36:12'!
numberOfObservers
	
	^ observers size.! !


!TicTacToe methodsFor: 'observers - private' stamp: 'AD 6/3/2018 21:15:17'!
notifyGameTied
	self notifyObservers: [ :observer |
		observer updateGameTied ].! !

!TicTacToe methodsFor: 'observers - private' stamp: 'AD 6/3/2018 21:15:45'!
notifyOWon
	self notifyObservers: [ :observer |
		observer updatePlayerOWon ].! !

!TicTacToe methodsFor: 'observers - private' stamp: 'AD 6/3/2018 20:57:24'!
notifyObservers: aBlock

	observers do: [ :anObserver |
		aBlock value: anObserver ].
	
! !

!TicTacToe methodsFor: 'observers - private' stamp: 'AD 6/3/2018 21:15:30'!
notifyPlayingO
	self notifyObservers: [ :observer |
		observer updatePlayerOTurn ].! !

!TicTacToe methodsFor: 'observers - private' stamp: 'AD 6/3/2018 21:16:14'!
notifyPlayingX
	self notifyObservers: [ :observer |
		observer updatePlayerXTurn ].! !

!TicTacToe methodsFor: 'observers - private' stamp: 'AD 6/3/2018 21:16:27'!
notifyXWon
	self notifyObservers: [ :observer |
		observer updatePlayerXWon ].! !


!TicTacToe methodsFor: 'assertions' stamp: 'AD 6/3/2018 20:20:42'!
assertIsAttached: anObserver 

	(observers includes: anObserver) ifFalse: [self error: self class canNotDetachAndUnattachedObserverErrorMessage ].! !

!TicTacToe methodsFor: 'assertions' stamp: 'AD 6/3/2018 20:19:30'!
assertNotAlreadyAttached: anObserver 

	(observers includes: anObserver) ifTrue: [ self error: self class observerAlreadyAttachedErrorMessage].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!TicTacToe class methodsFor: 'error messages' stamp: 'AD 6/3/2018 20:08:04'!
canNotDetachAndUnattachedObserverErrorMessage
	
	^ 'Can not detach an observer that was not attached.'! !

!TicTacToe class methodsFor: 'error messages' stamp: 'AD 6/3/2018 20:16:41'!
observerAlreadyAttachedErrorMessage
	
	^ 'Observer already attached'! !


!classDefinition: #TicTacToeObserver category: #TicTacToe!
Object subclass: #TicTacToeObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserver methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:17'!
updateGameTied
	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:30'!
updatePlayerOTurn
	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:45'!
updatePlayerOWon
	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:59'!
updatePlayerOmarkedAt: aPosition
	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:16:14'!
updatePlayerXTurn
	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:16:27'!
updatePlayerXWon
	self subclassResponsibility.! !

!TicTacToeObserver methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:16:40'!
updatePlayerXmarkedAt: aPosition
	self subclassResponsibility.! !


!classDefinition: #TicTacToeConsole category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeConsole
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsole methodsFor: 'initialization' stamp: 'AD 6/3/2018 21:32:27'!
initialize

	log _ OrderedCollection new.! !


!TicTacToeConsole methodsFor: 'log' stamp: 'AD 6/3/2018 21:31:30'!
log

	^ log copy.! !

!TicTacToeConsole methodsFor: 'log' stamp: 'AD 6/3/2018 21:29:43'!
log: aLineToLog

	log add: aLineToLog.! !


!TicTacToeConsole methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:31:12'!
updateGameTied

	self log: 'Estado: Juego terminado - Empate!!'.! !

!TicTacToeConsole methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:31:01'!
updatePlayerOTurn

	self log: 'Estado: Jugando O'.! !

!TicTacToeConsole methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:30:48'!
updatePlayerOWon

	self log: 'Estado: Juego terminado - Ganó O!!'.! !

!TicTacToeConsole methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:30:38'!
updatePlayerOmarkedAt: aPosition

	self log: 'O marcó en ' , aPosition printString.! !

!TicTacToeConsole methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:30:29'!
updatePlayerXTurn

	self log: 'Estado: Jugando X'.! !

!TicTacToeConsole methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:30:14'!
updatePlayerXWon

	self log: 'Estado: Juego terminado - Ganó X!!'.! !

!TicTacToeConsole methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:29:03'!
updatePlayerXmarkedAt: aPosition
	
	self log: 'X marcó en ' , aPosition printString.! !


!classDefinition: #TicTacToeVisualizer category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeVisualizer
	instanceVariableNames: 'markedPositions state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeVisualizer methodsFor: 'visualization' stamp: 'AD 6/3/2018 17:27:25'!
view

	| board |
	
	board _ self boardFor: markedPositions.
	
	board add: state.
	
	^ board.! !


!TicTacToeVisualizer methodsFor: 'initialization' stamp: 'AD 6/3/2018 17:34:47'!
initialize

	markedPositions _ OrderedCollection new.
	
	3 timesRepeat: [markedPositions add: (OrderedCollection with: $  with: $  with: $ )]! !


!TicTacToeVisualizer methodsFor: 'visualization - private' stamp: 'AD 6/3/2018 18:06:48'!
at: aPosition put: aLetter

	(markedPositions at: 4 - aPosition y) at: aPosition x put: aLetter.! !

!TicTacToeVisualizer methodsFor: 'visualization - private' stamp: 'AD 6/3/2018 17:33:22'!
boardFor: positions

	| board |
	
	board _ OrderedCollection new.
	
	board add: (self printPositionsAt: 1);
		    add: '-----';
		    add: (self printPositionsAt: 2);
		    add: '-----';
		    add: (self printPositionsAt: 3).
	
	^ board! !

!TicTacToeVisualizer methodsFor: 'visualization - private' stamp: 'AD 6/3/2018 17:31:03'!
printPositionsAt: aLine		
		
		^ String streamContents: [ :stream | 
			stream nextPut: ((markedPositions at: aLine) at: 1);
					nextPut: $|;
					nextPut: ((markedPositions at: aLine) at: 2);
					nextPut: $|;
					nextPut: ((markedPositions at: aLine) at: 3).
		].! !


!TicTacToeVisualizer methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:17'!
updateGameTied
	state _ 'Game Tied!!'.! !

!TicTacToeVisualizer methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:30'!
updatePlayerOTurn
	state _ 'Playing O'.! !

!TicTacToeVisualizer methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:45'!
updatePlayerOWon
	state _ 'O Won!!'.! !

!TicTacToeVisualizer methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:15:59'!
updatePlayerOmarkedAt: aPosition
	self
		at: aPosition
		put: $O.! !

!TicTacToeVisualizer methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:16:14'!
updatePlayerXTurn
	state _ 'Playing X'.! !

!TicTacToeVisualizer methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:16:27'!
updatePlayerXWon
	state _ 'X Won!!'.! !

!TicTacToeVisualizer methodsFor: 'game updates' stamp: 'AD 6/3/2018 21:16:40'!
updatePlayerXmarkedAt: aPosition
	self
		at: aPosition
		put: $X.! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !


!TicTacToeState methodsFor: 'observers' stamp: 'AD 6/3/2018 21:05:37'!
updateObservers
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!GameTied methodsFor: 'observers' stamp: 'AD 6/3/2018 21:19:22'!
updateObservers

	^ game notifyGameTied.! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!PlayerOWon methodsFor: 'observers' stamp: 'AD 6/3/2018 21:08:59'!
updateObservers
	game notifyOWon.! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!PlayerXWon methodsFor: 'observers' stamp: 'AD 6/3/2018 21:09:34'!
updateObservers
	game notifyXWon.! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!PlayingO methodsFor: 'observers' stamp: 'AD 6/3/2018 21:09:11'!
updateObservers
	game notifyPlayingO.! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !


!PlayingX methodsFor: 'observers' stamp: 'AD 6/3/2018 21:09:23'!
updateObservers
	game notifyPlayingX.! !
