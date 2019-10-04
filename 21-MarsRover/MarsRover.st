!classDefinition: #TestMarsRover category: #MarsRover!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 's.d 10/3/2019 21:27:20'!
test01EmptyInstructionThenSamePositionAndDirection

	| rover |
	rover _ MarsRover atPosition: 1@1 andDirection: #East .
	
	rover do: ''.
	
	self assert: 1@1 equals: rover position.
	self assert: #East equals: rover direction.! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 's.d 10/3/2019 21:29:48'!
test02OneForwardInstructionAdvancesInTheSameDirection

	| rover |
	rover _ MarsRover atPosition: 1@1 andDirection: #East .
	
	rover do: 'f'.
	
	self assert: 2@1 equals: rover position.
	self assert: #East equals: rover direction.! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 's.d 10/3/2019 21:30:00'!
test03ManyForwardInstructionsAdvanceTheSameAmountInTheSameDirection

	| rover |
	rover _ MarsRover atPosition: 1@1 andDirection: #East .
	
	rover do: 'fff'.
	
	
	self assert: 4@1 equals: rover position.
	self assert: #East equals: rover direction.! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 's.d 10/3/2019 21:29:12'!
test04ManyBackwardInstructionsMovesAgainstDirection

	| rover |
	rover _ MarsRover atPosition: 1@1 andDirection: #East .
	
	rover do: 'bbb'.
	
	
	self assert: -2@1 equals: rover position.
	self assert: #East equals: rover direction.! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 's.d 10/3/2019 21:37:19'!
test05ForwardInNorthDirectionAdvancesToTheNorth

	| rover |
	rover _ MarsRover atPosition: 1@1 andDirection: #North .
	
	rover do: 'fff'.
	
	
	self assert: 1@4 equals: rover position.
	self assert: #North equals: rover direction.! !


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


!MarsRover methodsFor: 'executing' stamp: 's.d 10/3/2019 21:39:01'!
do: aStringInstruction
	| deltaPosition |
	(direction =  #East) ifTrue: [deltaPosition := aStringInstruction size @0.]
	ifFalse:  [deltaPosition := 0 @aStringInstruction size.].
	(aStringInstruction includes: $b)
		ifTrue: [position := position - deltaPosition]
		ifFalse: [position := position + deltaPosition].! !


!MarsRover methodsFor: 'accessing' stamp: 's.d 10/3/2019 21:07:46'!
direction
	^ direction.! !

!MarsRover methodsFor: 'accessing' stamp: 's.d 10/3/2019 20:18:04'!
position
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 's.d 10/3/2019 21:08:10'!
atPosition: aPoint andDirection: aDirection    
	^ self new initializeAtPosition: aPoint andDirection: aDirection.! !
