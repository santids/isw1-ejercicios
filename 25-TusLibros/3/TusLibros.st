!classDefinition: #CartTest category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
TestCase subclass: #CartTest
	instanceVariableNames: 'objectsFactory'
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


!CartTest methodsFor: 'setUp/tearDown' stamp: 'TCM 11/7/2019 21:23:03'!
setUp

	objectsFactory := TusLibrosTestObjectsFactory new.! !


!CartTest methodsFor: 'support' stamp: 'TCM 11/7/2019 21:23:42'!
createCart
	
	^ objectsFactory emptyCart! !

!CartTest methodsFor: 'support' stamp: 'TCM 11/7/2019 21:26:08'!
defaultCatalog
	
	^ objectsFactory catalog! !

!CartTest methodsFor: 'support' stamp: 'TCM 11/7/2019 21:25:32'!
itemNotSellByTheStore
	
	^ objectsFactory itemNotSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'TCM 11/7/2019 21:25:11'!
itemSellByTheStore
	
	^ objectsFactory itemSellByStore ! !


!classDefinition: #CashierForSaleTest category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
TestCase subclass: #CashierForSaleTest
	instanceVariableNames: 'cartWithItem objectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierForSaleTest methodsFor: 'setUp/tearDown' stamp: 'TCM 11/7/2019 21:38:08'!
setUp

	objectFactory := TusLibrosTestObjectsFactory new.

	cartWithItem := objectFactory emptyCart.
	cartWithItem add: objectFactory itemSellByStore.
! !


!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:38:57'!
test01EmptyCartCannotCheckout

	| anEmptyCart salesBook  |

	anEmptyCart := objectFactory emptyCart.
	salesBook := OrderedCollection new.

	self 
		should: [ CashierForSale for: anEmptyCart registerIn: salesBook payingWith: objectFactory creditCard onDate: objectFactory dateBeforeExpiration withPaymentGateway: objectFactory dummyPaymentGateway ]
		raise: Error - MessageNotUnderstood
		withMessageText: CashierForSale emptyCartErrorMessage .

	self assert: salesBook isEmpty! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:30:48'!
