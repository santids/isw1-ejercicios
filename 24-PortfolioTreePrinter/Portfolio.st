!classDefinition: #PortfolioTest category: #Portfolio!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #Portfolio!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TCM 10/21/2019 20:26:24'!
test08TransferBetweenTwoReceptiveAccountsMovesMoneyFromOneToTheOther

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Deposit register: 100 on: account1.

	transfer := Transfer register: 40 from: account1 to: account2.

	self assert: 60 equals: account1 balance.
	self assert: 40 equals: account2 balance.

	self assert: (account1 transactions includes: transfer withdraw).
	self assert: (account2 transactions includes: transfer deposit)! !


!classDefinition: #ReportTest category: #Portfolio!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReportTest methodsFor: 'tests - AccountSummary' stamp: 'TCM 10/21/2019 20:33:24'!
test01NewAccountHasAccountSummaryWithBalanceZero
	
	| account summary |
	account := ReceptiveAccount new.

	summary := AccountSummary for: account.
	
	self assert: 'Balance = 0' equals: summary printString! !

!ReportTest methodsFor: 'tests - AccountSummary' stamp: 'TCM 10/21/2019 20:50:58'!
test02AccountWithOneDepositAccountSummaryPrintsTheDeposit
	
	| account summary expectedString |
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.

	summary := AccountSummary for: account.
	
	expectedString := 
		'Depósito por 100.', String newLineString, 
		'Balance = 100'.

	self assert: expectedString equals: summary printString! !

!ReportTest methodsFor: 'tests - AccountSummary' stamp: 'TCM 10/21/2019 20:59:45'!
test03AccountWithManyDepositsAccountSummaryPrintsThemAll
	
	| account summary expectedString |
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Deposit register: 300 on: account.
	Deposit register: 10 on: account.

	summary := AccountSummary for: account.
	
	expectedString := 
		'Depósito por 100.', String newLineString,
		'Depósito por 300.', String newLineString,
		'Depósito por 10.', String newLineString,
		'Balance = 410'.

	self assert: expectedString equals: summary printString! !

!ReportTest methodsFor: 'tests - AccountSummary' stamp: 'TCM 10/21/2019 21:05:28'!
test04AccountWithManyWithdrawsAccountSummaryPrintsThemAll
	
	| account summary expectedString |
	account := ReceptiveAccount new.
	
	Withdraw register: 100 on: account.
	Withdraw register: 300 on: account.
	Withdraw register: 10 on: account.

	summary := AccountSummary for: account.

	expectedString := 
		'Extracción por 100.', String newLineString,
		'Extracción por 300.', String newLineString,
		'Extracción por 10.', String newLineString,
		'Balance = -410'.

	self assert: expectedString equals: summary printString! !

!ReportTest methodsFor: 'tests - AccountSummary' stamp: 'TCM 10/21/2019 21:15:46'!
test05AccountWithTransferAccountSummaryPrintsCorrectly
	
	| account1 account2 expectedString1 expectedString2 summary1 summary2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer register: 10 from: account1 to: account2. 

	summary1 := AccountSummary for: account1.
	summary2 := AccountSummary for: account2.

	expectedString1 := 
		'Salida por transferencia de 10.', String newLineString,
		'Balance = -10'.

	expectedString2 := 
		'Entrada por transferencia de 10.', String newLineString,
		'Balance = 10'.

	self assert: expectedString1 equals: summary1 printString.
	self assert: expectedString2 equals: summary2 printString.! !


!ReportTest methodsFor: 'tests - TransferNet' stamp: 'TCM 10/21/2019 21:26:09'!
test06NewAccountHasTransferNetWithBalanceZero
	
	| account summary |
	account := ReceptiveAccount new.

	summary := TransferNet for: account.
	
	self assert: '0' equals: summary printString! !

!ReportTest methodsFor: 'tests - TransferNet' stamp: 'TCM 10/21/2019 21:35:10'!
test07AccountWithTransferHasTransferNetEqualToTransferValue
	
	| account1 account2 expectedString1 expectedString2 summary1 summary2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer register: 10 from: account1 to: account2. 

	summary1 := TransferNet for: account1.
	summary2 := TransferNet for: account2.

	expectedString1 := 
		'-10'.

      expectedString2 := '10'.


	self assert: expectedString1 equals: summary1 printString.
	self assert: expectedString2 equals: summary2 printString.! !

!ReportTest methodsFor: 'tests - TransferNet' stamp: 'TCM 10/21/2019 21:46:10'!
test08TransferNetShouldIgnoreDepositsAndWithdraws
	
	| account1 account2 expectedString1 expectedString2 summary1 summary2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer register: 10 from: account1 to: account2. 
	
	Deposit  register: 100 on: account1.
	Withdraw register: 15 on: account2.

	summary1 := TransferNet for: account1.
	summary2 := TransferNet for: account2.

	expectedString1 := 
		'-10'.

      expectedString2 := '10'.


	self assert: expectedString1 equals: summary1 printString.
	self assert: expectedString2 equals: summary2 printString.! !


!classDefinition: #Account category: #Portfolio!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #Portfolio!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #Portfolio!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #Portfolio!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #Portfolio!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'TCM 10/24/2019 14:14:23'!
accept: aReporter
	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #Portfolio!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #Portfolio!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor' stamp: 'TCM 10/24/2019 14:17:53'!
accept: aReporter
	^ aReporter reportDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #Portfolio!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: #Portfolio!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'TCM 10/21/2019 20:10:45'!
