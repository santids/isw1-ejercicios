!classDefinition: #TestTerniLapilli category: #'Terni Lapilli'!
TestCase subclass: #TestTerniLapilli
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TestTerniLapilli methodsFor: 'assertions' stamp: 'TCM 10/15/2019 19:04:42'!
shouldMoveOFrom: aSourcePosition to: aDestinationPosition failWithMessageText: anErrorMessageText inGame: aGame

	self should: [ aGame moveOFrom: aSourcePosition to: aDestinationPosition ]
		raise: Error - MessageNotUnderstood
		withMessageText: anErrorMessageText.
	

	self deny: (aGame thereIsOat: aDestinationPosition ).
	self assert: (aGame thereIsOat: aSourcePosition )! !

!TestTerniLapilli methodsFor: 'assertions' stamp: 'TCM 10/15/2019 18:59:45'!
shouldMoveXFrom: aSourcePosition to: aDestinationPosition failWithMessageText: anErrorMessageText inGame: aGame

	self should: [ aGame moveXFrom: aSourcePosition to: aDestinationPosition ]
		raise: Error - MessageNotUnderstood
		withMessageText: anErrorMessageText.
	

	self deny: (aGame thereIsXat: aDestinationPosition ).
	self assert: (aGame thereIsXat: aSourcePosition )! !