test02CreditCardCreationWithInvalidNumberFails

	self 
		should: [ CreditCard withNumber: '1234' expirationDate: objectFactory creditCardExpirationDate holderName: 'PIRULO'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorMessage.
		

	
	! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:31:00'!
test03CreditCardCreationWithLettersFails

	self 
		should: [ CreditCard withNumber: '12q4567890123456' expirationDate: objectFactory creditCardExpirationDate holderName: 'PIRULO'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorMessage.
		

	
	! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:30:57'!
test04CreditCardCreationWithNotOnlyLettersFails

	self 
		should: [ CreditCard withNumber: '1234567890123456' expirationDate: objectFactory creditCardExpirationDate holderName: 'PIRULO 12'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidHolderNameErrorMessage .
		

	
	! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:34:59'!
test05IsExpiredOnExpiredCardReturnsTrue

	self assert: (objectFactory creditCard isExpiredOn: objectFactory dateAfterExpiration )! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:35:50'!
test06IsExpiredOnNotExpiredCardReturnsFalse

	self deny: (objectFactory creditCard isExpiredOn: objectFactory dateBeforeExpiration )! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:35:05'!
test07CheckoutWithExpiredCardFails

	| salesBook paymentGateway |

	salesBook := OrderedCollection new.

	paymentGateway := MerchantProcessorSimulator responds: [].

	self should: [
		( CashierForSale 
			for: cartWithItem 
			registerIn: salesBook
			payingWith: objectFactory creditCard 
			onDate: objectFactory dateAfterExpiration 
			withPaymentGateway: paymentGateway ) checkout]
		raise: Error - MessageNotUnderstood 
		withMessageText: CashierForSale expiredCardErrorMessage.

	self deny: paymentGateway visited.
	self assert: salesBook  isEmpty .! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:36:02'!
test08CartWithItemsIsCheckedOutSuccesfully

	| salesBook merchantProcessorSimulator |

	salesBook := OrderedCollection new.

	merchantProcessorSimulator := MerchantProcessorSimulator responds: [].

	(CashierForSale
		for: cartWithItem
		registerIn: salesBook
		payingWith: objectFactory creditCard
		onDate: objectFactory dateBeforeExpiration
		withPaymentGateway: merchantProcessorSimulator) checkout.

	self assert: salesBook includes: (Purchase for: cartWithItem).
	self assert: 123 * peso equals: (Purchase for: cartWithItem) totalSpent.
	self assert: merchantProcessorSimulator visited 
		
	
	
! !

!CashierForSaleTest methodsFor: 'tests' stamp: 'TCM 11/7/2019 21:35:45'!
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
				payingWith: objectFactory creditCard
				onDate: objectFactory dateBeforeExpiration
				withPaymentGateway: merchantProcessorSimulator) checkout.] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Bad Request'.

	self deny: ( salesBook includes: (Purchase for: cartWithItem )).
	self assert: merchantProcessorSimulator visited. 

	
! !


!classDefinition: #TusLibrosRESTFacadeTest category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
TestCase subclass: #TusLibrosRESTFacadeTest
	instanceVariableNames: 'objectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:47:17'!
assertPurchase: aPurchase has: aBagOfItems andTotalAmount: totalAmount

	| items |

	items := Bag new.
	aPurchase itemsDo: [ :anItem :aQuantity |
		items add: anItem withOccurrences: aQuantity.
	].

	self assert: aBagOfItems equals: items.
	self assert: totalAmount equals: aPurchase totalSpent.! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:51:05'!
makeCheckoutIn: aFacade forCartId: aCartId
	| aCCExpiration aCCNumber aCCOwner |
	aCCNumber := objectsFactory creditCardNumber.
	aCCExpiration := objectsFactory creditCardExpirationDate.
	aCCOwner := objectsFactory creditCardName.
	aFacade checkoutCart: aCartId withCreditCardNumber: aCCNumber creditCardExpiration: aCCExpiration creditCardOwner: aCCOwner onDate: objectsFactory dateBeforeExpiration.
! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 19:34:22'!
setUp
	objectsFactory := TusLibrosTestObjectsFactory new.! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:39:47'!
test01AfterCreationOFACartForValidUserListCartWithThatIdIsEmpty
	| cartId facade |
	facade := objectsFactory facade.
	
	cartId := facade createCartFor: objectsFactory username with: objectsFactory password.
	
	self assert: (facade listCart: cartId) isEmpty.! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:40:39'!
test02AfterAddingAnItemToACartListCartWithThatIdIsEmpty
	| cartId facade |
	facade := objectsFactory facade.
	
	cartId := facade createCartFor: objectsFactory username with: objectsFactory password.
	
	facade addToCart: cartId withQuantity: 5 of: objectsFactory itemSellByStore.
	
	self assert: ((facade listCart: cartId) occurrencesOf: objectsFactory itemSellByStore) equals: 5.! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:48:37'!
test03CannotListNonExistantCart
	| facade |
	facade := objectsFactory facade.

	self 
		should: [ facade listCart: objectsFactory invalidCartId ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosRESTFacade cartDoesNotExistErrorMessage.! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:40:51'!
test04AddingItemsToACartDoesNotChangeAnotherCart
	| cartId1 cartId2 facade |
	facade := objectsFactory facade.

	cartId1 := facade createCartFor: objectsFactory username with: objectsFactory password.
	cartId2 := facade createCartFor: objectsFactory username with: objectsFactory password.

	facade addToCart: cartId1 withQuantity: 5 of: objectsFactory itemSellByStore.

	self assert: ((facade listCart: cartId1) occurrencesOf: objectsFactory itemSellByStore) equals: 5.
	self assert: (facade listCart: cartId2) isEmpty.! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:49:21'!
test05CannotAddToNonExistantCart
	| facade |
	facade := objectsFactory facade.

	self
		should: [ facade addToCart: objectsFactory invalidCartId withQuantity: 5 of: objectsFactory itemSellByStore ]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosRESTFacade cartDoesNotExistErrorMessage 
! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:41:01'!
test06CannotCreateCartWithInvalidUser
	| facade |
	facade := objectsFactory facade.

	self 
		should: [ facade createCartFor: objectsFactory invalidUsername with: objectsFactory password ]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosRESTFacade invalidadCredentialsErrorMessage
	! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:41:06'!
test07CannotCreateCartWithValidUserButInvalidPassword
	| facade |
	facade := objectsFactory facade.

	self 
		should: [ facade createCartFor: objectsFactory username with: objectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosRESTFacade invalidadCredentialsErrorMessage
	! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:41:12'!
test08ListPurchasesForUserWhichDidntCheckoutYetIsEmpty
	| facade purchases |
	facade := objectsFactory facade.

	purchases := facade listPurchasesOf: objectsFactory username withPassword: objectsFactory password.

	self assert: purchases isEmpty! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:41:16'!
test09CannotListPurchasesWithInvalidCredentials
	| facade |
	facade := objectsFactory facade.

	self 
		should: [ facade listPurchasesOf: objectsFactory invalidUsername withPassword: objectsFactory password ]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosRESTFacade invalidadCredentialsErrorMessage
	! !

!TusLibrosRESTFacadeTest methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:51:56'!
test10ListPurchasesOfAUserWhoCheckoutedHasTheBooksBuyed
	| cartId facade purchases expectedItems expectedAmount |
	facade := objectsFactory facade.

	cartId := facade createCartFor: objectsFactory username with: objectsFactory password.
	facade addToCart: cartId withQuantity: 2 of: objectsFactory itemSellByStore.
	self makeCheckoutIn: facade forCartId: cartId.
	purchases := facade listPurchasesOf: objectsFactory username withPassword: objectsFactory password.

	expectedItems := Bag with: objectsFactory itemSellByStore with: objectsFactory itemSellByStore.
	expectedAmount := 2 * objectsFactory priceOfItemSellByStore .

	self assertPurchase: purchases has: expectedItems andTotalAmount: expectedAmount! !


!classDefinition: #Cart category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TCM 11/7/2019 20:05:19'!
acceptingItemsOf: aCatalog 

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CashierForSale category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
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

!classDefinition: 'CashierForSale class' category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
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


!classDefinition: #CreditCard category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
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


!classDefinition: #MerchantProcessorSimulator category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
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

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'TCM 11/5/2019 18:13:23'!
responds: aBlockClosure 
	^self new initializeResponds: aBlockClosure ! !


!classDefinition: #Purchase category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
Object subclass: #Purchase
	instanceVariableNames: 'elements cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'private' stamp: 'TCM 11/4/2019 21:06:56'!
elements
	^ elements! !


!Purchase methodsFor: 'initialization' stamp: 'TCM 11/7/2019 21:16:35'!
initialize
	elements := OrderedCollection new! !

!Purchase methodsFor: 'initialization' stamp: 'TCM 11/7/2019 21:16:53'!
initializeFor: aCart 
	self initialize.
	
	aCart itemsDo: [  :anItem :aQuantity |
		elements add: (Array with: anItem with: aQuantity  with: (aCart priceOf: anItem) )
	].! !


!Purchase methodsFor: 'comparing' stamp: 'TCM 11/4/2019 21:06:42'!
= aTicket
	^ elements = aTicket elements.! !


!Purchase methodsFor: 'accessing' stamp: 'TCM 11/7/2019 21:22:03'!
totalSpent
	^ elements inject: 0 into: [ :acc :elem | (elem at: 3) * (elem at: 2)  + acc ]! !


!Purchase methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:16:04'!
isEmpty
	^ elements isEmpty! !

!Purchase methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:17:53'!
itemsDo: aBlockClosure 
	elements do: [ :anElement |
		aBlockClosure value: (anElement at: 1) value: (anElement at: 2)
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Purchase class' category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
Purchase class
	instanceVariableNames: ''!

!Purchase class methodsFor: 'as yet unclassified' stamp: 'TCM 11/4/2019 20:59:31'!
for: aCart
	^ self new initializeFor: aCart.! !


!classDefinition: #TusLibrosRESTFacade category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
Object subclass: #TusLibrosRESTFacade
	instanceVariableNames: 'catalogue catalog carts nextId usersDatabase salesBook paymentGateway'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 19:58:29'!
addToCart: aCartId withQuantity: aQuantity of: anItem
	(carts at: aCartId ifAbsent: [ self error: self class cartDoesNotExistErrorMessage ]) add: aQuantity of: anItem! !

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 20:25:23'!
areValidUser: anUser andPassword: aPassword

	^ usersDatabase at: anUser ifPresent: [ :correctPassword | ^ correctPassword = aPassword ] ifAbsent: [ ^ false ]! !

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 20:24:01'!
assertValidUser: anUser andPassword: aPassword

	^ (self areValidUser: anUser andPassword: aPassword) ifFalse: [ self error: self class invalidadCredentialsErrorMessage ]! !

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:20:31'!
checkoutCart: aCartId withCreditCardNumber: aCreditCardNumber creditCardExpiration: anExpirationDate creditCardOwner: aCreditCardOwner onDate: aDate  

	| cart creditCard |
	creditCard := CreditCard withNumber: aCreditCardNumber expirationDate: anExpirationDate holderName: aCreditCardOwner.
	cart := carts at: aCartId.

	(CashierForSale for: cart registerIn: salesBook payingWith: creditCard onDate: aDate withPaymentGateway: paymentGateway) checkout! !

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 20:24:15'!
createCartFor: anUser with: aPassword
	self assertValidUser: anUser andPassword: aPassword.

	carts at: nextId put: (Cart acceptingItemsOf: catalog).
	nextId := nextId + 1 .
	^ nextId - 1! !

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:04:58'!
initializeAcceptingItemsOf: aCatalog withUsers: anUsersDatabase withPaymentGateway: aPaymentGateway  
	catalog := aCatalog.
	carts := Dictionary new.
	nextId := 0.
	usersDatabase := anUsersDatabase.
	salesBook := OrderedCollection new.
	paymentGateway := aPaymentGateway! !

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 19:49:15'!
listCart: aCartId 
	| items cart |
	items := Bag new.
	
	cart := carts at: aCartId ifAbsent: [ self error: self class cartDoesNotExistErrorMessage ].	
	cart itemsDo: [ :anItem :aQuantity |
		items add: anItem withOccurrences: aQuantity.
	].
	^ items! !

!TusLibrosRESTFacade methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:15:45'!
listPurchasesOf: anUser withPassword: aPassword 
	self assertValidUser: anUser andPassword: aPassword.

	^ salesBook isEmpty ifTrue: [ Purchase new ] ifFalse: [ salesBook first ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRESTFacade class' category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
TusLibrosRESTFacade class
	instanceVariableNames: ''!

!TusLibrosRESTFacade class methodsFor: 'instance creation' stamp: 'TCM 11/7/2019 21:06:51'!
acceptingItemsOf: aCatalog withUsers: anUsersDatabase withPaymentGateway: aPaymentGateway 

	^self new initializeAcceptingItemsOf: aCatalog withUsers: anUsersDatabase withPaymentGateway: aPaymentGateway! !


!TusLibrosRESTFacade class methodsFor: 'error messages' stamp: 'TCM 11/7/2019 19:40:12'!
cartDoesNotExistErrorMessage
	^ 'El carrito no existe'! !

!TusLibrosRESTFacade class methodsFor: 'error messages' stamp: 'TCM 11/7/2019 20:15:31'!
invalidadCredentialsErrorMessage
	^ 'Credenciales invalidas'! !


!classDefinition: #TusLibrosTestObjectsFactory category: #TusLibros stamp: 'TCM 11/7/2019 21:53:28'!
Object subclass: #TusLibrosTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 19:30:24'!
catalog
	^ (Dictionary with: self itemSellByStore -> self priceOfItemSellByStore)! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:39:01'!
creditCard
	^ CreditCard withNumber: self creditCardNumber expirationDate: self creditCardExpirationDate holderName: self creditCardName.! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:39:22'!
creditCardExpirationDate

	^ GregorianMonthOfYear octoberOf: (GregorianYear number: 2019)! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:39:51'!
creditCardExpirationText

	^ '102019'! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:38:40'!
creditCardName

	^ 'PIRULO'! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:38:24'!
creditCardNumber

	^ '1234567890123456'! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 21:31:51'!
dateAfterExpiration

	^ FixedGregorianDate yearNumber: 2019 monthNumber: 11 dayNumber: 1.! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 21:11:09'!
dateBeforeExpiration

	^ FixedGregorianDate yearNumber: 2019 monthNumber: 10 dayNumber: 1.! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 21:38:20'!
dummyPaymentGateway
	^ MerchantProcessorSimulator responds: [].! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 21:24:27'!
emptyCart
	^ Cart acceptingItemsOf: self catalog ! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:18:50'!
invalidPassword
	^ 'password'.! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:15:45'!
invalidUsername
	^ 'Santi'! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 21:25:55'!
itemNotSellByTheStore
	^ 'El libro que no queres vender'! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 19:30:43'!
itemSellByStore
	^ 'anItem'! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:03:15'!
password
	^ 'axolotl'! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 19:30:57'!
priceOfItemSellByStore
	^ 123 * peso! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:02:45'!
userDatabase
	^ (Dictionary with: self username -> self  password)! !

!TusLibrosTestObjectsFactory methodsFor: 'builders' stamp: 'TCM 11/7/2019 20:03:01'!
username 
	^ 'Tobi'! !


!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:40:21'!
facade
	^ TusLibrosRESTFacade acceptingItemsOf: self catalog withUsers: self userDatabase withPaymentGateway: self dummyPaymentGateway! !

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'TCM 11/7/2019 21:48:57'!
invalidCartId
	^ 'cart id invalido'! !
