!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 20:29:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	|customerBook|
	
	customerBook _ CustomerBook  new.
	self shouldNotTakeMore: [customerBook addCustomerNamed: 'John Lennon'.] 
		than: 50 * millisecond 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 20:40:55'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	|paulMcCartney customerBook|

	paulMcCartney := 'Paul McCartney'.
	customerBook _ self customerBookWith: paulMcCartney.
	
	self shouldNotTakeMore: [customerBook removeCustomerNamed: paulMcCartney.] 
		than: 100* millisecond  

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 20:56:03'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertBlock:  [ customerBook addCustomerNamed: ''.] 
		throwsErrorOfClass: Error  
		then: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 20:59:02'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.		
	customerBook := self customerBookWith:  johnLennon.
	
	self assertBlock:  [ customerBook removeCustomerNamed: 'Paul McCartney'.] 
		throwsErrorOfClass:  NotFound
		then:  (self assertOneCustomer: customerBook named: johnLennon).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 21:10:15'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook _ self customerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: (customerBook matchesNumberOfActive: 0 andOfSuspended:  1).
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 21:10:52'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook _ self customerBookWith:  paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: (customerBook matchesNumberOfActive: 0 andOfSuspended:  0).
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 19:29:39'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.	
	customerBook := self customerBookWith: johnLennon.
	
	self assertCantSuspend: 'Paul McCartney' 
		inCustomerBook: customerBook  
		andCheck: (self assertOneCustomer: customerBook named: johnLennon).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 's.d 9/2/2019 19:27:48'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	
	johnLennon _ 'John Lennon'.			
	customerBook := self customerBookWith: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertCantSuspend: johnLennon 
		inCustomerBook: customerBook  
		andCheck: (self assertOneCustomer: customerBook named: johnLennon).
! !


!CustomerBookTest methodsFor: 'setUp/tearDown' stamp: 's.d 9/2/2019 19:12:46'!
customerBookWith: name
 	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: name.
	
	^  customerBook.! !


!CustomerBookTest methodsFor: 'assertions' stamp: 's.d 9/2/2019 20:57:57'!
assertBlock: exerciseBlock throwsErrorOfClass:  errorClass then: afterBlock
	
	[ exerciseBlock  value. self fail.]
		on: errorClass 
		do: [:anError | afterBlock value: anError].
		
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 's.d 9/2/2019 21:00:01'!
assertCantSuspend: aCustomer inCustomerBook: customerBook andCheck: anAssertionBlock
	
	self assertBlock:  [ customerBook suspendCustomerNamed: aCustomer] 
		throwsErrorOfClass: CantSuspend
		then: anAssertionBlock.
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 's.d 9/2/2019 19:17:28'!
assertOneCustomer: customerBook named: customerName
	^ [ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: customerName) ].! !

!CustomerBookTest methodsFor: 'assertions' stamp: 's.d 9/2/2019 20:28:28'!
shouldNotTakeMore: exerciseBlock than: aTimeLimit
 
	| millisecondsBeforeRunning millisecondsAfterRunning |
	  
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	exerciseBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTimeLimit.
	! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !

!CustomerBook methodsFor: 'testing' stamp: 's.d 9/2/2019 21:09:05'!
matchesNumberOfActive: numberOfActive andOfSuspended: numberOfSuspended
	
	^  numberOfActive = self numberOfActiveCustomers 
	and: numberOfSuspended = self numberOfSuspendedCustomers 
	and: numberOfActive + numberOfSuspended = self numberOfCustomers.! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 's.d 9/8/2019 16:20:44'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 's.d 9/8/2019 16:21:47'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 's.d 9/8/2019 16:40:27'!
removeCustomerNamed: aName 

	^ active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [
			NotFound signal.
		]
	]
 

! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
