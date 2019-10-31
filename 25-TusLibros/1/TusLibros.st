!classDefinition: #ShoppingCartTest category: #TusLibros stamp: 'TCM 10/29/2019 21:48:03'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'aBook anotherBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:34:40'!
setUp
	aBook := Book new.
	anotherBook := Book new.
! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 20:48:15'!
test01NewCartIsEmpty

	| cart |
	cart := ShoppingCart new.

	self assert: cart isEmpty! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 20:59:25'!
test02CartIsNotEmptyAfterAddingABook

	| cart |
	cart := ShoppingCart new.

	cart add: aBook withQuantity: 1.

	self deny: cart isEmpty! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:06:28'!
test03BookNotAddedToCartIsNotIncluded

	| cart |
	cart := ShoppingCart new.

	self deny: (cart includes: aBook)! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:06:36'!
test04BookAddedToCartIsIncluded

	| cart |
	cart := ShoppingCart new.
	
	cart add: aBook withQuantity: 1.

	self assert: (cart includes: aBook)! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:08:38'!
test05QuantityOfNotIncludedBookInShoppingCartIsZero

	| cart |
	cart := ShoppingCart new.

	self assert: 0 equals: (cart quantityOf: aBook)! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:11:29'!
test06QuantityOfBookAddedOnceIsTheAmountAdded

	| cart |
	cart := ShoppingCart new.

	cart add: aBook withQuantity: 2.

	self assert: 2 equals: (cart quantityOf: aBook)! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:12:56'!
test07QuantityOfBookAddedManyTimesIsTheAmountAdded

	| cart |
	cart := ShoppingCart new.

	cart add: aBook withQuantity: 2.
	cart add: aBook withQuantity: 4.

	self assert: 6 equals: (cart quantityOf: aBook)! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:21:38'!
test08AddingLessThanOneBookFails

	| cart |
	cart := ShoppingCart new.

	self should: [
		cart add: aBook withQuantity: 0. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ShoppingCart cannotAddLessThanOneBookErrorMessage.

	self assert: cart isEmpty! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:28:47'!
test09IterateOverEmptyCartDoesNothing

	| cart |
	cart := ShoppingCart new.

	cart purchaseRequestsDo: [ :book :quantity |
		self fail
	]! !

!ShoppingCartTest methodsFor: 'tests - ShoppingCart' stamp: 'TCM 10/29/2019 21:41:41'!
test10IterateOverShoppingCartWithPurchaseRequestsVisitsAllOfThem

	| cart expectedList list |
	cart := ShoppingCart new.

	cart add: aBook withQuantity: 2.
	cart add: anotherBook withQuantity: 1.
	
	list := Bag new.

	cart purchaseRequestsDo: [ :book :quantity |
		list add: (Array with: book with: quantity)
	].

	expectedList := Bag 
		with: (Array with: aBook with: 2) 
		with: (Array with: anotherBook with: 1).

	self assert: expectedList equals: list! !


!classDefinition: #Book category: #TusLibros stamp: 'TCM 10/29/2019 21:48:03'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #ShoppingCart category: #TusLibros stamp: 'TCM 10/29/2019 21:48:03'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'initialization' stamp: 'TCM 10/29/2019 20:55:58'!
initialize 
	books := Dictionary new.! !


!ShoppingCart methodsFor: 'testing' stamp: 'TCM 10/29/2019 21:06:07'!
includes: aBook 
	^ books includesKey: aBook.! !

!ShoppingCart methodsFor: 'testing' stamp: 'TCM 10/29/2019 20:56:19'!
isEmpty
	^ books isEmpty! !


!ShoppingCart methodsFor: 'assertions' stamp: 'TCM 10/29/2019 21:24:05'!
assertValidQuantity: aQuantity

	^ aQuantity < 1 ifTrue: [ self error: self class cannotAddLessThanOneBookErrorMessage ]! !


!ShoppingCart methodsFor: 'adding' stamp: 'TCM 10/29/2019 21:24:05'!
add: aBook withQuantity: aQuantity 

	self assertValidQuantity: aQuantity.

	books at: aBook ifAbsentPut: 0.
	books at: aBook put: (books at: aBook) + aQuantity! !


!ShoppingCart methodsFor: 'accessing' stamp: 'TCM 10/29/2019 21:12:16'!
quantityOf: aBook 
	^ books at: aBook ifAbsent: 0! !


!ShoppingCart methodsFor: 'enumerating' stamp: 'TCM 10/29/2019 21:38:56'!
purchaseRequestsDo: aBlockClosure 
	books associationsDo: [ :association | aBlockClosure value: association  key value: association value ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #TusLibros stamp: 'TCM 10/29/2019 21:48:03'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'error messages' stamp: 'TCM 10/29/2019 21:22:24'!
cannotAddLessThanOneBookErrorMessage
	^ 'No se puede agregar una cantidad menor a 1 de libros'! !
