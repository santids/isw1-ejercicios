!classDefinition: #FinancialAsset category: #'Portfolio-Ejercicio'!
TestCase subclass: #FinancialAsset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'testing' stamp: 'SAS 10/17/2019 20:29:27'!
hasConflictWith: aReceptiveAccount
	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'testing' stamp: 'SAS 10/17/2019 20:29:40'!
hasRegistered: aTransaction 
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'transactions' stamp: 'SAS 10/17/2019 21:37:17'!
addParent: aFinancialAsset
	parents add: aFinancialAsset.! !

!FinancialAsset methodsFor: 'transactions' stamp: 'SAS 10/17/2019 21:39:32'!
initialize
	parents := OrderedCollection new.! !

!FinancialAsset methodsFor: 'transactions' stamp: 'SAS 10/17/2019 20:30:07'!
transactions 
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'balance' stamp: 'SAS 10/17/2019 20:29:12'!
balance
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'SAS 10/17/2019 20:47:16'!
hasConflictWith: aFinancialAsset
	^ aFinancialAsset = self or: [ collection anySatisfy: [ :financialAsset | financialAsset hasConflictWith: aFinancialAsset ]. ].
	! !

!Portfolio methodsFor: 'testing' stamp: 'SAS 10/17/2019 20:48:11'!
hasRegistered: aTransaction 
	^ collection anySatisfy: [ :financialAsset | financialAsset hasRegistered: aTransaction ].! !


!Portfolio methodsFor: 'assertions' stamp: 'SAS 10/17/2019 21:42:46'!
assertItHasNoConflict: aFinancialAsset
	(collection anySatisfy: [ :financialAsset | financialAsset  hasConflictWith: aFinancialAsset ] ) ifTrue: [ self error: self class cannotAddRepeatedAccountErrorMessage ].
	! !

!Portfolio methodsFor: 'assertions' stamp: 'SAS 10/17/2019 21:44:14'!
assertItIsNotInPortfolioYet: aFinancialAsset


	| roots |
	roots := self getRoots.
	
	
	roots do: [ :aFinancialAssetRoot | aFinancialAssetRoot assertItHasNoConflict: aFinancialAsset ]	! !

!Portfolio methodsFor: 'assertions' stamp: 'SAS 10/17/2019 21:50:21'!
getRoots
 	| roots |
	roots := (parents  inject: OrderedCollection  new into: [ :a :p | a, p getRoots ]).
	
	roots isEmpty ifTrue:  [ ^ OrderedCollection with: self ].
	
	^ roots.! !


!Portfolio methodsFor: 'initialization' stamp: 'SAS 10/17/2019 21:36:36'!
initialize
	super initialize.
	collection := OrderedCollection new.
! !


!Portfolio methodsFor: 'adding' stamp: 'SAS 10/17/2019 21:32:04'!
add: aFinancialAsset 

	self assertItIsNotInPortfolioYet: aFinancialAsset .
	
	aFinancialAsset addParent: self.
	collection add: aFinancialAsset.! !


!Portfolio methodsFor: 'transactions' stamp: 'SAS 10/17/2019 20:54:02'!
transactions
	^ collection inject: OrderedCollection  new into: [ :transactionsAcumulator :financialAsset | transactionsAcumulator,financialAsset transactions].! !


