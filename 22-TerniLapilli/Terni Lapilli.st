!classDefinition: #TestTerniLapilli category: #'Terni Lapilli'!
TestCase subclass: #TestTerniLapilli
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:04:42'!
shouldMoveOFrom: aSourcePosition to: aDestinationPosition failWithMessageText: anErrorMessageText inGame: aGame

	self should: [ aGame moveOFrom: aSourcePosition to: aDestinationPosition ]
		raise: Error - MessageNotUnderstood
		withMessageText: anErrorMessageText.
	

	self deny: (aGame thereIsOat: aDestinationPosition ).
	self assert: (aGame thereIsOat: aSourcePosition )! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:59:45'!
shouldMoveXFrom: aSourcePosition to: aDestinationPosition failWithMessageText: anErrorMessageText inGame: aGame

	self should: [ aGame moveXFrom: aSourcePosition to: aDestinationPosition ]
		raise: Error - MessageNotUnderstood
		withMessageText: anErrorMessageText.
	

	self deny: (aGame thereIsXat: aDestinationPosition ).
	self assert: (aGame thereIsXat: aSourcePosition )! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:11'!
test01WhenGameStartsXPlayerIsTheNext
	| game |
	game := TerniLapilli new.

	self assert: game isPlayingX.
	self deny: game isPlayingO! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:48'!
test02AfterXPlayTheStoneIsOnTheBoardAndNextPlayerIsO
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	
	self assert: (game thereIsXat: 1@1).
	self assert: game isPlayingO.
	self deny: game isPlayingX.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:54:03'!
test03WhenGameStartsOPlayerCantPlay
	| game |
	game := TerniLapilli new.

	self should: [
		game putOAt: 1@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli itIsXTurnErrorMessage! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:48'!
test04AfterXAndOPlayInDifferentPlacesBothStonesAreOnTheBoardAndNextPlayerIsX
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	
	self assert: (game thereIsXat: 1@1).
	self assert: (game thereIsOat: 2@1).
	self assert: game isPlayingX.
	self deny: game isPlayingO.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:56:04'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:58:13'!
test06XPlayerCannotPlayTwiceInARow
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.

	self should: [
		game putXAt: 2@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli  itIsOTurnErrorMessage.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:59:33'!
test07PlayingOutOfTopBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 1@4.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:00:20'!
test08PlayingOutOfBottomBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 1@-1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:00:29'!
test09PlayingOutOfRightBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 4@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:00:37'!
test10PlayingOutOfLeftBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: -1@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli positionOutOfBoundsErrorMessage.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:01:05'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:04:10'!
test12XCannotMoveAStoneThatIsNotPresent

	| game |
	game := TerniLapilli new.

	self should: [
		game moveXFrom: 2@1 to: 3@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli cannotMoveInexistantStoneErrorMessage.

	self deny: (game thereIsXat: 3@1)! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:59:45'!
test13XCannotMoveAStoneBeforeAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.


	self shouldMoveXFrom: 1@1 to: 2@1 failWithMessageText: TerniLapilli  allStonesMustBeOnBoardErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:24:58'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:11:59'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:59:45'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:00:20'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:00:41'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:01:00'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:01:28'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:45:25'!
test21OCannotMoveAStoneThatIsNotPresent

	| game |
	game := TerniLapilli new.

	self should: [
		game moveOFrom: 2@1 to: 3@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli cannotMoveInexistantStoneErrorMessage .

	self deny: (game thereIsOat: 3@1)! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:03:02'!
test22OCannotMoveAStoneBeforeAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.


	self shouldMoveOFrom: 2@1 to: 2@2 failWithMessageText: TerniLapilli  allStonesMustBeOnBoardErrorMessage inGame: game.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:25:17'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:20:41'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:23:03'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:29:36'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:33:26'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:42:36'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:48:28'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:51:20'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:59:07'!
test31HasNotAfterXPlayed

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	
	self deny: game isOver.
	self assert: game isTied.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.

	! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:05:06'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:05:52'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:12:08'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:13:39'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:26:08'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:29:44'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:33:57'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:49:43'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:51:26'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:52:12'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:57:06'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 21:02:17'!
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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 21:04:16'!
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


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'nextPlayerIsX board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:42:20'!
checkColumn: aColumnNumber for: aPlayer 

	((1 to: 3)do: [ :n | 	 
		board at: aColumnNumber@n 
			ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] 
			ifAbsent: [ ^false ].
		]).
	
	^ true
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:44:39'!
checkRow: aRowNumber for: aPlayer 
	
	((1 to: 3)do: [ :n | 	 
		board at: n@aRowNumber 
			ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] 
			ifAbsent: [ ^false ].
		]).
	
	^ true! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:48:00'!
checkTopLeftDiagonalFor: aPlayer
	board at: 1@3 ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] ifAbsent: [ ^false ].
	board at: 2@2 ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] ifAbsent: [ ^false ].
	board at: 3@1 ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] ifAbsent: [ ^false ].
	
	^ true! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:48:30'!
