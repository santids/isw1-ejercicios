!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 's.d 9/17/2019 18:10:40'!
test11CopyEmptyStack
	|anEmptyStack otherEmptyStack anEmptyStackCopy|
	
	anEmptyStack _ OOStack new.
	otherEmptyStack _ OOStack  new.
	
	anEmptyStackCopy := anEmptyStack copy.
	
	anEmptyStack push: 'some element'.
	
	self assert: otherEmptyStack = anEmptyStackCopy.
	self deny: anEmptyStack  = otherEmptyStack .
	! !

!OOStackTest methodsFor: 'test' stamp: 's.d 9/17/2019 18:10:18'!
test12CopyNonEmptyStack
	|anStack otherStackWithSameElements anStackCopy|
	
	anStack _ OOStack new.
	otherStackWithSameElements _ OOStack  new.
	
	anStack push: 'hola'.
	otherStackWithSameElements push: 'hola'.
	anStack  push: 'chau'.
	otherStackWithSameElements push: 'chau'.
	
	anStackCopy := anStack copy.
	
	anStack push: 'some element'.
	
	self assert: otherStackWithSameElements = anStackCopy.
	self deny: anStack = otherStackWithSameElements .
	
	! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 19:19:27'!
test01PrefixInEmptyStack
	|result emptyStackCopy emptyStack |
	emptyStack _ OOStack  new.
	emptyStackCopy _ emptyStack copy.
	result _ finder find: 'hola' inStack: emptyStack .
	
	
	self assert: result = Bag  new.
	self assert: emptyStack  = emptyStackCopy.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 18:47:45'!
test02OneWordPrefixIsInStack
	|result stack stackCopy expectedResult|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	stackCopy _ stack copy.
	
	expectedResult _ Bag  new.
	expectedResult  add: 'Winter is here'.
	
	result _ finder find: 'Wint' inStack: stack.
	
	self assert: result = expectedResult.
	self assert: stack  = stackCopy.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 18:47:55'!
test03OneWordPrefixIsNotInStack
	|result stack stackCopy expectedResult|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	stackCopy _ stack copy.
	
	expectedResult _ Bag  new.
	
	result _ finder find: 'Summ' inStack: stack.
	
	self assert: result = expectedResult.
	self assert: stack  = stackCopy.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 18:30:48'!
test04EmptyPrefix
	| stack stackCopy|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	stackCopy _ stack copy.
	
	
	self 
		should: [finder find: '' inStack: stack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix emptyPrefixErrorDescription ].
		
		
	self assert: stack = stackCopy.
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 18:48:15'!
test05LowerCasePrefixMultipleMatches
	|result stack stackCopy expectedResult|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	stackCopy _ stack copy.
	
	expectedResult _ Bag new.
	expectedResult  add: 'winter is coming'.
	expectedResult  add: 'winning is everything'.
	
	result _ finder find: 'win' inStack: stack.
	
	self assert: result = expectedResult.
	self assert: stack  = stackCopy.
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 18:49:33'!
test06RepeatedStrings
	|result stack stackCopy expectedResult|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'winter is coming'.
	stack push: 'Winter is here'.
	
	stackCopy _ stack copy.
	
	expectedResult _ Bag new.
	expectedResult  add: 'winter is coming'.
	expectedResult  add: 'winning is everything'.
	expectedResult  add: 'winter is coming'.
	
	result _ finder find: 'win' inStack: stack.
	
	self assert: result = expectedResult.
	self assert: stack  = stackCopy.
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 18:52:27'!
test07UpperCasePrefixMultipleMatches
	|result stack stackCopy expectedResult|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	stack push: 'The summer is leaving'.
	
	stackCopy _ stack copy.
	
	expectedResult _ Bag new.
	expectedResult  add: 'The winds of Winter'.
	expectedResult  add: 'The summer is leaving'.
	
	result _ finder find: 'The' inStack: stack.
	
	self assert: result = expectedResult.
	self assert: stack  = stackCopy.
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 19:14:10'!
test08UseSameFinderTwice
	|result secondResult stack stackCopy expectedResult|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	stack push: 'The summer is leaving'.
	
	stackCopy _ stack copy.
	
	expectedResult _ Bag new.
	expectedResult  add: 'The winds of Winter'.
	expectedResult  add: 'The summer is leaving'.
	
	result _ finder find: 'The' inStack: stack.
	secondResult _ finder find: 'The' inStack: stack.
	
	self assert: result = expectedResult.
	self assert: stack  = stackCopy.
	
	secondResult _ finder find: 'The' inStack: stack.
	
	self assert: secondResult = expectedResult.
	self assert: stack  = stackCopy.
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 's.d 9/17/2019 19:15:38'!
test09DoesNotMatchEmptySentence
	|result stack stackCopy expectedResult|
	stack _ OOStack  new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: ''.
	stack push: 'Winter is here'.
	
	stackCopy _ stack copy.
	
	expectedResult _ Bag  new.
	
	result _ finder find: 'Summ' inStack: stack.
	
	self assert: result = expectedResult.
	self assert: stack  = stackCopy.! !


