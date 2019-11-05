!classDefinition: #CartTest category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'TCM 11/4/2019 20:56:54'!
test09ItemsDoOfCardWithITemsVisitsThem

	| cart expected result |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	
	result := Bag new.
	
	expected := Bag new add: self itemSellByTheStore withOccurrences: 2; yourself.
 
	cart itemsDo:  [ :anItem :aQuantity | 
		result add: anItem withOccurrences: aQuantity.
	].

	self assert: expected equals: result! !

!CartTest methodsFor: 'tests' stamp: 'TCM 11/4/2019 20:50:28'!
test10ItemsDoOfEmptyCartDoesNothing

	| cart |
	
	cart := self createCart.
	
	
	cart itemsDo:  [ :anItem :aQuantity | self fail ].! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'TCM 11/4/2019 19:42:38'!
defaultCatalog
	
	^ Dictionary with: self itemSellByTheStore -> (50 * peso)! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierForSaleTest category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
TestCase subclass: #CashierForSaleTest
	instanceVariableNames: 'creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:08:42'!
expirationDate

	^ GregorianMonthOfYear octoberOf: (GregorianYear number: 1997)! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 19:44:39'!
itemSellByTheStore

	^ 'ElLaberintoDelFauno'! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 19:45:34'!
priceListWithItem

	^ Dictionary with: self itemSellByTheStore -> (123 * peso)! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:32:07'!
setUp
	creditCard := CreditCard withNumber: '1234567890123456' expirationDate: self expirationDate holderName: 'PIRULO'.
		
	
	
! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:31:58'!
test01EmptyCartCannotCheckout

	| aCart salesBook  |
	
	aCart := Cart acceptingItemsOf: self priceListWithItem.
	

	
	salesBook := OrderedCollection new.

	self 
		should: [ CashierForSale for: aCart registerIn: salesBook payingWith: creditCard  ]
		raise: Error - MessageNotUnderstood
		withMessageText: CashierForSale emptyCartErrorMessage .

	self assert: salesBook isEmpty! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:08:53'!
test02CreditCardCreationWithInvalidNumberFails


	
	self 
		should: [ CreditCard withNumber: '1234' expirationDate: self expirationDate holderName: 'PIRULO'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorMessage.
		

	
	! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:10:24'!
test03CreditCardCreationWithLettersFails

	self 
		should: [ CreditCard withNumber: '12q4567890123456' expirationDate: self expirationDate holderName: 'PIRULO'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorMessage.
		

	
	! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:21:42'!
test04CreditCardCreationWithNotOnlyLettersFails

	self 
		should: [ CreditCard withNumber: '1234567890123456' expirationDate: self expirationDate holderName: 'PIRULO 12'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidHolderNameErrorMessage .
		

	
	! !

!CashierForSaleTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:58:57'!
test05CartWithItemsIsCheckedOutSuccesfully

	| aCart aBook salesBook pricesList |
	
	aBook := self itemSellByTheStore.
	pricesList := self priceListWithItem.

	aCart := Cart acceptingItemsOf: pricesList.
	aCart add: aBook.

	salesBook := OrderedCollection new.

	(CashierForSale for: aCart registerIn: salesBook payingWith: creditCard) checkout.

	self assert: salesBook includes: (Ticket for: aCart).

		
	
	
! !


!classDefinition: #Cart category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'TCM 11/4/2019 19:37:20'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'TCM 11/4/2019 20:43:14'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'TCM 11/4/2019 20:56:25'!
itemsDo: aBlock
	
	items sortedCounts do: [:association | aBlock value: association  value value: association  key] .! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'TCM 11/4/2019 20:44:11'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .! !


!Cart methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 21:05:15'!
priceOf: anItem 
	^ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CashierForSale category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
Object subclass: #CashierForSale
	instanceVariableNames: 'cart salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierForSale methodsFor: 'initialization' stamp: 'TCM 11/4/2019 20:29:19'!
initializeFor: aCart registerIn: aSalesBook payingWith: aCreditCard  
	cart := aCart.
	salesBook := aSalesBook! !


!CashierForSale methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:58:19'!
checkout
	^ salesBook add: (Ticket for: cart)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierForSale class' category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
CashierForSale class
	instanceVariableNames: ''!

!CashierForSale class methodsFor: 'error messages' stamp: 'TCM 11/4/2019 19:19:40'!
emptyCartErrorMessage
	^ 'No se puede crear un cajero para un carrito vacio'.! !


!CashierForSale class methodsFor: 'instance creation' stamp: 'TCM 11/4/2019 20:29:19'!
for: aCart registerIn: aSalesBook payingWith: aCreditCard  
	aCart isEmpty ifTrue: [ self error: self emptyCartErrorMessage ].
	^self new initializeFor: aCart registerIn: aSalesBook payingWith: aCreditCard ! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
Object subclass: #CreditCard
	instanceVariableNames: 'string gregorianMonthOfYear name number expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'TCM 11/4/2019 20:04:08'!
initializeWithNumber: aCreditCardNumber expirationDate: aGregorianMonthOfYear holderName: aName 
	number := aCreditCardNumber.
	expiration := aGregorianMonthOfYear.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error messages' stamp: 'TCM 11/4/2019 20:21:24'!
invalidHolderNameErrorMessage
	^ 'El nombre del titular solo puede tener letras y caracteres en blanco'! !

!CreditCard class methodsFor: 'error messages' stamp: 'TCM 11/4/2019 19:59:54'!
invalidNumberErrorMessage
	^ 'El numero es invalido'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'TCM 11/4/2019 20:20:11'!
withNumber: aCreditCardNumber expirationDate: aGregorianMonthOfYear holderName: aName 
	(aCreditCardNumber size = 16 and: [ aCreditCardNumber allSatisfy: [ :char | char isDigit ]])
		ifFalse: [ self error: self invalidNumberErrorMessage ].
	(aName allSatisfy:   [ :char | char isLetter or: char isSeparator ]) ifFalse: [ self error: self invalidHolderNameErrorMessage ] .

	^self new initializeWithNumber: aCreditCardNumber expirationDate: aGregorianMonthOfYear holderName: aName
! !


!classDefinition: #Ticket category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
Object subclass: #Ticket
	instanceVariableNames: 'elements cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'private' stamp: 'TCM 11/4/2019 21:06:56'!
elements
	^ elements! !


!Ticket methodsFor: 'initialization' stamp: 'TCM 11/4/2019 21:06:42'!
= aTicket
	^ elements = aTicket elements.! !

!Ticket methodsFor: 'initialization' stamp: 'TCM 11/4/2019 21:03:12'!
initializeFor: aCart 
	elements := OrderedCollection  new.
	
	aCart itemsDo: [  :anItem :aQuantity |
		elements add: (Array with: anItem with: aQuantity  with: (aCart priceOf: anItem) )
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros stamp: 'TCM 11/4/2019 21:08:14'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:59:31'!
for: aCart
	^ self new initializeFor: aCart.! !