!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 18:04:10'!
test12XCannotMoveAStoneThatIsNotPresent

	| game |
	game := TerniLapilli new.

	self should: [
		game moveXFrom: 2@1 to: 3@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli cannotMoveInexistantStoneErrorMessage.

	self deny: (game thereIsXat: 3@1)! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/16/2019 16:06:38'!
test13XCannotMoveAStoneBeforeAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.


	self shouldMoveXFrom: 1@1 to: 2@2 failWithMessageText: TerniLapilli  allStonesMustBeOnBoardErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:24:58'!
test14XCanMoveWhenAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 2@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	game moveXFrom: 2@2 to: 3@1.

	self deny: (game thereIsXat: 2@2).
	self assert: (game thereIsXat: 3@1).
	self assert: game isPlayingO ! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 18:59:45'!
test16XCannotMoveTwoStepsInADirection

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	self shouldMoveXFrom: 1@1 to: 3@1 failWithMessageText: TerniLapilli  invalidMovementErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:00:20'!
test17XCannotMoveOneStepInDiagonalFrom21To12

	| game |
	game := TerniLapilli new.

	game putXAt: 2@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	" El tablero está en este estado:
	XOX
	- O -
	OX-
	"
	
	self shouldMoveXFrom: 2@1 to: 1@2 failWithMessageText: TerniLapilli  invalidMovementErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:00:41'!
test18XCannotMoveOneStepInDiagonalFrom21To32

	| game |
	game := TerniLapilli new.

	game putXAt: 2@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	" El tablero está en este estado:
	XOX
	- O -
	OX-
	"
	self shouldMoveXFrom: 2@1 to: 3@2 failWithMessageText: TerniLapilli  invalidMovementErrorMessage inGame: game.
! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:01:00'!
test19XCannotMoveOneStepInDiagonalFrom21To12

	| game |
	game := TerniLapilli new.

	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	" El tablero está en este estado:
	XOX
	- O -
	OX-
	"

	self shouldMoveXFrom: 1@2 to: 2@1 failWithMessageText: TerniLapilli  invalidMovementErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:01:28'!
test20XCannotMoveIfDestinationIsOccupied

	| game |
	game := TerniLapilli new.

	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	" El tablero está en este estado:
	XOX
	- O -
	OX-
	"
	self shouldMoveXFrom: 1@2 to: 2@2 failWithMessageText: TerniLapilli  cannotPlayInOccupiedPositionErrorMessage inGame: game.
! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 18:45:25'!
test21OCannotMoveAStoneThatIsNotPresent

	| game |
	game := TerniLapilli new.

	self should: [
		game moveOFrom: 2@1 to: 3@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli cannotMoveInexistantStoneErrorMessage .

	self deny: (game thereIsOat: 3@1)! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:03:02'!
test22OCannotMoveAStoneBeforeAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.


	self shouldMoveOFrom: 2@1 to: 2@2 failWithMessageText: TerniLapilli  allStonesMustBeOnBoardErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:25:17'!
test23OCanMoveWhenAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 2@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	game moveXFrom: 2@2 to: 3@1.
	game moveOFrom: 2@1 to: 1@1.

	self deny: (game thereIsOat: 2@1).
	self assert: (game thereIsOat: 1@1).
	self assert: game isPlayingX ! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:20:41'!
test24XCannotMoveAnOStone

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	self should: [ game moveXFrom: 2@1 to: 3@1 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli cannotPlayInOccupiedPositionErrorMessage.
	

	self deny: (game thereIsXat: 2@1 ).
	self deny: (game thereIsXat: 3@1 ).
	self assert: (game thereIsOat: 2@1 )! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/16/2019 15:47:44'!
test25OCannotMoveTwoStepsInADirection

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	game moveXFrom: 1@1 to: 2@2.

	self shouldMoveOFrom: 1@2 to: 3@2 failWithMessageText: TerniLapilli  invalidMovementErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:29:36'!
test26OCannotMoveOneStepInDiagonalFromEdgeToEdge

	| game |
	game := TerniLapilli new.

	game putXAt: 2@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	
	game moveXFrom: 1@3 to: 1@2.
	" El tablero está en este estado:
	- OX
	XO -
	OX-
	"
	
	self shouldMoveOFrom: 2@3 to: 3@2 failWithMessageText: TerniLapilli  invalidMovementErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:33:26'!
test27XCannotMoveIfItsNotItsTurn

	| game |
	game := TerniLapilli new.

	game putXAt: 2@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	
	game moveXFrom: 1@3 to: 1@2.
	" El tablero está en este estado:
	- OX
	XO -
	OX-
	"
	
	self shouldMoveXFrom: 2@1 to: 3@1 failWithMessageText: TerniLapilli itIsOTurnErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:42:36'!
test28OCannotMoveIfItsNotItsTurn

	| game |
	game := TerniLapilli new.

	game putXAt: 2@1.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	
	" El tablero está en este estado:
	XOX
	- O -
	OX-
	"
	
	self shouldMoveOFrom: 2@2 to: 3@2 failWithMessageText: TerniLapilli itIsXTurnErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:48:28'!
test29OCannotMoveIfDestinationIsOccupied

	| game |
	game := TerniLapilli new.

	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@1.
	
	game moveXFrom: 3@3 to: 3@2. 
	" El tablero está en este estado:
	XOX
	XO -
	O - -
	"
	self shouldMoveOFrom: 2@2 to: 3@2 failWithMessageText: TerniLapilli  cannotPlayInOccupiedPositionErrorMessage inGame: game.
! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/15/2019 19:51:20'!
test30OCannotMoveAXStone

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	game moveXFrom: 1@1 to: 2@2.

	self should: [ game moveOFrom: 2@2 to: 3@2 ]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli cannotPlayInOccupiedPositionErrorMessage.
	

	self deny: (game thereIsOat: 3@2 ).
	self deny: (game thereIsOat: 2@2 ).
	self assert: (game thereIsXat: 2@2 )! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/16/2019 15:40:48'!
test46XCannotMoveOutOfBounds

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	self shouldMoveXFrom: 1@1 to: 1@0 failWithMessageText: TerniLapilli  positionOutOfBoundsErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'tests - movements' stamp: 'TCM 10/16/2019 15:49:58'!
test47OCannotMoveOutOfBounds

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@2.
	game putOAt: 1@3.

	game moveXFrom: 1@1 to: 2@2.

	self shouldMoveOFrom: 1@3 to: 1@4 failWithMessageText: TerniLapilli  positionOutOfBoundsErrorMessage inGame: game.! !


!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/16/2019 16:56:06'!
test31IsNotOverAfterXPlayed

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	
	self deny: game isOver.
	self assert: game isTied.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:05:06'!
test32XWinsWith3StonesInFirstVerticalLine

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:05:52'!
test33XWinsWith3StonesInSecondVerticalLine

	| game |
	game := TerniLapilli new.

	game putXAt: 2@1.
	game putOAt: 3@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 2@3.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:12:08'!
test34XWinsWith3StonesInThirdVerticalLine

	| game |
	game := TerniLapilli new.

	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 3@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:13:39'!
test35XWinsWith3StonesInHorizontalLine

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 2@1.
	game putOAt: 2@2.
	game putXAt: 3@1.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:26:08'!
test36XWinsWith3StonesInTopRightDiagonal

	| game |
	game := TerniLapilli new.

	game putXAt: 3@3.
	game putOAt: 1@3.
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 1@1.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:29:44'!
test37XWinsWith3StonesInTopLeftDiagonal

	| game |
	game := TerniLapilli new.

	game putXAt: 3@1.
	game putOAt: 3@2.
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:33:57'!
test38OWinsWith3StonesInVerticalLine

	| game |
	game := TerniLapilli new.

	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 3@3.
	game putOAt: 1@2.
	game putXAt: 2@3.
	game putOAt: 1@3.

	
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:49:43'!
test39OWinsWith3StonesInHorizontalLine

	| game |
	game := TerniLapilli new.

	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 3@3.
	game putOAt: 2@1.
	game putXAt: 3@2.
	game putOAt: 3@1.

	
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:51:26'!
test40WinsWith3StonesInTopRightDiagonal

	| game |
	game := TerniLapilli new.

	game putXAt: 2@3.
	game putOAt: 3@3.
	game putXAt: 1@3.
	game putOAt: 2@2.
	game putXAt: 3@1.
	game putOAt: 1@1.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:52:12'!
test41OWinsWith3StonesInTopLeftDiagonal

	| game |
	game := TerniLapilli new.

	game putXAt: 3@3.
	game putOAt: 3@1.
	game putXAt: 3@2.
	game putOAt: 2@2.
	game putXAt: 1@1.
	game putOAt: 1@3.
	
	self assert: game isOver.
	self deny: game isTied.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.

	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 20:57:06'!
test42OCannotPutIfGameIsOver

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	
	self 
		should:  [game putOAt: 3@3 ]
	 	raise:  Error - MessageNotUnderstood 
		withMessageText: TerniLapilli cannotPlayIfGameIsOverErrorMessage.
	
	self deny: (game thereIsOat:  3@3).


	! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 21:02:17'!
test43XCannotMoveIfGameIsOver

	| game |
	game := TerniLapilli new.

	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 3@3.
	game putOAt: 1@2.
	game putXAt: 2@3.
	game putOAt: 1@3.
	
	self shouldMoveXFrom: 2@2 to: 3@2 failWithMessageText: TerniLapilli cannotPlayIfGameIsOverErrorMessage inGame: game! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/15/2019 21:04:16'!
test44OCannotMoveIfGameIsOver

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 1@3.
	game putXAt: 2@3.
	game putOAt: 3@1.

	game moveXFrom: 2@3 to: 3@3.
	
	self shouldMoveOFrom: 3@1 to: 3@2 failWithMessageText: TerniLapilli cannotPlayIfGameIsOverErrorMessage inGame: game! !

!TestTerniLapilli methodsFor: 'tests - game over' stamp: 'TCM 10/16/2019 15:39:11'!
test45NobodyIsPlayingWhenGameHasFinished

	| game |
	game := TerniLapilli new.

	game putXAt: 3@1.
	game putOAt: 3@2.
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	
	self deny: game isPlayingX.
	self deny: game isPlayingO

	! !


!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/10/2019 17:52:11'!
test01WhenGameStartsXPlayerIsTheNext
	| game |
	game := TerniLapilli new.

	self assert: game isPlayingX.
	self deny: game isPlayingO! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/10/2019 17:52:48'!
test02AfterXPlayTheStoneIsOnTheBoardAndNextPlayerIsO
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	
	self assert: (game thereIsXat: 1@1).
	self assert: game isPlayingO.
	self deny: game isPlayingX.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 17:54:03'!
test03WhenGameStartsOPlayerCantPlay
	| game |
	game := TerniLapilli new.

	self should: [
		game putOAt: 1@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli itIsXTurnErrorMessage! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/10/2019 17:52:48'!
test04AfterXAndOPlayInDifferentPlacesBothStonesAreOnTheBoardAndNextPlayerIsX
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	
	self assert: (game thereIsXat: 1@1).
	self assert: (game thereIsOat: 2@1).
	self assert: game isPlayingX.
	self deny: game isPlayingO.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 17:56:04'!
test05OPlayingInTheSamePlaceOfXShouldFailsAndOnlyXStoneIsOnTheBoard
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	self should: [
		game putOAt: 1@1
	] raise: Error - MessageNotUnderstood
	withMessageText: TerniLapilli cannotPlayInOccupiedPositionErrorMessage.
	
	self assert: (game thereIsXat: 1@1).
	self deny: (game thereIsOat: 1@1).
	self assert: game isPlayingO.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 17:58:13'!
test06XPlayerCannotPlayTwiceInARow
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.

	self should: [
		game putXAt: 2@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli  itIsOTurnErrorMessage.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 17:59:33'!
test07PlayingOutOfTopBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 1@4.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 18:00:20'!
test08PlayingOutOfBottomBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 1@-1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 18:00:29'!
test09PlayingOutOfRightBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 4@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 18:00:37'!
test10PlayingOutOfLeftBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: -1@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 18:01:05'!
test11XPuttingMoreThanSixTimesRaisesError
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.
	
	self should: [
		game putXAt: 3@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli  cannotPutMoreThan3StonesErrorMessage! !

!TestTerniLapilli methodsFor: 'tests - putting' stamp: 'TCM 10/15/2019 18:11:59'!
test15OPuttingMoreThanSixTimesRaisesError
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	game moveXFrom: 1@1 to: 2@2.
	
	self should: [
		game putOAt: 3@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli cannotPutMoreThan3StonesErrorMessage .
	
	self deny: (game thereIsOat: 3@1)! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'nextPlayerIsX board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 17:03:57'!
boardIsFull
	^ board size = 6! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:47:41'!
checkAnyColumnFor: aPlayer
	^ ((1 to: 3) anySatisfy:  [  :numberOfColumn | 
		(self checkColumn: numberOfColumn for: aPlayer)
	])! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:47:29'!
checkAnyRowFor: aPlayer
	^ ((1 to: 3) anySatisfy:  [  :numberOfRow | 
		(self checkRow: numberOfRow for: aPlayer)
	])! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:20:48'!
checkColumn: aColumnNumber for: aPlayer 
	^ self checkLine: ((1 to: 3) collect: [ :n | aColumnNumber@n] ) for: aPlayer.! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:36:48'!
checkLine: aPointsCollection for: aPlayer 
	
	^ aPointsCollection allSatisfy: [ :aPoint | self thereIs: aPlayer at: aPoint ]! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:20:38'!
checkRow: aRowNumber for: aPlayer 
	^ self checkLine: ((1 to: 3) collect: [ :n | n@aRowNumber] ) for: aPlayer.! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:34:23'!
checkTopLeftDiagonalFor: aPlayer
	^ self checkLine: ((1 to: 3) collect: [ :n | n@(4-n) ] ) for: aPlayer.
	
! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:22:23'!
checkTopRightDiagonalFor: aPlayer
	^ self checkLine: ((1 to: 3) collect: [ :n | n@n ] ) for: aPlayer.! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:47:41'!
hasPlayerWon: aPlayer
	^ (self checkAnyColumnFor: aPlayer)
		or: (self checkAnyRowFor: aPlayer)
		or: (self checkTopRightDiagonalFor: aPlayer) 
		or: (self checkTopLeftDiagonalFor: aPlayer)
! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/15/2019 17:42:51'!
isEdgePosition: aPosition
	^ aPosition x = 2 xor: aPosition  y = 2.! !

!TerniLapilli methodsFor: 'private - testing' stamp: 'TCM 10/16/2019 16:37:43'!
thereIs: aPlayer at: aPosition 
	^ aPlayer = (board at: aPosition ifAbsent: [ ^ false ])! !


!TerniLapilli methodsFor: 'initialization' stamp: 'TCM 10/16/2019 14:42:34'!
initialize
	nextPlayerIsX := true.
	board := Dictionary new.
	state := TerniLapilliPutsXState new.! !


!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/16/2019 16:30:24'!
hasPlayerOWon
	^ self hasPlayerWon: #O
! !

!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/16/2019 16:30:32'!
hasPlayerXWon
	^ self hasPlayerWon: #X


! !

!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/15/2019 20:04:39'!
isOver
	^ self hasPlayerOWon  or: self hasPlayerXWon .! !

!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:32:41'!
isPlayingO
	^ state isPlayingO.! !

!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:32:52'!
isPlayingX
	^ state isPlayingX.! !

!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/15/2019 20:00:34'!
isTied
	^ self isOver not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/16/2019 16:38:52'!
thereIsOat: aPosition 
	^ self thereIs: #O at: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'TCM 10/16/2019 16:38:39'!
thereIsXat: aPosition 
	^ self thereIs: #X at: aPosition.! !


!TerniLapilli methodsFor: 'private - asserting' stamp: 'TCM 10/16/2019 15:45:44'!
ensureInBounds: aPositionToPut 
	(aPositionToPut  y > 3 or: aPositionToPut  y <= 0 or: aPositionToPut x <= 0 or: aPositionToPut  x > 3)
		ifTrue: [  self error: self class positionOutOfBoundsErrorMessage ] 
! !

!TerniLapilli methodsFor: 'private - asserting' stamp: 'TCM 10/16/2019 16:23:53'!
ensureIsNotAnEdgeToEdgeMovementFrom: anOriginPosition to: aDestinationPosition 

	((anOriginPosition dist: aDestinationPosition) >= 2 
		or: [(self isEdgePosition: anOriginPosition) and: (self isEdgePosition: aDestinationPosition )])
			ifTrue: [ self error: self class invalidMovementErrorMessage ].! !

!TerniLapilli methodsFor: 'private - asserting' stamp: 'TCM 10/16/2019 15:52:54'!
ensurePositionIsEmpty: aPositionToPut 
	board at: aPositionToPut
		ifPresent: [ :play |  self error: self class cannotPlayInOccupiedPositionErrorMessage].
! !

!TerniLapilli methodsFor: 'private - asserting' stamp: 'TCM 10/16/2019 16:10:58'!
ensureThereIsAStoneFromEnemyOf: aPlayer inPosition: aPosition

	board at: aPosition
		ifPresent: [ :elem | elem = aPlayer ifTrue: [self error: self class cannotPlayInOccupiedPositionErrorMessage] ]
		ifAbsent: [ self error: self class cannotMoveInexistantStoneErrorMessage ].
! !

!TerniLapilli methodsFor: 'private - asserting' stamp: 'TCM 10/16/2019 16:13:24'!
ensureThereIsAStoneFromOinPosition: aPosition

	self ensureThereIsAStoneFromEnemyOf: #X inPosition: aPosition
! !

!TerniLapilli methodsFor: 'private - asserting' stamp: 'TCM 10/16/2019 16:13:35'!
ensureThereIsAStoneFromXinPosition: aPosition

	self ensureThereIsAStoneFromEnemyOf: #O inPosition: aPosition
! !

!TerniLapilli methodsFor: 'private - asserting' stamp: 'TCM 10/16/2019 15:45:59'!
ensureValidPosition: aPositionToPut 
	board at: aPositionToPut
		ifPresent: [ :play |  self error: self class cannotPlayInOccupiedPositionErrorMessage].
		
	self ensureInBounds: aPositionToPut 
! !


!TerniLapilli methodsFor: 'private - state' stamp: 'TCM 10/16/2019 14:53:55'!
boardAt: aPosition put: aPlayer
	board at: aPosition  put: aPlayer.! !

!TerniLapilli methodsFor: 'private - state' stamp: 'TCM 10/16/2019 16:28:56'!
boardMoveOFrom: anOriginPosition to: aDestinationPosition 

	self boardAt: aDestinationPosition put: #O.
	board removeKey: anOriginPosition.! !

!TerniLapilli methodsFor: 'private - state' stamp: 'TCM 10/16/2019 16:29:08'!
boardMoveXFrom: anOriginPosition to: aDestinationPosition 

	self boardAt: aDestinationPosition put: #X.
	board removeKey: anOriginPosition.! !

!TerniLapilli methodsFor: 'private - state' stamp: 'TCM 10/16/2019 17:20:26'!
updateState

	state := TerniLapilliState  for: self.! !


!TerniLapilli methodsFor: 'playing' stamp: 'TCM 10/16/2019 17:22:26'!
moveOFrom: anOriginPosition to: aDestinationPosition 

	self ensureThereIsAStoneFromOinPosition: anOriginPosition.
	self ensureIsNotAnEdgeToEdgeMovementFrom: anOriginPosition to: aDestinationPosition.
	self ensureInBounds: aDestinationPosition.
	self ensurePositionIsEmpty: aDestinationPosition.

	state moveOFrom: anOriginPosition to: aDestinationPosition  inGame: self.
	
	self updateState.
	! !

!TerniLapilli methodsFor: 'playing' stamp: 'TCM 10/16/2019 17:22:13'!
moveXFrom: anOriginPosition to: aDestinationPosition 

	self ensureThereIsAStoneFromXinPosition: anOriginPosition.
	self ensureIsNotAnEdgeToEdgeMovementFrom: anOriginPosition to: aDestinationPosition.
	self ensureInBounds: aDestinationPosition.
	self ensurePositionIsEmpty: aDestinationPosition.
	
	state moveXFrom: anOriginPosition to: aDestinationPosition inGame: self.
	
	self updateState.! !

!TerniLapilli methodsFor: 'playing' stamp: 'TCM 10/16/2019 17:22:01'!
putOAt: aPositionToPut 

	self ensurePositionIsEmpty: aPositionToPut.
	self ensureInBounds: aPositionToPut.

	state putOAt: aPositionToPut  inGame: self.
	
	self updateState.! !

!TerniLapilli methodsFor: 'playing' stamp: 'TCM 10/16/2019 17:20:36'!
putXAt: aPositionToPut 

	self ensurePositionIsEmpty: aPositionToPut.
	self ensureInBounds: aPositionToPut.

	state putXAt: aPositionToPut  inGame: self.

	self updateState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 18:06:31'!
allStonesMustBeOnBoardErrorMessage
	^ 'No se puede mover una piedra si no estan todas puestas sobre el tablero'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 18:04:50'!
cannotMoveInexistantStoneErrorMessage
	^ 'No se puede mover una piedra que no existe'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 20:57:41'!
cannotPlayIfGameIsOverErrorMessage
	^ 'No se puede jugar cuando ya termino el juego'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 19:16:05'!
cannotPlayInOccupiedPositionErrorMessage
	^ 'No se puede poner donde hay una piedra'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 18:01:18'!
cannotPutMoreThan3StonesErrorMessage
	^ 'No se pueden poner más de 3 piedras'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 18:08:57'!
invalidMovementErrorMessage
	^ 'No es un movimiento válido'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 17:58:23'!
itIsOTurnErrorMessage
	^  'El jugador X no puede jugar, le toca al jugador O'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 17:54:23'!
itIsXTurnErrorMessage
	^'El jugador O no puede jugar, le toca al jugador X'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'TCM 10/15/2019 17:59:43'!
positionOutOfBoundsErrorMessage
	^ 'La posición está fuera del tablero'! !


!classDefinition: #TerniLapilliState category: #'Terni Lapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliState methodsFor: 'testing' stamp: 'TCM 10/16/2019 16:49:29'!
isPlayingO
	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'testing' stamp: 'TCM 10/16/2019 16:49:34'!
isPlayingX
	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'playing' stamp: 'TCM 10/16/2019 16:49:41'!
moveOFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'playing' stamp: 'TCM 10/16/2019 16:49:48'!
moveXFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'playing' stamp: 'TCM 10/16/2019 16:49:59'!
putOAt: aPositionToPut  inGame: aGame
	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'playing' stamp: 'TCM 10/16/2019 16:50:09'!
putXAt: aPositionToPut  inGame: aGame
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'Terni Lapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'testing' stamp: 'TCM 10/16/2019 17:08:24'!
isFor: aGame
	self subclassResponsibility.! !


!TerniLapilliState class methodsFor: 'instance creation' stamp: 'TCM 10/16/2019 17:21:34'!
for: aGame
	^ (self subclasses detect: [ :subclass | subclass isFor: aGame ]) new.! !


!classDefinition: #TerniLapilliGameOverState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliGameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameOverState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:35:52'!
isPlayingO
	^ false! !

!TerniLapilliGameOverState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:35:56'!
isPlayingX
	^ false! !


!TerniLapilliGameOverState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:30:16'!
moveOFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli cannotPlayIfGameIsOverErrorMessage! !

!TerniLapilliGameOverState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:19:27'!
moveXFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli cannotPlayIfGameIsOverErrorMessage! !

!TerniLapilliGameOverState methodsFor: 'playing' stamp: 'TCM 10/16/2019 16:49:54'!
putOAt: aPositionToPut  inGame: aGame
	self error: TerniLapilli cannotPlayIfGameIsOverErrorMessage! !

!TerniLapilliGameOverState methodsFor: 'playing' stamp: 'TCM 10/16/2019 16:50:04'!
putXAt: aPositionToPut  inGame: aGame
	self error: TerniLapilli cannotPlayIfGameIsOverErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameOverState class' category: #'Terni Lapilli'!
TerniLapilliGameOverState class
	instanceVariableNames: ''!

!TerniLapilliGameOverState class methodsFor: 'testing' stamp: 'TCM 10/16/2019 17:08:50'!
isFor: aGame
	^ aGame isOver ! !


!classDefinition: #TerniLapilliMovesOState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliMovesOState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliMovesOState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:35:40'!
isPlayingO
	^ true! !

!TerniLapilliMovesOState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:35:46'!
isPlayingX
	^ false! !


!TerniLapilliMovesOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:29:26'!
moveOFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	aGame boardMoveOFrom: anOriginPosition to: aDestinationPosition ! !

!TerniLapilliMovesOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:20:03'!
moveXFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli itIsOTurnErrorMessage! !

!TerniLapilliMovesOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:03:28'!
putOAt: aPositionToPut  inGame: aGame.
	self error: TerniLapilli cannotPutMoreThan3StonesErrorMessage! !

!TerniLapilliMovesOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 14:59:44'!
putXAt: aPositionToPut  inGame: aGame.
	self error: TerniLapilli itIsOTurnErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliMovesOState class' category: #'Terni Lapilli'!
TerniLapilliMovesOState class
	instanceVariableNames: ''!

!TerniLapilliMovesOState class methodsFor: 'testing' stamp: 'TCM 10/16/2019 17:16:55'!
isFor: aGame
	^ aGame isOver not and: aGame boardIsFull and: aGame isPlayingX.! !


!classDefinition: #TerniLapilliMovesXState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliMovesXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliMovesXState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:34:55'!
isPlayingO
	^ false! !

!TerniLapilliMovesXState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:35:00'!
isPlayingX
	^ true! !


!TerniLapilliMovesXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:29:09'!
moveOFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli itIsXTurnErrorMessage! !

!TerniLapilliMovesXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:23:00'!
moveXFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	aGame boardMoveXFrom: anOriginPosition to: aDestinationPosition ! !

!TerniLapilliMovesXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:02:45'!
putOAt: aPositionToPut  inGame: aGame.
	self error: TerniLapilli itIsXTurnErrorMessage! !

!TerniLapilliMovesXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 14:59:51'!
putXAt: aPositionToPut  inGame: aGame.	
	self error: TerniLapilli cannotPutMoreThan3StonesErrorMessage 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliMovesXState class' category: #'Terni Lapilli'!
TerniLapilliMovesXState class
	instanceVariableNames: ''!

!TerniLapilliMovesXState class methodsFor: 'testing' stamp: 'TCM 10/16/2019 17:17:16'!
isFor: aGame
	^ aGame isOver not and: aGame boardIsFull and: aGame isPlayingO.! !


!classDefinition: #TerniLapilliPutsOState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliPutsOState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPutsOState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:34:41'!
isPlayingO
	^ true! !

!TerniLapilliPutsOState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:34:47'!
isPlayingX
	^ false! !


!TerniLapilliPutsOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:28:46'!
moveOFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli allStonesMustBeOnBoardErrorMessage! !

!TerniLapilliPutsOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:19:10'!
moveXFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli allStonesMustBeOnBoardErrorMessage! !

!TerniLapilliPutsOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:02:16'!
putOAt: aPositionToPut  inGame: aGame.	
	aGame boardAt: aPositionToPut put: #O! !

!TerniLapilliPutsOState methodsFor: 'playing' stamp: 'TCM 10/16/2019 14:59:31'!
putXAt: aPositionToPut  inGame: aGame.
	self error: TerniLapilli itIsOTurnErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPutsOState class' category: #'Terni Lapilli'!
TerniLapilliPutsOState class
	instanceVariableNames: ''!

!TerniLapilliPutsOState class methodsFor: 'testing' stamp: 'TCM 10/16/2019 17:17:26'!
isFor: aGame
	^ aGame isOver not and: aGame boardIsFull not and: aGame isPlayingX.! !


!classDefinition: #TerniLapilliPutsXState category: #'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliPutsXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPutsXState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:34:31'!
isPlayingO
	^ false! !

!TerniLapilliPutsXState methodsFor: 'testing' stamp: 'TCM 10/16/2019 15:34:24'!
isPlayingX
	^ true! !


!TerniLapilliPutsXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:28:38'!
moveOFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli allStonesMustBeOnBoardErrorMessage! !

!TerniLapilliPutsXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:18:53'!
moveXFrom: anOriginPosition to: aDestinationPosition inGame: aGame
	self error: TerniLapilli allStonesMustBeOnBoardErrorMessage! !

!TerniLapilliPutsXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 15:02:32'!
putOAt: aPositionToPut  inGame: aGame.
	self error: TerniLapilli itIsXTurnErrorMessage! !

!TerniLapilliPutsXState methodsFor: 'playing' stamp: 'TCM 10/16/2019 14:54:03'!
putXAt: aPositionToPut  inGame: aGame.	
	aGame boardAt: aPositionToPut put: #X.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPutsXState class' category: #'Terni Lapilli'!
TerniLapilliPutsXState class
	instanceVariableNames: ''!

!TerniLapilliPutsXState class methodsFor: 'testing' stamp: 'TCM 10/16/2019 17:17:47'!
isFor: aGame
	^ aGame isOver not and: aGame boardIsFull not and: aGame isPlayingO.! !
