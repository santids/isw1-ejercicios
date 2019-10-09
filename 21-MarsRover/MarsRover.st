!classDefinition: #TestMarsRover category: #MarsRover!
TestCase subclass: #TestMarsRover
	instanceVariableNames: 'east west south north'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'setUp/tearDown' stamp: 's.d 10/8/2019 19:18:44'!
setUp
  east := EastDirection new.
  west := WestDirection new.
  south := SouthDirection new.
  north := NorthDirection new.! !


!TestMarsRover methodsFor: 'testing - mixing instructions' stamp: 's.d 10/8/2019 20:44:55'!
test16MoveForwardThenBackwardsAdvancesTheDifference

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'fffbb'.
	
	self assert: 1@0 equals: rover position.
	self assert: south equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - mixing instructions' stamp: 's.d 10/8/2019 20:44:55'!
test17MoveForwardThenBackwardsThenRotateAdvancesTheDifferenceAndIsInTheCorrectDirection

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'fffbbr'.
	
	self assert: 1@0 equals: rover position.
	self assert: west equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - mixing instructions' stamp: 's.d 10/8/2019 20:44:55'!
test18RotateForwardAndBackwardShouldAdvanceTheDifferenceInTheCorrectDirection

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'lfffbb'.
	
	self assert: 2@1 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - mixing instructions' stamp: 's.d 10/8/2019 20:44:55'!
test19ComplexPath

	| rover |
	rover _ MarsRover at: 2@1 withDirection: north .
	
	rover do: 'ffrfbblblllff'.
	
	self assert: 3@2 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - mixing instructions' stamp: 's.d 10/8/2019 21:23:26'!
test20InvalidCharInstructionShouldRaiseExceptionAndStop

	| rover |
	rover _ MarsRover at: 2@1 withDirection: east .
	
	self should: [
		rover do: 'fffxfffrr'.
	] raise: Error - MessageNotUnderstood 
	  withMessageText: (MarsRover invalidInstructionMessage: $x).


	self assert: 5@1 equals: rover position.
	self assert: east equals: rover direction.! !


!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test08RotateToLeftPointingNorthShouldPointWest

	| rover |
	rover _ MarsRover at: 1@1 withDirection: north .
	
	rover do: 'l'.
	
	self assert: 1@1 equals: rover position.
	self assert: west equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test09RotateToRightPointingNorthShouldPointEast

	| rover |
	rover _ MarsRover at: 1@1 withDirection: north .
	
	rover do: 'r'.
	
	self assert: 1@1 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test10RotateToLeftPointingWestShouldPointSouth

	| rover |
	rover _ MarsRover at: 1@1 withDirection: west .
	
	rover do: 'l'.
	
	self assert: 1@1 equals: rover position.
	self assert: south equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test11RotateToRightPointingWestShouldPointNorth

	| rover |
	rover _ MarsRover at: 1@1 withDirection: west .
	
	rover do: 'r'.
	
	self assert: 1@1 equals: rover position.
	self assert: north equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test12RotateToLeftPointingSouthShouldPointEast

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'l'.
	
	self assert: 1@1 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test13RotateToRightPointingSouthShouldPointWest

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'r'.
	
	self assert: 1@1 equals: rover position.
	self assert: west equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test14RotateToRightTwicePointingSouthShouldPointNorth

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'rr'.
	
	self assert: 1@1 equals: rover position.
	self assert: north equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed rotation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test15RotateToLeftTwicePointingSouthShouldPointNorth

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'll'.
	
	self assert: 1@1 equals: rover position.
	self assert: north equals: rover direction.! !


!TestMarsRover methodsFor: 'testing - unmixed translation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test01EmptyInstructionThenSamePositionAndDirection

	| rover |
	rover _ MarsRover at: 1@1 withDirection: east .
	
	rover do: ''.
	
	self assert: 1@1 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed translation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test02OneForwardInstructionAdvancesInTheSameDirection

	| rover |
	rover _ MarsRover at: 1@1 withDirection: east .
	
	rover do: 'f'.
	
	self assert: 2@1 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed translation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test03ManyForwardInstructionsAdvanceTheSameAmountInTheSameDirection

	| rover |
	rover _ MarsRover at: 1@1 withDirection: east .
	
	rover do: 'fff'.
	
	self assert: 4@1 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed translation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test04ManyBackwardInstructionsMovesAgainstDirection

	| rover |
	rover _ MarsRover at: 1@1 withDirection: east .
	
	rover do: 'bbb'.
	
	self assert: -2@1 equals: rover position.
	self assert: east equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed translation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test05ForwardInNorthDirectionAdvancesToTheNorth

	| rover |
	rover _ MarsRover at: 1@1 withDirection: north .
	
	rover do: 'fff'.
	
	self assert: 1@4 equals: rover position.
	self assert: north equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed translation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test06ForwardInWestDirectionAdvancesToTheWest

	| rover |
	rover _ MarsRover at: 1@1 withDirection: west .
	
	rover do: 'fff'.
	
	self assert: -2@1 equals: rover position.
	self assert: west equals: rover direction.! !

