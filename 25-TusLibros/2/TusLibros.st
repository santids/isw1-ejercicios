!classDefinition: #CartTest category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
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


!classDefinition: #CashierForSaleTest category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
TestCase subclass: #CashierForSaleTest
	instanceVariableNames: 'creditCard dummyPaymentGateway expirationDate dateAfterExpiration dateBeforeExpiration item pricesListWithItem cartWithItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!CashierForSaleTest methodsFor: 'setUp/tearDown' stamp: 'TCM 11/5/2019 18:53:26'!
setUp
	item := 'ElLaberintoDelFauno'.
	pricesListWithItem := Dictionary with: item -> (123 * peso).

	dummyPaymentGateway := MerchantProcessorSimulator responds: [].

	expirationDate := GregorianMonthOfYear octoberOf: (GregorianYear number: 2019).
	
	creditCard := CreditCard withNumber: '1234567890123456' expirationDate: expirationDate holderName: 'PIRULO'.
	
	cartWithItem := Cart acceptingItemsOf: pricesListWithItem.
	cartWithItem add: item.
	
	dateAfterExpiration := FixedGregorianDate yearNumber: 2019 monthNumber: 11 dayNumber: 1.
	dateBeforeExpiration := FixedGregorianDate yearNumber: 2019 monthNumber: 10 dayNumber: 1.
! !


!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 19:03:10'!
test01EmptyCartCannotCheckout

	| anEmptyCart salesBook  |

	anEmptyCart := Cart acceptingItemsOf: pricesListWithItem.
	salesBook := OrderedCollection new.

	self 
		should: [ CashierForSale for: anEmptyCart registerIn: salesBook payingWith: creditCard onDate: dateBeforeExpiration withPaymentGateway: dummyPaymentGateway ]
		raise: Error - MessageNotUnderstood
		withMessageText: CashierForSale emptyCartErrorMessage .

	self assert: salesBook isEmpty! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 18:50:19'!
