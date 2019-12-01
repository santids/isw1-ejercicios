!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'removing' stamp: 'TCM 11/21/2019 20:07:47'!
remove: anItem
	items remove: anItem ifAbsent: [ self error: self class itemNotPresentErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !

!Cart class methodsFor: 'error messages' stamp: 'TCM 11/21/2019 20:07:03'!
itemNotPresentErrorMessage
	^ 'No se puede eliminar un item que no fue agregado'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade alreadyCheckout'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'TCM 12/1/2019 18:59:51'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.
	alreadyCheckout ifTrue: [ self error: self class cartAlreadyCheckoutErrorMessage ].

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'TCM 11/26/2019 20:00:45'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.
	alreadyCheckout := false.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'TCM 11/22/2019 18:07:39'!
amountOf: aBook

	^ cart content occurrencesOf: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'TCM 12/1/2019 18:59:24'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	| ticket |

	ticket := (Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut.

	alreadyCheckout := true.
	^ ticket! !

!CartSession methodsFor: 'cart' stamp: 'TCM 12/1/2019 19:20:57'!
owner
	^owner! !

!CartSession methodsFor: 'cart' stamp: 'TCM 11/21/2019 20:02:13'!
removeFromCart: aBook 
	cart remove: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!CartSession class methodsFor: 'error messages' stamp: 'TCM 12/1/2019 19:01:50'!
cartAlreadyCheckoutErrorMessage
	^ 'Ya se hizo check out sobre este carrito'! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'TCM 11/22/2019 18:26:51'!
totalOf: anItem quantity: aQuantity

	^((cart catalog at: anItem) at: 'price') * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #RealTimeClock category: #'TusLibros-Model'!
Clock subclass: #RealTimeClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!RealTimeClock methodsFor: 'time' stamp: 'TCM 11/21/2019 20:26:18'!
now
	^ DateAndTime now! !

!RealTimeClock methodsFor: 'time' stamp: 'TCM 11/21/2019 20:26:05'!
today
	^ Date today! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'TCM 11/22/2019 19:10:20'!
quantity

	^ quantity! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #MerchantProcessorStub category: #'TusLibros-Model'!
MerchantProcessor subclass: #MerchantProcessorStub
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessorStub methodsFor: 'debit' stamp: 'TCM 11/21/2019 20:16:11'!
debit: anAmount from: aCreditCard
! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'accessing' stamp: 'TCM 12/1/2019 13:57:53'!
items
	^ ticket items ! !

!Sale methodsFor: 'accessing' stamp: 'TCM 12/1/2019 14:22:00'!
quantityBoughtOf: aBook
	^ ticket quantityBoughtOf: aBook! !

!Sale methodsFor: 'accessing' stamp: 'TCM 12/1/2019 14:21:42'!
totalSpentIn: aBook
	^ ticket totalSpentIn: aBook! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #SalesBook category: #'TusLibros-Model'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!SalesBook methodsFor: 'initialization' stamp: 'TCM 12/1/2019 13:44:11'!
initialize
	sales := OrderedCollection new.! !


!SalesBook methodsFor: 'adding' stamp: 'TCM 12/1/2019 13:44:26'!
add: aSale
	sales add: aSale! !


!SalesBook methodsFor: 'accessing' stamp: 'TCM 12/1/2019 13:57:33'!
booksBoughtBy: aUser

	^ (self salesDoneBy: aUser)
		collect: [:aSale | aSale items]
		andFold: [:aSaleItems :anotherSaleItems | aSaleItems union: anotherSaleItems ]
		ifEmpty: [ Set new ]. ! !

!SalesBook methodsFor: 'accessing' stamp: 'TCM 12/1/2019 19:46:14'!
quantityBoughtOf: aBook by: anUser 
	^ ((self salesDoneBy: anUser)
		sum: [:aSale | aSale quantityBoughtOf: aBook])
		ifEmpty: 0! !

!SalesBook methodsFor: 'accessing' stamp: 'TCM 12/1/2019 13:45:17'!
salesDoneBy: aUser

	^ sales select: [ :aSale | aSale wasDoneBy: aUser ]! !

!SalesBook methodsFor: 'accessing' stamp: 'TCM 12/1/2019 14:17:34'!
ticketFor: aUser

	| lineItems |
	lineItems := (self booksBoughtBy: aUser) collect: [ :aBook |
		LineItem of: aBook quantity: (self quantityBoughtOf: aBook by: aUser) total: (self totalSpentIn: aBook by: aUser)
	].
	^ Ticket of: lineItems
	! !

!SalesBook methodsFor: 'accessing' stamp: 'TCM 12/1/2019 19:46:27'!
totalSpentIn: aBook by: anUser 
	^ ((self salesDoneBy: anUser)
		sum: [:aSale | aSale totalSpentIn: aBook])
		ifEmpty: 0! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'TCM 12/1/2019 19:44:27'!
total

	^lineItems sum: [ :aLineItem | aLineItem total] ifEmpty: 0! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'testing' stamp: 'TCM 12/1/2019 14:24:25'!
isEmpty

	^ lineItems isEmpty! !


!Ticket methodsFor: 'accessing' stamp: 'TCM 12/1/2019 13:58:28'!
items

	^ lineItems collect: [:aLineItem | aLineItem item ] ! !

!Ticket methodsFor: 'accessing' stamp: 'TCM 12/1/2019 14:23:15'!
quantityBoughtOf: aBook

	| lineOfBook |
	lineOfBook := lineItems
		detect: [:aLineItem | aLineItem item = aBook ]
		ifNone: [^0].
	^ lineOfBook quantity! !

!Ticket methodsFor: 'accessing' stamp: 'TCM 12/1/2019 14:23:31'!
totalSpentIn: aBook

	| lineOfBook |
	lineOfBook := lineItems
		detect: [:aLineItem | aLineItem item = aBook ]
		ifNone: [^0].
	^ lineOfBook total! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosRESTController category: #'TusLibros-Model'!
Object subclass: #TusLibrosRESTController
	instanceVariableNames: 'systemFacade webServer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 11/22/2019 17:51:27'!
addAddToCartService

	^ self addService: '/addToCart' doing: [:request |
		| cartId bookISBN catalog |

		cartId := (self field: request withName: 'cartId') asInteger .
		bookISBN := self field: request withName: 'bookISBN'.

		catalog := systemFacade add: 1 of:  bookISBN toCartIdentifiedAs: cartId.

		''
	]! !

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 12/1/2019 19:34:00'!
addCheckoutService

	^ self addService: '/checkoutCart' doing: [:request |
		| cartId bookISBN catalog ticket result items cartOwner |

		cartId := (self field: request withName: 'cartId') asInteger.

		cartOwner := systemFacade ownerOf: cartId.

		ticket := systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: ((self creditCardOf: cartOwner) at: 'number')
			ownedBy: ((self creditCardOf: cartOwner) at: 'owner')
			expiringOn: ((self creditCardOf: cartOwner) at: 'expiration').

		self ticketToDictionary: ticket
	]! !

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 11/22/2019 17:51:19'!
addCreateCartService

	^ self addService: '/createCart' doing: [:request |
		| cartId password user |
		user := self field: request withName: 'userId'.
		password := self field: request withName: 'password'.

		cartId := systemFacade createCartFor: user authenticatedWith: password.

		 Dictionary new
			at: 'cartId' put: cartId;
			yourself.
		]! !

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 11/22/2019 17:33:04'!
addListCartService

	^ self  addService: '/listCart' doing:  [:request | 
		| cartId items d | 
		cartId := (self field: request withName: 'cartId') asInteger .
		
		items := systemFacade listCartIdentifiedAs: cartId.
		
		items contents
	]! !

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 12/1/2019 14:33:03'!
addListPurchasesService

	^ self addService: '/listPurchases' doing: [:request |
		| cartId password user ticket |
		user := self field: request withName: 'userId'.
		password := self field: request withName: 'password'.

		ticket := systemFacade listPurchasesOf: user  authenticatingWith: password.
		
		self ticketToDictionary: ticket
	]! !

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 11/22/2019 17:51:11'!
addRemoveFromCartService

	^ self addService: '/removeFromCart' doing: [:request |
		| cartId bookISBN catalog |
		
		cartId := (self field: request withName: 'cartId') asInteger .
		bookISBN := self field: request withName: 'bookISBN'.

		catalog := systemFacade remove:  bookISBN fromCartIdentifiedAs: cartId.
		
		''	
	]! !

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 11/22/2019 18:02:03'!
addShowBookInCartDetails

	^ self addService: '/showBookInCartDetails' doing: [:request |
		| cartId bookISBN cartItems itemDetails itemInCartQuantity |
		
		cartId := (self field: request withName: 'cartId') asInteger .
		bookISBN := self field: request withName: 'bookISBN'.

		systemFacade bookDetailsOf: bookISBN inCart: cartId
	]! !

!TusLibrosRESTController methodsFor: 'private - services' stamp: 'TCM 11/22/2019 17:51:04'!
addShowCatalogService

	^ self addService: '/showCatalog' doing: [:request |
		| response catalog |

		catalog := systemFacade catalog.

		Dictionary new
			at: 'catalog' put: catalog;
			yourself.
	]! !


!TusLibrosRESTController methodsFor: 'private - support' stamp: 'TCM 11/22/2019 17:30:28'!
addService: aServicePath doing: aBlock

	webServer  addService: aServicePath action: (self createServiceDoing: aBlock)	! !

!TusLibrosRESTController methodsFor: 'private - support' stamp: 'sjd 12/1/2019 15:57:44'!
createServiceDoing: aBlock
 ^ [:request |
		[
			| response |
			response := aBlock value: request.
			"request send200Response: (substringsAsJson)"
			request send200Response: ((WebUtils jsonEncode: response) asUtf8) 
					contentType: 'application/json; charset=utf-8' 
					do: [:resp | 
						resp headerAt: 'Access-Control-Allow-Origin' put: '*'.] 
			 ] 
			on: Error 
			do: [ :anError | |response|
				response := Dictionary new
					at: 'error' put: anError messageText;
					yourself.

				request sendResponseCode: 400 
					content: (WebUtils jsonEncode: response) asUtf8
					type: 'application/json; charset=utf-8'
					do: [:resp | 
						resp headerAt: 'Access-Control-Allow-Origin' put: '*'.] 
			]
		].

	! !

!TusLibrosRESTController methodsFor: 'private - support' stamp: 'TCM 12/1/2019 19:32:35'!
creditCardOf: anUser
	^ self creditCardDataByUser at: anUser! !

!TusLibrosRESTController methodsFor: 'private - support' stamp: 'TCM 11/22/2019 17:27:56'!
field: request withName: aFieldName 

	^ request fields at:aFieldName ifAbsent: [ self error: aFieldName, ' param is missing' ]! !

!TusLibrosRESTController methodsFor: 'private - support' stamp: 'TCM 12/1/2019 14:31:50'!
ticketToDictionary: aTicket

	| items result |
	result := Dictionary 
		with: 'total' -> aTicket total.

	items := OrderedCollection new.
	aTicket lineItemsDo: [ :aLineItem |
		items add: (Dictionary
			with: 'item' -> aLineItem item
			with: 'quantity' -> aLineItem quantity
			with: 'total' -> aLineItem total)
	].
	result add: 'items' -> items asArray.

	^ result! !


!TusLibrosRESTController methodsFor: 'initialize' stamp: 'TCM 11/22/2019 19:05:10'!
initializeWith: aPortNumber

	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self usersAndPasswords
		acceptingItemsOf: self catalog
		registeringOn: self salesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: self realTimeClock.
	
	webServer := WebServer new listenOn: aPortNumber.

	self addCreateCartService.
	self addShowCatalogService.
	self addAddToCartService.
	self addListCartService.
	self addRemoveFromCartService.
	self addShowBookInCartDetails.
	self addCheckoutService.
	self addListPurchasesService.
! !


!TusLibrosRESTController methodsFor: 'destroying' stamp: 'TCM 11/21/2019 20:43:17'!
destroy
	webServer destroy! !


!TusLibrosRESTController methodsFor: 'object creation' stamp: 'TCM 11/22/2019 18:24:03'!
catalog
	^ Dictionary new
		at: 'ISBN1' put: (Dictionary with: 'price'->400 with: 'title'->'Libro 1' with: 'author'->'Pepe');
		at: 'ISBN2' put: (Dictionary with: 'price'->450 with: 'title'->'Libro 2' with: 'author'->'Juana');
		yourself ! !

!TusLibrosRESTController methodsFor: 'object creation' stamp: 'TCM 12/1/2019 19:31:06'!
creditCardDataByUser
	^ Dictionary
		with: 'Tobi' -> 
			(Dictionary 
				with: 'number' -> '12345678'
				with: 'owner' -> 'TOBI'
				with: 'expiration'-> Month current)
		with: 'Santi' -> 
			(Dictionary 
				with: 'number' -> '12345679'
				with: 'owner' -> 'SANTI'
				with: 'expiration'-> (Month month: 1 year: 1990)).! !

!TusLibrosRESTController methodsFor: 'object creation' stamp: 'TCM 11/21/2019 20:22:07'!
merchantProcessor
	^ MerchantProcessorStub new! !

!TusLibrosRESTController methodsFor: 'object creation' stamp: 'TCM 11/21/2019 20:26:47'!
realTimeClock
	^ RealTimeClock new.! !

!TusLibrosRESTController methodsFor: 'object creation' stamp: 'TCM 12/1/2019 14:35:21'!
salesBook
	^ SalesBook new! !

!TusLibrosRESTController methodsFor: 'object creation' stamp: 'TCM 11/21/2019 20:18:44'!
usersAndPasswords
	^ Dictionary
		with: 'Tobi' -> 'password'
		with: 'Santi' -> '1234'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRESTController class' category: #'TusLibros-Model'!
TusLibrosRESTController class
	instanceVariableNames: ''!

!TusLibrosRESTController class methodsFor: 'instance creation' stamp: 'TCM 11/21/2019 20:11:21'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions booksDetails'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'TCM 12/1/2019 18:58:41'!
cartAlreadyCheckoutErrorMessage
	^ CartSession cartAlreadyCheckoutErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'TCM 11/22/2019 18:31:30'!
bookDetailsOf: aBook inCart: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession |
		| bookDetails |
		bookDetails := (catalog at: aBook) copy.
		bookDetails at: 'quantity' put: (cartSession amountOf: aBook).
		^ bookDetails
	]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'TCM 11/21/2019 20:52:12'!
catalog
	^ catalog copy! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'TCM 11/26/2019 19:56:25'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^ self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession |
			cartSession
				checkOutCartWithCreditCardNumbered: aCreditCartNumber
				ownedBy: anOwner
				expiringOn: anExpirationMonthOfYear.
		]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'TCM 12/1/2019 14:13:47'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [
		salesBook ticketFor: aUser ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'TCM 12/1/2019 19:20:45'!
ownerOf: aCartId 
	^ (cartSessions at: aCartId) owner! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'TCM 11/21/2019 20:02:45'!
remove: aBook fromCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeFromCart: aBook ]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:56'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
		oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newTotal ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'TCM 12/1/2019 14:02:23'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook salesDoneBy: aUser! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'TCM 11/22/2019 18:09:24'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.

	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !
