!classDefinition: #TestTerniLapilli category: #'Terni Lapilli'!
TestCase subclass: #TestTerniLapilli
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:29'!
test03WhenGameStartsOPlayerCantPlay
	| game |
	game := TerniLapilli new.

	self should: [
		game putOAt: 1@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'El jugador O no puede jugar, le toca al jugador X'! !

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

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:28:13'!
test05OPlayingInTheSamePlaceOfXShouldFailsAndOnlyXStoneIsOnTheBoard
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	self should: [
		game putOAt: 1@1
	] raise: Error - MessageNotUnderstood
	withMessageText: 'No se puede poner donde ya se jugo'.
	
	self assert: (game thereIsXat: 1@1).
	self deny: (game thereIsOat: 1@1).
	self assert: game isPlayingO.! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:39:16'!
test06XPlayerCannotPlayTwiceInARow
	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.

	self should: [
		game putXAt: 2@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'El jugador X no puede jugar, le toca al jugador O'! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:48:13'!
test07PlayingOutOfTopBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 1@4.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'La posición está fuera del tablero'! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:53:07'!
test08PlayingOutOfBottomBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 1@-1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'La posición está fuera del tablero'! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:53:34'!
test09PlayingOutOfRightBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: 4@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'La posición está fuera del tablero'! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:54:38'!
test10PlayingOutOfLeftBoundRaisesError
	| game |
	game := TerniLapilli new.

	self should: [
		game putXAt: -1@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'La posición está fuera del tablero'! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 21:02:12'!
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
	withMessageText: 'No se pueden poner más de 3 piedras'! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 20:31:13'!
test12CannotMoveAStoneThatIsNotPresent

	| game |
	game := TerniLapilli new.

	self should: [
		game moveXFrom: 2@1 to: 3@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'No se puede mover una piedra que no existe'.

	self deny: (game thereIsXat: 3@1)! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 20:34:52'!
test13CannotMoveAStoneBeforeAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.

	self should: [
		game moveXFrom: 1@1 to: 2@1.
	] raise: Error - MessageNotUnderstood 
	withMessageText: 'No se puede mover una piedra si no estan todas puestas sobre el tablero'.

	self assert: (game thereIsXat: 1@1).
	self deny: (game thereIsXat: 2@1)! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 21:00:23'!
test14XCanMoveWhenAllStonesHaveBeenPut

	| game |
	game := TerniLapilli new.

	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 2@3.
	game putXAt: 1@3.
	game putOAt: 1@2.

	game moveXFrom: 2@1 to: 3@1.

	self deny: (game thereIsXat: 2@1).
	self assert: (game thereIsXat: 3@1)! !

!TestTerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 21:05:04'!
test15YPuttingMoreThanSixTimesRaisesError
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
	withMessageText: 'No se pueden poner más de 3 piedras'.
	
	self deny: (game thereIsOat: 3@1)! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'nextPlayerIsX board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:54:11'!
ensureValidPosition: aPositionToPut 
	board at: aPositionToPut
		ifPresent: [ :play |  self error: 'No se puede poner donde ya se jugo' ].
		
	(aPositionToPut  y > 3 or: aPositionToPut  y <= 0 or: aPositionToPut x <= 0 or: aPositionToPut  x > 3)
		ifTrue: [  self error: 'La posición está fuera del tablero'  ] 
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:19:53'!
initialize
	nextPlayerIsX := true.
	board := Dictionary new.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:11'!
isPlayingO
	^ self isPlayingX not! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 17:52:11'!
isPlayingX
	^ nextPlayerIsX! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 21:06:18'!
moveXFrom: anOriginPosition to: aDestinationPosition 

	board at: anOriginPosition ifAbsent: [self error: 'No se puede mover una piedra que no existe'].
	board size <= 5 ifTrue: [ self error: 'No se puede mover una piedra si no estan todas puestas sobre el tablero'].

	nextPlayerIsX := false.

	board removeKey: anOriginPosition.
	board at: aDestinationPosition put: #X! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 21:06:45'!
putOAt: aPositionToPut 
	nextPlayerIsX ifTrue: [self error: 'El jugador O no puede jugar, le toca al jugador X'].

	self ensureValidPosition:  aPositionToPut .

	board size >= 6 ifTrue: [ self error: 'No se pueden poner más de 3 piedras' ].

	board at: aPositionToPut put: #O.
	nextPlayerIsX := true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 20:22:20'!
putXAt: aPositionToPut 
	nextPlayerIsX ifFalse: [self error: 'El jugador X no puede jugar, le toca al jugador O'].


	self ensureValidPosition:  aPositionToPut .
	
	board size >= 6 ifTrue: [ self error: 'No se pueden poner más de 3 piedras' ].


	board at: aPositionToPut put: #X.
	nextPlayerIsX := false.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:34:49'!
thereIsOat: aPosition 
	^ #O = (board at: aPosition ifAbsent: [ ^ false ])! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'TCM 10/10/2019 18:35:04'!
thereIsXat: aPosition 
	^ #X = (board at: aPosition ifAbsent: [ ^ false ])! !