initializeFor: aTransfer
	transfer := aTransfer! !


!TransferDeposit methodsFor: 'value' stamp: 'TCM 10/21/2019 20:11:24'!
value
	^ transfer value! !


!TransferDeposit methodsFor: 'visitor' stamp: 'TCM 10/24/2019 14:18:03'!
accept: aReporter
	^ aReporter reportTransferDeposit: self! !


!TransferDeposit methodsFor: 'balance' stamp: 'TCM 10/21/2019 20:12:09'!
affectBalance: aBalance

	^aBalance + self value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #Portfolio!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:22:31'!
for: aTransfer 
	^ self basicNew initializeFor: aTransfer
	! !


!classDefinition: #TransferWithdraw category: #Portfolio!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'TCM 10/21/2019 20:10:53'!
initializeFor: aTransfer
	transfer := aTransfer! !


!TransferWithdraw methodsFor: 'value' stamp: 'TCM 10/21/2019 20:22:51'!
value

	^ transfer value! !


!TransferWithdraw methodsFor: 'visitor' stamp: 'TCM 10/24/2019 14:18:08'!
accept: aReporter
	^ aReporter reportTransferWithdraw: self! !


!TransferWithdraw methodsFor: 'balance' stamp: 'TCM 10/21/2019 20:12:20'!
affectBalance: aBalance

	^aBalance - self value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #Portfolio!
TransferWithdraw class
	instanceVariableNames: 'transfer'!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:22:36'!
for: aTransfer 
	^ self basicNew initializeFor: aTransfer
	! !


!classDefinition: #Withdraw category: #Portfolio!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor' stamp: 'TCM 10/24/2019 14:18:13'!
accept: aReporter
	^ aReporter reportWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #Portfolio!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #Portfolio!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Report methodsFor: 'value' stamp: 'TCM 10/24/2019 14:33:40'!
printString
	self subclassResponsibility ! !


!Report methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:32:56'!
reportDeposit: aDepositTransaction
	self subclassResponsibility ! !

!Report methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:33:27'!
reportTransferDeposit: aTransferDepositTransaction
	self subclassResponsibility ! !

!Report methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:33:16'!
reportTransferWithdraw: aTransferWithdrawTransaction
	self subclassResponsibility ! !

!Report methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:33:08'!
reportWithdraw: aWithdrawTransaction
	self subclassResponsibility ! !


!Report methodsFor: 'initialization' stamp: 'TCM 10/24/2019 14:31:51'!
initializeFor: anAccount 
	account := anAccount! !


!classDefinition: #AccountSummary category: #Portfolio!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummary methodsFor: 'value' stamp: 'TCM 10/24/2019 14:21:49'!
printString
	| reportString |

	reportString := (account transactions inject: '' into: [ :acc :transaction |
		 acc, (transaction accept: self) , String newLineString 
	]).

	^  reportString , 'Balance = ', account balance printString! !


!AccountSummary methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:18:58'!
reportDeposit: aDepositTransaction
	^ 'Depósito por ', aDepositTransaction value printString, '.'! !

!AccountSummary methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:19:22'!
reportTransferDeposit: aTransferDepositTransaction
	^ 'Entrada por transferencia de ', aTransferDepositTransaction value printString, '.'! !

!AccountSummary methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:19:44'!
reportTransferWithdraw: aTransferWithdrawTransaction
	^ 'Salida por transferencia de ', aTransferWithdrawTransaction value printString, '.'! !

!AccountSummary methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:20:04'!
reportWithdraw: aWithdrawTransaction
	^ 'Extracción por ', aWithdrawTransaction value printString, '.'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #Portfolio!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:34:10'!
for: aReceptiveAccount 
	^ self basicNew initializeFor: aReceptiveAccount ! !


!classDefinition: #TransferNet category: #Portfolio!
Report subclass: #TransferNet
	instanceVariableNames: 'balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferNet methodsFor: 'value' stamp: 'TCM 10/24/2019 14:33:55'!
printString
	balance := 0.

	account transactions
		do: [ :aTransaction | balance := aTransaction accept: self ].

	^ balance printString.! !


!TransferNet methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:26:55'!
reportDeposit: aDepositTransaction
	^ balance
! !

!TransferNet methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:27:47'!
reportTransferDeposit: aTransferDepositTransaction
	^ aTransferDepositTransaction affectBalance: balance
! !

!TransferNet methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:27:28'!
reportTransferWithdraw: aTransferWithdrawTransaction
	^ aTransferWithdrawTransaction affectBalance: balance
! !

!TransferNet methodsFor: 'visit' stamp: 'TCM 10/24/2019 14:27:05'!
reportWithdraw: aWithdrawTransaction
	^ balance
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #Portfolio!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 21:27:24'!
for: anAccount 
	^ self basicNew initializeFor: anAccount! !


!classDefinition: #Transfer category: #Portfolio!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:07:47'!
deposit
	^deposit! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:05:33'!
initiliazeFor: aValue 
	value := aValue.
	deposit := TransferDeposit for: self.
	withdraw := TransferWithdraw for: self.
! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:23:04'!
value
	
	^ value! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:07:36'!
withdraw
	^withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #Portfolio!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'TCM 10/21/2019 20:04:18'!
register: aValue from: aTransferSender to: aTransferReceiver
	| transfer |
	transfer := self basicNew initiliazeFor: aValue.

	aTransferSender register: transfer withdraw.
	aTransferReceiver  register: transfer deposit.

	^ transfer! !