!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 's.d 9/17/2019 19:19:03'!
setUp
	finder _ SentenceFinderByPrefix  new.
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 's.d 9/16/2019 20:56:12'!
initialize
	elements := EmptyStack new.! !


!OOStack methodsFor: 'testing' stamp: 's.d 9/16/2019 20:56:12'!
isEmpty
	^ elements  isEmpty .! !


!OOStack methodsFor: 'accessing' stamp: 's.d 9/16/2019 20:56:12'!
size
	^ elements size.! !

!OOStack methodsFor: 'accessing' stamp: 's.d 9/16/2019 20:56:12'!
top
	^ elements top.! !


!OOStack methodsFor: 'adding' stamp: 's.d 9/16/2019 20:56:12'!
push: anElement
	elements := elements push: anElement.! !


!OOStack methodsFor: 'removing' stamp: 's.d 9/16/2019 20:56:12'!
pop
	|poppedElement|
	poppedElement  := elements  top.
	
	elements := elements  pop.
	
	^ poppedElement .! !


!OOStack methodsFor: 'private' stamp: 's.d 9/17/2019 17:49:04'!
elements
	^ elements.! !


!OOStack methodsFor: 'comparing' stamp: 's.d 9/17/2019 17:48:53'!
= anOOStack
	^ (anOOStack isKindOf: self class ) and: elements = anOOStack elements.! !


!OOStack methodsFor: 'copying' stamp: 's.d 9/17/2019 18:02:52'!
postCopy
	elements _ elements copy.! !


!OOStack methodsFor: 'printing' stamp: 's.d 9/17/2019 17:38:28'!
printNameOn: aStream
	super printOn: aStream.! !

!OOStack methodsFor: 'printing' stamp: 's.d 9/17/2019 17:38:48'!
printOn: aStream
	self printNameOn: aStream.
	elements printElementsOn: aStream.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OptionalStack category: #'Stack-Exercise'!
Object subclass: #OptionalStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OptionalStack methodsFor: 'accessing' stamp: 's.d 9/16/2019 20:24:15'!
size
	^ self subclassResponsibility .! !


!OptionalStack methodsFor: 'adding' stamp: 's.d 9/16/2019 20:24:33'!
push
	^ self subclassResponsibility .! !


!OptionalStack methodsFor: 'testing' stamp: 's.d 9/16/2019 20:24:06'!
isEmpty
	^ self subclassResponsibility .! !


!OptionalStack methodsFor: 'printing' stamp: 's.d 9/17/2019 17:33:47'!
printElementsOn: aStream
	^ self subclassResponsibility.! !

!OptionalStack methodsFor: 'printing' stamp: 's.d 9/17/2019 17:38:17'!
printNameOn: aStream
	super printOn: aStream.! !

!OptionalStack methodsFor: 'printing' stamp: 's.d 9/17/2019 17:31:52'!
printOn: aStream
	self printNameOn: aStream.
	self printElementsOn: aStream.! !


!OptionalStack methodsFor: 'removing' stamp: 's.d 9/16/2019 20:24:19'!
pop
	^ self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OptionalStack class' category: #'Stack-Exercise'!
OptionalStack class
	instanceVariableNames: ''!

!OptionalStack class methodsFor: 'instance creation' stamp: 's.d 9/16/2019 21:23:52'!
withElements: elements
	| aSubclass |
	
	aSubclass := (self subclasses detect: [ :aSublcass | aSublcass  matchesSize: elements size ]).
	
	^ aSubclass basicNew initializeWith: elements.
 	! !


!OptionalStack class methodsFor: 'testing' stamp: 's.d 9/16/2019 21:29:20'!
matchesSize
	^ self subclassResponsibility .! !


!classDefinition: #EmptyStack category: #'Stack-Exercise'!
OptionalStack subclass: #EmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStack methodsFor: 'comparing' stamp: 's.d 9/17/2019 17:51:06'!
= anOptionalStack
	^ anOptionalStack  isKindOf:  self class.! !


!EmptyStack methodsFor: 'as yet unclassified' stamp: 's.d 9/16/2019 20:33:46'!
pop
	self error: OOStack stackEmptyErrorDescription. ! !