!TestMarsRover methodsFor: 'testing - unmixed translation instructions' stamp: 's.d 10/8/2019 20:44:55'!
test07ForwardInSouthDirectionAdvancesToTheSouth

	| rover |
	rover _ MarsRover at: 1@1 withDirection: south .
	
	rover do: 'fff'.
	
	self assert: 1@-2 equals: rover position.
	self assert: south equals: rover direction.! !


!classDefinition: #Direction category: #MarsRover!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'converting' stamp: 's.d 10/8/2019 19:32:10'!
asVector
	self subclassResponsibility ! !


!Direction methodsFor: 'comparing' stamp: 's.d 10/8/2019 19:23:17'!
= anotherDirection
	^ anotherDirection isMemberOf: self class.! !


!Direction methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:09:39'!
left
	self subclassResponsibility ! !

!Direction methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:10:53'!
right
	self subclassResponsibility ! !


!classDefinition: #EastDirection category: #MarsRover!
Direction subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastDirection methodsFor: 'converting' stamp: 's.d 10/8/2019 19:32:52'!
asVector
	^ 1 @ 0! !


!EastDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:10:40'!
left
	^ NorthDirection new.! !

!EastDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:11:07'!
right
	^ SouthDirection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastDirection class' category: #MarsRover!
EastDirection class
	instanceVariableNames: 'uniqueInstance'!

!EastDirection class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:56:43'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	
! !


!classDefinition: #NorthDirection category: #MarsRover!
Direction subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:11:37'!
left
	^ WestDirection new.! !

!NorthDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:11:25'!
right
	^ EastDirection new.! !


!NorthDirection methodsFor: 'converting' stamp: 's.d 10/8/2019 19:33:04'!
asVector
	^ 0 @ 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthDirection class' category: #MarsRover!
NorthDirection class
	instanceVariableNames: 'uniqueInstance'!

!NorthDirection class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:57:10'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	! !


!classDefinition: #SouthDirection category: #MarsRover!
Direction subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthDirection methodsFor: 'converting' stamp: 's.d 10/8/2019 19:33:17'!
asVector
	^ 0 @ -1! !


!SouthDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:11:57'!
left
	^ EastDirection new.! !

!SouthDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:12:14'!
right
	^ WestDirection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthDirection class' category: #MarsRover!
SouthDirection class
	instanceVariableNames: 'uniqueInstance'!

!SouthDirection class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:57:21'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	! !


!classDefinition: #WestDirection category: #MarsRover!
Direction subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestDirection methodsFor: 'converting' stamp: 's.d 10/8/2019 19:33:27'!
asVector
	^ -1 @ 0! !


!WestDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:12:30'!
left
	^ SouthDirection new.! !

!WestDirection methodsFor: 'accesing' stamp: 's.d 10/8/2019 19:12:39'!
right
	^ NorthDirection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestDirection class' category: #MarsRover!
WestDirection class
	instanceVariableNames: 'uniqueInstance'!

!WestDirection class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:57:42'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	! !


!classDefinition: #IndividualInstruction category: #MarsRover!
Object subclass: #IndividualInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!IndividualInstruction methodsFor: 'executing' stamp: 's.d 10/8/2019 20:16:08'!
executeOn: aMarsRover
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IndividualInstruction class' category: #MarsRover!
IndividualInstruction class
	instanceVariableNames: ''!

!IndividualInstruction class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 21:25:33'!
for: aCharInstruction
	^ (self subclasses detect: [ :subclass | subclass isFor: aCharInstruction ] ifNone: [ self error: (MarsRover invalidInstructionMessage: aCharInstruction )]) new.! !


!IndividualInstruction class methodsFor: 'testing' stamp: 's.d 10/8/2019 20:30:31'!
isFor: aCharInstruction
	self subclassResponsibility ! !