checkTopRightDiagonalFor: aPlayer
	board at: 1@1 ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] ifAbsent: [ ^false ].
	board at: 2@2 ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] ifAbsent: [ ^false ].
	board at: 3@3 ifPresent: [ :elem | elem = aPlayer  ifFalse: [ ^ false] ] ifAbsent: [ ^false ].
	
	^ true! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:00:01'!
ensureValidPosition: aPositionToPut 
	board at: aPositionToPut
		ifPresent: [ :play |  self error: self class cannotPlayInOccupiedPositionErrorMessage].
		
	(aPositionToPut  y > 3 or: aPositionToPut  y <= 0 or: aPositionToPut x <= 0 or: aPositionToPut  x > 3)
		ifTrue: [  self error: self class positionOutOfBoundsErrorMessage ] 
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:52:26'!
hasPlayerOWon
	^ ((1 to: 3) inject: false into: [ :a :n | 
		a or: (self checkColumn: n for: #O) or: (self checkRow: n for: #O)
	])
		or: (self checkTopRightDiagonalFor: #O) 
		or: (self checkTopLeftDiagonalFor: #O)
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:48:21'!
hasPlayerXWon
	^ ((1 to: 3) inject: false into: [ :a :n | 
		a or: (self checkColumn: n for: #X) or: (self checkRow: n for: #X)
	]) 
		or: (self checkTopRightDiagonalFor: #X) 
		or: (self checkTopLeftDiagonalFor: #X)


! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:19:53'!
initialize
	nextPlayerIsX := true.
	board := Dictionary new.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:42:51'!
isEdgePosition: aPosition
	^ aPosition x = 2 xor: aPosition  y = 2.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:04:39'!
isOver
	^ self hasPlayerOWon  or: self hasPlayerXWon .! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:11'!
isPlayingO
	^ self isPlayingX not! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:11'!
isPlayingX
	^ nextPlayerIsX! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:00:34'!
isTied
	^ self isOver not.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 21:04:31'!
moveOFrom: anOriginPosition to: aDestinationPosition 

	board at: anOriginPosition
		ifPresent: [ :elem | elem = #X ifTrue: [self error: self class cannotPlayInOccupiedPositionErrorMessage] ]
		ifAbsent: [ self error: self class cannotMoveInexistantStoneErrorMessage ].
	board size <= 5 ifTrue: [ self error: self class allStonesMustBeOnBoardErrorMessage ].
	self isOver  ifTrue:  [ self error: self class cannotPlayIfGameIsOverErrorMessage ].
	
	((anOriginPosition dist: aDestinationPosition) >= 2 
		or: [(self isEdgePosition: anOriginPosition) and: (self isEdgePosition: aDestinationPosition )])
			ifTrue: [ self error: self class invalidMovementErrorMessage ].
	nextPlayerIsX  ifTrue: [ self error: self class itIsXTurnErrorMessage ].
	
	nextPlayerIsX := true.

	board
		at: aDestinationPosition 
		ifPresent: [ :elem | self error: self class cannotPlayInOccupiedPositionErrorMessage ]
		ifAbsent: [ board at: aDestinationPosition put: #O ].
		
	board removeKey: anOriginPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 21:00:59'!
moveXFrom: anOriginPosition to: aDestinationPosition 

	board at: anOriginPosition
		ifPresent: [ :elem | elem = #O ifTrue: [self error: self class cannotPlayInOccupiedPositionErrorMessage] ]
		ifAbsent: [self error: self class cannotMoveInexistantStoneErrorMessage ].
	board size <= 5 ifTrue: [ self error: self class allStonesMustBeOnBoardErrorMessage ].
	self isOver  ifTrue:  [ self error: self class cannotPlayIfGameIsOverErrorMessage ].

	((anOriginPosition dist: aDestinationPosition) >= 2 
		or: [(self isEdgePosition: anOriginPosition) and: (self isEdgePosition: aDestinationPosition )])
			ifTrue: [ self error: self class invalidMovementErrorMessage ].
	nextPlayerIsX  ifFalse: [ self error: self class itIsOTurnErrorMessage ].

	nextPlayerIsX := false.

	board 
		at: aDestinationPosition
		ifPresent: [ :elem | self error: self class cannotPlayInOccupiedPositionErrorMessage ] 
		ifAbsent: [ board at: aDestinationPosition put: #X ].

	board removeKey: anOriginPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:58:29'!
putOAt: aPositionToPut 
	nextPlayerIsX ifTrue: [self error: self class itIsXTurnErrorMessage ].
	self isOver  ifTrue:  [ self error: self class cannotPlayIfGameIsOverErrorMessage ].

	self ensureValidPosition:  aPositionToPut .

	board size >= 6 ifTrue: [ self error: self class cannotPutMoreThan3StonesErrorMessage ].

	board at: aPositionToPut put: #O.
	nextPlayerIsX := true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:02:43'!
putXAt: aPositionToPut 
	nextPlayerIsX ifFalse: [self error: self class itIsOTurnErrorMessage ].


	self ensureValidPosition:  aPositionToPut .
	
	board size >= 6 ifTrue: [ self error: self class cannotPutMoreThan3StonesErrorMessage ].


	board at: aPositionToPut put: #X.
	nextPlayerIsX := false.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:34:49'!
thereIsOat: aPosition 
	^ #O = (board at: aPosition ifAbsent: [ ^ false ])! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:35:04'!
thereIsXat: aPosition 
	^ #X = (board at: aPosition ifAbsent: [ ^ false ])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:06:31'!
allStonesMustBeOnBoardErrorMessage
	^ 'No se puede mover una piedra si no estan todas puestas sobre el tablero'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:04:50'!
cannotMoveInexistantStoneErrorMessage
	^ 'No se puede mover una piedra que no existe'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 20:57:41'!
cannotPlayIfGameIsOverErrorMessage
	^ 'No se puede jugar cuando ya termino el juego'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 19:16:05'!
cannotPlayInOccupiedPositionErrorMessage
	^ 'No se puede poner donde hay una piedra'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:01:18'!
cannotPutMoreThan3StonesErrorMessage
	^ 'No se pueden poner más de 3 piedras'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 18:08:57'!
invalidMovementErrorMessage
	^ 'No es un movimiento válido'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:58:23'!
itIsOTurnErrorMessage
	^  'El jugador X no puede jugar, le toca al jugador O'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:54:23'!
itIsXTurnErrorMessage
	^'El jugador O no puede jugar, le toca al jugador X'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'TCM 10/15/2019 17:59:43'!
positionOutOfBoundsErrorMessage
	^ 'La posición está fuera del tablero'! !