!EmptyStack methodsFor: 'as yet unclassified' stamp: 's.d 9/17/2019 17:34:48'!
printElementsOn: aStream
	^ nil.! !

!EmptyStack methodsFor: 'as yet unclassified' stamp: 's.d 9/16/2019 20:35:17'!
push: anElement
	|stack|
	
	stack := NonEmptyStack new.
	stack push: anElement.
	
	^ stack! !

!EmptyStack methodsFor: 'as yet unclassified' stamp: 's.d 9/16/2019 20:33:50'!
top
	self error: OOStack stackEmptyErrorDescription. ! !


!EmptyStack methodsFor: 'testing' stamp: 's.d 9/16/2019 20:25:15'!
isEmpty
	^ true! !



!EmptyStack methodsFor: 'initialization' stamp: 's.d 9/16/2019 21:07:05'!
initializeWith: elements
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStack class' category: #'Stack-Exercise'!
EmptyStack class
	instanceVariableNames: ''!

!EmptyStack class methodsFor: 'testing' stamp: 's.d 9/16/2019 21:03:53'!
matchesSize: size
	^ size = 0.! !


!classDefinition: #NonEmptyStack category: #'Stack-Exercise'!
OptionalStack subclass: #NonEmptyStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonEmptyStack methodsFor: 'initialization' stamp: 's.d 9/16/2019 20:36:49'!
initialize
	elements := OrderedCollection  new.! !

!NonEmptyStack methodsFor: 'initialization' stamp: 's.d 9/16/2019 21:07:39'!
initializeWith: someElements
	elements := someElements .! !


!NonEmptyStack methodsFor: 'testing' stamp: 's.d 9/16/2019 20:25:26'!
isEmpty
	^ false! !


!NonEmptyStack methodsFor: 'accessing' stamp: 's.d 9/17/2019 18:03:23'!
postCopy
	elements _ elements copy.! !

!NonEmptyStack methodsFor: 'accessing' stamp: 's.d 9/17/2019 17:35:18'!
printElementsOn: aStream
	elements printElementsOn: aStream.! !

!NonEmptyStack methodsFor: 'accessing' stamp: 's.d 9/16/2019 20:43:47'!
size
	^ elements size.! !

!NonEmptyStack methodsFor: 'accessing' stamp: 's.d 9/16/2019 20:38:39'!
top
	^ elements last.! !


!NonEmptyStack methodsFor: 'removing' stamp: 's.d 9/16/2019 21:45:29'!
pop
	elements removeLast.
	
	^ OptionalStack withElements: elements.
	
	! !


!NonEmptyStack methodsFor: 'adding' stamp: 's.d 9/16/2019 20:41:59'!
push: anElement
	elements addLast: anElement .
	^ self.! !


!NonEmptyStack methodsFor: 'private' stamp: 's.d 9/17/2019 17:53:23'!
elements
	^ elements.! !


!NonEmptyStack methodsFor: 'comparing' stamp: 's.d 9/17/2019 18:12:50'!
= anStack
	^ (anStack isKindOf: self class) and: [ elements = anStack elements ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptyStack class' category: #'Stack-Exercise'!
NonEmptyStack class
	instanceVariableNames: ''!

!NonEmptyStack class methodsFor: 'testing' stamp: 's.d 9/16/2019 21:04:12'!
matchesSize: size
	^ size > 0.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'bufferStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 's.d 9/17/2019 19:00:40'!
initialize
	bufferStack _ OOStack new.
	

	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 's.d 9/17/2019 18:56:15'!
iterate: aStack pushingTo: anotherStack whileDoing: aClosure
	[aStack isEmpty  not ] whileTrue: [
		|element|
		element _ aStack pop.
		aClosure  value: element.
		anotherStack push: element.
	]
	! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 's.d 9/17/2019 19:00:02'!
moveBufferStackTo: aStack
	self iterate: bufferStack pushingTo:  aStack whileDoing: [:element | ]. ! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 's.d 9/17/2019 19:07:55'!
select: aClosure from: aStack
	|result|
	
	result _ Bag new.
	
	self 
		iterate: aStack 
		pushingTo: bufferStack 
		whileDoing: [ :element |
			(aClosure value: element) ifTrue: [
				result add: element 
			]
		].

	self moveBufferStackTo: aStack.
	
	^ result.	
	
	! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 's.d 9/17/2019 19:09:30'!
find: prefix inStack: aStack
	|result|
	
	prefix isEmptyOrNil  ifTrue: [ self error: self class emptyPrefixErrorDescription ].
	
	result _ self select: [ :element | element beginsWith: prefix ] from: aStack.
	
	
	^ result.	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 's.d 9/17/2019 18:30:58'!
emptyPrefixErrorDescription! !