!classDefinition: #MoveBackwardInstruction category: #MarsRover!
IndividualInstruction subclass: #MoveBackwardInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwardInstruction methodsFor: 'executing' stamp: 's.d 10/8/2019 20:18:29'!
executeOn: aMarsRover
	aMarsRover moveBackwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwardInstruction class' category: #MarsRover!
MoveBackwardInstruction class
	instanceVariableNames: 'uniqueInstance'!

!MoveBackwardInstruction class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:58:00'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	! !


!MoveBackwardInstruction class methodsFor: 'testing' stamp: 's.d 10/8/2019 20:22:05'!
isFor: aCharInstruction
	^ aCharInstruction = $b! !


!classDefinition: #MoveForwardInstruction category: #MarsRover!
IndividualInstruction subclass: #MoveForwardInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForwardInstruction methodsFor: 'executing' stamp: 's.d 10/8/2019 20:18:52'!
executeOn: aMarsRover
	aMarsRover moveForward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwardInstruction class' category: #MarsRover!
MoveForwardInstruction class
	instanceVariableNames: 'uniqueInstance'!

!MoveForwardInstruction class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:58:24'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	! !


!MoveForwardInstruction class methodsFor: 'testing' stamp: 's.d 10/8/2019 20:22:14'!
isFor: aCharInstruction
	^ aCharInstruction = $f! !


!classDefinition: #RotateLeftInstruction category: #MarsRover!
IndividualInstruction subclass: #RotateLeftInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeftInstruction methodsFor: 'executing' stamp: 's.d 10/8/2019 20:19:05'!
executeOn: aMarsRover
	aMarsRover rotateLeft! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftInstruction class' category: #MarsRover!
RotateLeftInstruction class
	instanceVariableNames: 'uniqueInstance'!

!RotateLeftInstruction class methodsFor: 'testing' stamp: 's.d 10/8/2019 20:22:22'!
isFor: aCharInstruction
	^ aCharInstruction = $l! !


!RotateLeftInstruction class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:58:37'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	! !


!classDefinition: #RotateRightInstruction category: #MarsRover!
IndividualInstruction subclass: #RotateRightInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRightInstruction methodsFor: 'executing' stamp: 's.d 10/8/2019 20:19:18'!
executeOn: aMarsRover
	aMarsRover rotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightInstruction class' category: #MarsRover!
RotateRightInstruction class
	instanceVariableNames: 'uniqueInstance'!

!RotateRightInstruction class methodsFor: 'testing' stamp: 's.d 10/8/2019 20:22:28'!
isFor: aCharInstruction
	^ aCharInstruction = $r! !


!RotateRightInstruction class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:58:56'!
new

	uniqueInstance ifNil: [ uniqueInstance := self basicNew  ].
	^ uniqueInstance.
	! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'instance creation' stamp: 's.d 10/3/2019 21:10:06'!
initializeAtPosition: aPoint andDirection: aDirection  
	position := aPoint.
	direction := aDirection! !


!MarsRover methodsFor: 'executing' stamp: 's.d 10/8/2019 20:23:47'!
do: aStringInstruction

     aStringInstruction do: [ :aCharInstruction |
		(IndividualInstruction for: aCharInstruction ) executeOn: self.
	].
! !


!MarsRover methodsFor: 'accessing' stamp: 's.d 10/3/2019 21:07:46'!
direction
	^ direction.! !

!MarsRover methodsFor: 'accessing' stamp: 's.d 10/3/2019 20:18:04'!
position
	^position! !


!MarsRover methodsFor: 'movements' stamp: 's.d 10/8/2019 20:25:30'!
moveBackwards
	position := position - direction asVector.! !

!MarsRover methodsFor: 'movements' stamp: 's.d 10/8/2019 20:24:53'!
moveForward
		position := position + direction asVector.! !

!MarsRover methodsFor: 'movements' stamp: 's.d 10/8/2019 20:25:59'!
rotateLeft
	direction := direction left.! !

!MarsRover methodsFor: 'movements' stamp: 's.d 10/8/2019 20:26:30'!
rotateRight
	direction := direction right.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 's.d 10/8/2019 20:44:55'!
at: aPoint withDirection: aDirection    
	^ self new initializeAtPosition: aPoint andDirection: aDirection.! !


!MarsRover class methodsFor: 'error messages' stamp: 's.d 10/8/2019 21:13:39'!
invalidInstructionMessage: aCharacter 
	^ aCharacter  asString, ' is an invalid instruction'.! !