test02CreditCardCreationWithInvalidNumberFails

	self 
		should: [ CreditCard withNumber: '1234' expirationDate: expirationDate holderName: 'PIRULO'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorMessage.
		

	
	! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 18:11:05'!
test03CreditCardCreationWithLettersFails

	self 
		should: [ CreditCard withNumber: '12q4567890123456' expirationDate: expirationDate holderName: 'PIRULO'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorMessage.
		

	
	! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 18:11:10'!
test04CreditCardCreationWithNotOnlyLettersFails

	self 
		should: [ CreditCard withNumber: '1234567890123456' expirationDate: expirationDate holderName: 'PIRULO 12'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidHolderNameErrorMessage .
		

	
	! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 18:50:31'!
test05IsExpiredOnExpiredCardReturnsTrue

	self assert: (creditCard isExpiredOn: dateAfterExpiration )! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 18:50:35'!
test06IsExpiredOnNotExpiredCardReturnsFalse

	self deny: (creditCard isExpiredOn: dateBeforeExpiration )! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 18:59:52'!
test07CheckoutWithExpiredCardFails

	| salesBook paymentGateway |

	salesBook := OrderedCollection new.

	paymentGateway := MerchantProcessorSimulator responds: [].

	self should: [
		( CashierForSale 
			for: cartWithItem 
			registerIn: salesBook
			payingWith: creditCard 
			onDate: dateAfterExpiration 
			withPaymentGateway: paymentGateway ) checkout]
		raise: Error - MessageNotUnderstood 
		withMessageText: CashierForSale expiredCardErrorMessage.

	self deny: paymentGateway visited.
	self assert: salesBook  isEmpty .! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 19:00:35'!
test08CartWithItemsIsCheckedOutSuccesfully

	| salesBook merchantProcessorSimulator |

	salesBook := OrderedCollection new.

	merchantProcessorSimulator := MerchantProcessorSimulator responds: [].

	(CashierForSale
		for: cartWithItem
		registerIn: salesBook
		payingWith: creditCard
		onDate: dateBeforeExpiration
		withPaymentGateway: merchantProcessorSimulator) checkout.

	self assert: salesBook includes: (Purchase for: cartWithItem).
	self assert: 123 * peso equals: (Purchase for: cartWithItem) totalSpent.
	self assert: merchantProcessorSimulator visited 
		
	
	
! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/5/2019 19:01:45'!
test09IfMerchantProcessorFailsThePurcharseIsNotDone

	| salesBook merchantProcessorSimulator |

	salesBook := OrderedCollection new.

	merchantProcessorSimulator := MerchantProcessorSimulator responds: [
		self error: 'Bad Request'.
	].

	self
		should: [
			(CashierForSale 
				for: cartWithItem
				registerIn: salesBook
				payingWith: creditCard
				onDate: dateBeforeExpiration
				withPaymentGateway: merchantProcessorSimulator) checkout.] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Bad Request'.

	self deny: ( salesBook includes: (Purchase for: cartWithItem )).
	self assert: merchantProcessorSimulator visited. 

	
! !


!classDefinition: #Cart category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
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


!Cart methodsFor: 'price' stamp: 'TCM 11/5/2019 17:23:10'!
priceOf: anItem 
	^ catalog at: anItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CashierForSale category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
Object subclass: #CashierForSale
	instanceVariableNames: 'cart salesBook purchaseDate paymentGateway creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierForSale methodsFor: 'initialization' stamp: 'TCM 11/5/2019 18:16:08'!
initializeFor: aCart registerIn: aSalesBook payingWith: aCreditCard onDate: aPurchaseDate withPaymentGateway: aPaymentGateway    
	cart := aCart.
	salesBook := aSalesBook.
	creditCard := aCreditCard.
	purchaseDate := aPurchaseDate.
	paymentGateway := aPaymentGateway! !


!CashierForSale methodsFor: 'operating' stamp: 'TCM 11/5/2019 18:19:18'!
checkout
	| purchase |
	purchase := Purchase for: cart.
	paymentGateway debit: purchase totalSpent from: creditCard .
	^ salesBook add: purchase! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierForSale class' category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
CashierForSale class
	instanceVariableNames: ''!

!CashierForSale class methodsFor: 'error messages' stamp: 'TCM 11/4/2019 19:19:40'!
emptyCartErrorMessage
	^ 'No se puede crear un cajero para un carrito vacio'.! !


!CashierForSale class methodsFor: 'instance creation' stamp: 'TCM 11/5/2019 18:06:14'!
for: aCart registerIn: aSalesBook payingWith: aCreditCard onDate: aPurchaseDate withPaymentGateway: aPaymentGateway    
	aCart isEmpty ifTrue: [ self error: self emptyCartErrorMessage ].
	(aCreditCard isExpiredOn: aPurchaseDate) ifTrue: [ self error: self expiredCardErrorMessage ].
	^self new initializeFor: aCart registerIn: aSalesBook payingWith: aCreditCard onDate: aPurchaseDate withPaymentGateway: aPaymentGateway ! !


!CashierForSale class methodsFor: 'as yet unclassified' stamp: 'TCM 11/5/2019 17:47:01'!
expiredCardErrorMessage
	^ 'No se puede comprar con una tarjeta vencida'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
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


!CreditCard methodsFor: 'testing' stamp: 'TCM 11/5/2019 17:38:45'!
isExpiredOn: aFixedGregorianDate
	^ expiration < aFixedGregorianDate monthOfYear .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
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


!classDefinition: #MerchantProcessorSimulator category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'blockClosure wasVisited'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'testing' stamp: 'TCM 11/5/2019 18:58:35'!
visited
	^ wasVisited! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'TCM 11/5/2019 18:58:17'!
initializeResponds: aBlockClosure
	blockClosure := aBlockClosure.
	wasVisited := false.! !


!MerchantProcessorSimulator methodsFor: 'payment' stamp: 'TCM 11/5/2019 18:59:00'!
debit: anAmountOfMoney from: aCreditCard 
	wasVisited := true.
	blockClosure value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'TCM 11/5/2019 18:13:23'!
responds: aBlockClosure 
	^self new initializeResponds: aBlockClosure ! !


!classDefinition: #Purchase category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
Object subclass: #Purchase
	instanceVariableNames: 'elements cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'private' stamp: 'TCM 11/4/2019 21:06:56'!
elements
	^ elements! !


!Purchase methodsFor: 'initialization' stamp: 'TCM 11/4/2019 21:03:12'!
initializeFor: aCart 
	elements := OrderedCollection  new.
	
	aCart itemsDo: [  :anItem :aQuantity |
		elements add: (Array with: anItem with: aQuantity  with: (aCart priceOf: anItem) )
	].! !


!Purchase methodsFor: 'comparing' stamp: 'TCM 11/4/2019 21:06:42'!
= aTicket
	^ elements = aTicket elements.! !


!Purchase methodsFor: 'accessing' stamp: 'TCM 11/5/2019 17:22:25'!
totalSpent
	^ elements inject: 0 into: [ :acc :elem | acc + (elem at: 3) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Purchase class' category: #TusLibros stamp: 'TCM 11/5/2019 19:05:27'!
Purchase class
	instanceVariableNames: ''!

!Purchase class methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:59:31'!
for: aCart
	^ self new initializeFor: aCart.! !