!Portfolio methodsFor: 'balance' stamp: 'SAS 10/17/2019 20:48:23'!
balance
	^ collection sum: [ :financialAsset | financialAsset balance ] ifEmpty: [ 0 ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 19:51:49'!
cannotAddRepeatedAccountErrorMessage
	^ 'No se puede agregar una cuenta que ya se encuentra en el portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'SAS 10/17/2019 21:36:44'!
initialize
	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'SAS 10/17/2019 18:43:24'!
balance

	^transactions sum: [ :aTransaction | aTransaction deltaValue ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'SAS 10/17/2019 19:59:25'!
hasConflictWith: aReceptiveAccount
	^ aReceptiveAccount  = self.
	! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:26:18'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 18:50:24'!
test02AddAnAccountMakesPortfolioBalanceEqualsAccountsBalance

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	Deposit  register: 100 on: account. 
	portfolio add: account.
	
	self assert: 100 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 18:54:42'!
test03AddManyAccountsMakesPortfolioBalanceEqualsAccountsBalanceSum

	| portfolio account1 account2 account3 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit  register: 100 on: account1. 
	portfolio add: account1.
	
	Withdraw  register: 20 on: account2. 
	portfolio add: account2.
	
	Deposit  register: 50 on: account3. 
	portfolio add: account3.
	
	self assert: 130 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:11:53'!
test03dot5APortfolioWithAccountsAndPortfoliosBalanceEqualsAllAccountsBalance
	| portfolio account1 account2 childPortfolio account3 account4 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	

	Deposit register: 100 on: account1.
	Deposit register: 200 on: account1.
	Deposit register: 300 on: account1.
	
	Deposit register: 10 on: account2.
	Deposit register: 20 on: account2.
	Deposit register: 30 on: account2.
			
	Deposit register: 10 on: account3.
	Deposit register: 20 on: account3.
	Deposit register: 30 on: account3.

	Deposit register: 10 on: account4.
	Deposit register: 20 on: account4.
	Deposit register: 30 on: account4.
		

	portfolio add: account1.
	portfolio add: account2.
	
	childPortfolio  := Portfolio  new.
	childPortfolio add: account3.
	childPortfolio  add: account4.
	
	portfolio  add: childPortfolio.

	self assert: 780 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:14:38'!
test04APortfolioWithManyAccountsShouldHaveRegisteredAllTransactionsRegisteredInEveryAccount
	| portfolio  transaction1 account1 account2 transaction2 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	transaction1 := Deposit  register: 100 on: account1.	
	portfolio add: account1.
	
	
	transaction2 := Deposit  register: 100 on: account2.	
	portfolio add: account2.
	
	
	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 19:05:34'!
test05APortfolioWithAnAccountShouldNotHaveRegisteredATransactionNotRegisteredInTheAccount
	| portfolio account  transaction|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.

	transaction := Deposit  for: 100.	
	portfolio add: account.
	
	self deny: (portfolio hasRegistered: transaction).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:25:56'!
test05dot5InAPorfolioWithAccountsAndPortfoliosHasRegisteredTransactionRegisteredInAccountInsideChildPortfolio
	| portfolio account1 account2 childPortfolio account3 account4 transaction |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	transaction := Deposit register: 30 on: account4.
		
	portfolio add: account1.
	portfolio add: account2.
	
	childPortfolio  := Portfolio  new.
	childPortfolio add: account3.
	childPortfolio  add: account4.
	
	portfolio  add: childPortfolio.
	

	self assert: (portfolio  hasRegistered: transaction) 
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 19:10:47'!
test06AnEmptyPortfolioShouldHaveEmptyTransactions
	| portfolio |
	
	portfolio := Portfolio new.

	self assert: (portfolio transactions isEmpty).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 19:29:09'!
test07APorfolioWithAnAccountShouldHaveSameTransactionsThanTheAccountInOrder
	| portfolio account transactions|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	transactions  := Array 
		with: (Deposit register: 100 on: account) 
		with: (Deposit register: 200 on: account) 
		with: (Deposit register: 300 on: account).
		
	portfolio add: account.

	self assert: transactions equals: portfolio transactions asArray.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 19:36:03'!
test08APorfolioWithManyAccountShouldHaveTheTransactionsOfAllTheAccounts
	| portfolio account transactions1 transactions2 account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transactions1  := Array 
		with: (Deposit register: 100 on: account1) 
		with: (Deposit register: 200 on: account1) 
		with: (Deposit register: 300 on: account1).
		
	transactions2  := Array 
		with: (Deposit register: 10 on: account2) 
		with: (Deposit register: 20 on: account2) 
		with: (Deposit register: 30 on: account2).
		

	portfolio add: account1.
	portfolio add: account2.

	self assert: (transactions1,transactions2) asBag equals: portfolio transactions asBag.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:25:38'!
test09InAPorfolioWithAccountsAndPortfoliosHasAllTransactionsRegisteredInAllAccounts
	| portfolio transactions1 transactions2 account1 account2 childPortfolio transactions3 account3 account4 transactions4 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	transactions1  := Array 
		with: (Deposit register: 100 on: account1) 
		with: (Deposit register: 200 on: account1) 
		with: (Deposit register: 300 on: account1).
		
	transactions2  := Array 
		with: (Deposit register: 10 on: account2) 
		with: (Deposit register: 20 on: account2) 
		with: (Deposit register: 30 on: account2).
		
	transactions3  := Array 
		with: (Deposit register: 10 on: account3) 
		with: (Deposit register: 20 on: account3) 
		with: (Deposit register: 30 on: account3).
		
	transactions4  := Array 
		with: (Deposit register: 10 on: account4) 
		with: (Deposit register: 20 on: account4) 
		with: (Deposit register: 30 on: account4).
		

	portfolio add: account1.
	portfolio add: account2.
	
	childPortfolio  := Portfolio  new.
	childPortfolio add: account3.
	childPortfolio  add: account4.
	
	portfolio  add: childPortfolio.

	self assert: (transactions1,transactions2, transactions3, transactions4 ) asBag equals: portfolio transactions asBag.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:25:21'!
test10InAPorfolioWithOnlyAccountsEnsureThereAreNotRepeatedAccounts
	
	| portfolio account1 account2 transaction1 transaction2 |

	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transaction1 := Deposit register: 100 on: account1 .
	transaction2 := Deposit register: 100 on: account2 .

	portfolio add: account1.
	portfolio add: account2.
	
	self 
		should: [ portfolio  add: account2 ]
		raise:  Error  - MessageNotUnderstood 
		withMessageText: Portfolio cannotAddRepeatedAccountErrorMessage.
		
	self assert:  (Bag with: transaction1 with: transaction2 ) equals: portfolio transactions  asBag.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:26:40'!
test11InAPorfolioWithAccountsAndPortfoliosEnsureThereAreNotRepeatedAccounts
	| portfolio transactions1 transactions2 account1 account2 childPortfolio transactions3 account3 account4 transactions4 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	transactions1  := Array 
		with: (Deposit register: 100 on: account1) 
		with: (Deposit register: 200 on: account1) 
		with: (Deposit register: 300 on: account1).
		
	transactions2  := Array 
		with: (Deposit register: 10 on: account2) 
		with: (Deposit register: 20 on: account2) 
		with: (Deposit register: 30 on: account2).
		
	transactions3  := Array 
		with: (Deposit register: 10 on: account3) 
		with: (Deposit register: 20 on: account3) 
		with: (Deposit register: 30 on: account3).
		
	transactions4  := Array 
		with: (Deposit register: 10 on: account4) 
		with: (Deposit register: 20 on: account4) 
		with: (Deposit register: 30 on: account4).
		

	portfolio add: account1.
	portfolio add: account2.
	
	childPortfolio  := Portfolio  new.
	childPortfolio add: account3.
	childPortfolio  add: account4.
	
	portfolio  add: childPortfolio.
	
	self 
		should: [ portfolio  add: account3 ]
		raise:  Error  - MessageNotUnderstood 
		withMessageText: Portfolio cannotAddRepeatedAccountErrorMessage.
	

	self assert: (transactions1,transactions2, transactions3, transactions4 ) asBag equals: portfolio transactions asBag.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 21:00:38'!
test12InAPorfolioWithAccountsAndPortfoliosNestedEnsureThereAreNotRepeatedAccounts
	| portfolio transactions1 transactions2 account1 account2 childPortfolio transactions3 account3 account4 transactions4 account5 transactions5 childChildPortfolio anotherPortfolio |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	account5 := ReceptiveAccount new.
	
	transactions1  := Array 
		with: (Deposit register: 100 on: account1) 
		with: (Deposit register: 200 on: account1) 
		with: (Deposit register: 300 on: account1).
		
	transactions2  := Array 
		with: (Deposit register: 10 on: account2) 
		with: (Deposit register: 20 on: account2) 
		with: (Deposit register: 30 on: account2).
		
	transactions3  := Array 
		with: (Deposit register: 10 on: account3) 
		with: (Deposit register: 20 on: account3) 
		with: (Deposit register: 30 on: account3).
		
	transactions4  := Array 
		with: (Deposit register: 10 on: account4) 
		with: (Deposit register: 20 on: account4) 
		with: (Deposit register: 30 on: account4).
	
	transactions5  := Array 
		with: (Deposit register: 10 on: account5) 
		with: (Deposit register: 20 on: account5) 
		with: (Deposit register: 30 on: account5).
		

	portfolio add: account1.
	portfolio add: account2.
	
	childPortfolio  := Portfolio  new.
	childPortfolio add: account3.
	childPortfolio  add: account4.
	
	childChildPortfolio := Portfolio  new.
	childPortfolio add: childChildPortfolio.
	
	childChildPortfolio  add: account5.
	
	anotherPortfolio := Portfolio new.
	
	portfolio  add: childPortfolio.
	
	self 
		should: [ portfolio  add: account5 ]
		raise:  Error - MessageNotUnderstood 
		withMessageText: Portfolio cannotAddRepeatedAccountErrorMessage.
	

	self assert: (transactions1,transactions2, transactions3, transactions4,transactions5) asBag equals: portfolio transactions asBag.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 20:46:08'!
test13InAPorfolioWithAccountsAndPortfoliosNestedEnsureThereAreNotRepeatedPortfolios
	| portfolio transactions1 transactions2 account1 account2 childPortfolio transactions3 account3 account4 transactions4 account5 transactions5 childChildPortfolio |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	account5 := ReceptiveAccount new.
	
	transactions1  := Array 
		with: (Deposit register: 100 on: account1) 
		with: (Deposit register: 200 on: account1) 
		with: (Deposit register: 300 on: account1).
		
	transactions2  := Array 
		with: (Deposit register: 10 on: account2) 
		with: (Deposit register: 20 on: account2) 
		with: (Deposit register: 30 on: account2).
		
	transactions3  := Array 
		with: (Deposit register: 10 on: account3) 
		with: (Deposit register: 20 on: account3) 
		with: (Deposit register: 30 on: account3).
		
	transactions4  := Array 
		with: (Deposit register: 10 on: account4) 
		with: (Deposit register: 20 on: account4) 
		with: (Deposit register: 30 on: account4).
	
	transactions5  := Array 
		with: (Deposit register: 10 on: account5) 
		with: (Deposit register: 20 on: account5) 
		with: (Deposit register: 30 on: account5).
		

	portfolio add: account1.
	portfolio add: account2.
	
	childPortfolio  := Portfolio  new.
	childPortfolio add: account3.
	childPortfolio  add: account4.
	
	childChildPortfolio := Portfolio  new.
	childPortfolio add: childChildPortfolio.
	
	childChildPortfolio  add: account5.
	

	
	portfolio  add: childPortfolio.
	
	self 
		should: [ portfolio  add: childChildPortfolio ]
		raise:  Error  - MessageNotUnderstood 
		withMessageText: Portfolio cannotAddRepeatedAccountErrorMessage.
	

	self assert: (transactions1,transactions2, transactions3, transactions4,transactions5) asBag equals: portfolio transactions asBag.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SAS 10/17/2019 21:30:06'!
test14AnotherCaseInAPorfolioWithAccountsAndPortfoliosNestedEnsureThereAreNotRepeatedPortfolios
	| account1 portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio1 add: account1.
	portfolio2 add: account1.
	portfolio2 add: portfolio3.

	
	self 
		should: [ portfolio3  add: portfolio1 ]
		raise:  Error  - MessageNotUnderstood 
		withMessageText: Portfolio cannotAddRepeatedAccountErrorMessage.
	

! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'SAS 10/17/2019 18:42:45'!
deltaValue
	^ self value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'SAS 10/17/2019 18:42:59'!
deltaValue
	^ self value negated.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
