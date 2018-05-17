!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |

	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.    
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self 
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	
	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.
	
	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).
	
	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AD 5/15/2018 15:49:39'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder
	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	complexPortfolio _ Portfolio
		with: account1
		with: account2.
	composedPortfolio _ Portfolio
		with: complexPortfolio
		with: account3.
	accountNames _ Dictionary new.
	accountNames
		at: composedPortfolio
		put: 'composedPortfolio'.
	accountNames
		at: complexPortfolio
		put: 'complexPortfolio'.
	accountNames
		at: account1
		put: 'account1'.
	accountNames
		at: account2
		put: 'account2'.
	accountNames
		at: account3
		put: 'account3'.
	lines _ self
		portfolioTreeOf: composedPortfolio
		namingAccountWith: accountNames.
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AD 5/15/2018 15:50:05'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves
	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	complexPortfolio _ Portfolio
		with: account1
		with: account2.
	composedPortfolio _ Portfolio
		with: complexPortfolio
		with: account3.
	accountNames _ Dictionary new.
	accountNames
		at: composedPortfolio
		put: 'composedPortfolio'.
	accountNames
		at: complexPortfolio
		put: 'complexPortfolio'.
	accountNames
		at: account1
		put: 'account1'.
	accountNames
		at: account2
		put: 'account2'.
	accountNames
		at: account3
		put: 'account3'.
	lines _ self
		reversePortfolioTreeOf: composedPortfolio
		namingAccountWith: accountNames.
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).! !


!PortfolioTest methodsFor: 'test support' stamp: 'AD 5/16/2018 16:50:39'!
accountSummaryLinesOf: aReceptiveAccount
	^ (AccountSummaryVisitor for: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'AD 5/16/2018 16:50:39'!
accountTransferNetOf: anAccount
	^ (AccountTransferNetVisitor for: anAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'AD 5/16/2018 16:50:39'!
investmentEarningsOf: anAccount
	^ (AccountInvestmentEarningsVisitor for: anAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'AD 5/16/2018 16:50:39'!
investmentNetOf: anAccount
	^ (AccountInvestmentNetVisitor for: anAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'AD 5/16/2018 16:39:17'!
portfolioTreeOf: aPortfolio namingAccountWith: aDictionary
	^ (PortfolioDepthFirstTreePrinterVisitor
		for: aPortfolio
		namingAccountsWith: aDictionary) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'AD 5/16/2018 16:39:43'!
reversePortfolioTreeOf: aPortfolio namingAccountWith: aDictionary
	^ (PorfolioReverseTreePrinterVisitor
		for: aPortfolio
		namingAccountsWith: aDictionary) value.! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'accessing' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'AD 5/10/2018 20:46:29'!
affectBalance: aBalance
	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'visitor acceptance' stamp: 'AD 5/15/2018 15:01:39'!
accept: aVisitor

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'AD 5/10/2018 21:12:59'!
initializeFor: aValue during: anAmountOfDays at: aTNA on: anAccount
	
	value _ aValue.
	numberOfDays _ anAmountOfDays.
	tna _ aTNA.
	account _ anAccount.! !


!CertificateOfDeposit methodsFor: 'accessing' stamp: 'AD 5/14/2018 19:04:49'!
numberOfDays

	^ numberOfDays! !

!CertificateOfDeposit methodsFor: 'accessing' stamp: 'AD 5/14/2018 19:04:58'!
tna

	^ tna! !

!CertificateOfDeposit methodsFor: 'accessing' stamp: 'AD 5/10/2018 21:16:21'!
value

	^ value! !


!CertificateOfDeposit methodsFor: 'balance' stamp: 'AD 5/12/2018 13:04:24'!
affectBalance: aBalance

	^ aBalance - value.! !


!CertificateOfDeposit methodsFor: 'visitor acceptance' stamp: 'AD 5/15/2018 15:03:39'!
accept: aVisitor

	^ aVisitor visitCertificateOfDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'AD 5/10/2018 21:12:31'!
for: aValue during: anAmountOfDays at: aTNA on: anAccount
	
	^ self new initializeFor: aValue during: anAmountOfDays at: aTNA on: anAccount! !

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'AD 5/10/2018 21:12:16'!
register: aValue during: anAmountOfDays at: aTNA on: anAccount 

	| certificate |
	
	certificate := self for: aValue during: anAmountOfDays at: aTNA on: anAccount.
	anAccount register: certificate.
		
	^ certificate
	
	! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AD 5/12/2018 10:50:47'!
affectBalance: aBalance
	^ aBalance + value.! !


!Deposit methodsFor: 'visitor acceptance' stamp: 'AD 5/15/2018 15:05:09'!
accept: aVisitor

	^ aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'account transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'initialization' stamp: 'AD 5/14/2018 18:09:59'!
initializeOn: anAccount asTransactionOf: aTransfer

	account _ anAccount.
	
	transfer _ aTransfer.
	! !


!TransferLeg methodsFor: 'accessing' stamp: 'AD 5/14/2018 18:11:18'!
affectedAccount

	^ account! !

!TransferLeg methodsFor: 'accessing' stamp: 'AD 5/14/2018 18:37:52'!
transfer

	^ transfer! !

!TransferLeg methodsFor: 'accessing' stamp: 'AD 5/14/2018 18:16:11'!
value

	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'AD 5/14/2018 18:07:39'!
on: aAccount asTransactionOf: aTransfer

	^ self new initializeOn: aAccount asTransactionOf: aTransfer! !

!TransferLeg class methodsFor: 'instance creation' stamp: 'AD 5/14/2018 18:07:01'!
registerOn: aAccount asTransactionOf: aTransfer 
	
	| transferLeg |
	
	transferLeg := self on: aAccount asTransactionOf: aTransfer.
	aAccount register: transferLeg.
		
	^ transferLeg! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'balance' stamp: 'AD 5/12/2018 21:06:43'!
affectBalance: aBalance

	^ aBalance + self value.! !


!TransferDeposit methodsFor: 'visitor acceptance' stamp: 'AD 5/15/2018 15:09:22'!
accept: aVisitor

	^ aVisitor visitTransferDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'initialization' stamp: 'AD 5/12/2018 12:39:30'!
for: aValue on: aReceptiveAccount asTransactionOf: aTransfer

	^ self new initializeFor: aValue on: aReceptiveAccount asTransactionOf: aTransfer
	
	! !

!TransferDeposit class methodsFor: 'initialization' stamp: 'AD 5/12/2018 12:42:59'!
register: aValue on: aAccount asTransactionOf: aTransfer 
	
	| transferDeposit |
	
	transferDeposit := self for: aValue on: aAccount asTransactionOf: aTransfer.
	aAccount register: transferDeposit.
		
	^ transferDeposit
	
	! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'balance' stamp: 'AD 5/14/2018 17:18:20'!
affectBalance: aBalance

	^ aBalance - self value.! !


!TransferWithdraw methodsFor: 'visitor acceptance' stamp: 'AD 5/15/2018 15:10:38'!
accept: aVisitor

	^ aVisitor visitTransferWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'initialization' stamp: 'AD 5/12/2018 12:40:28'!
for: aValue on: aReceptiveAccount asTransactionOf: aTransfer

	^self new initializeFor: aValue on: aReceptiveAccount asTransactionOf: aTransfer
	
	! !

!TransferWithdraw class methodsFor: 'initialization' stamp: 'AD 5/12/2018 12:45:38'!
register: aValue on: aAccount asTransactionOf: aTransfer 

	
	| transferWithdraw |
	
	transferWithdraw := self for: aValue on: aAccount asTransactionOf: aTransfer.
	aAccount register: transferWithdraw.
		
	^ transferWithdraw
	
	! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'accessing' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'balance' stamp: 'AD 5/12/2018 10:50:40'!
affectBalance: aBalance
	^ aBalance - value.! !


!Withdraw methodsFor: 'visitor acceptance' stamp: 'AD 5/15/2018 15:11:13'!
accept: aVisitor

	^ aVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountTransactionsVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransactionsVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransactionsVisitor methodsFor: 'value' stamp: 'AD 5/16/2018 16:51:33'!
value

	^ self subclassResponsibility
	
! !


!AccountTransactionsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:58'!
visitCertificateOfDeposit: aCertificateOfDeposit

	self subclassResponsibility! !

!AccountTransactionsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:31'!
visitDeposit: aDeposit

	self subclassResponsibility! !

!AccountTransactionsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:58'!
visitTransferDeposit: aTranferDeposit

	self subclassResponsibility! !

!AccountTransactionsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:28'!
visitTransferWithdraw: aTransferWithdraw

	self subclassResponsibility! !

!AccountTransactionsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:54:56'!
visitWithdraw: aWithdraw

	self subclassResponsibility! !


!AccountTransactionsVisitor methodsFor: 'initialization' stamp: 'AD 5/16/2018 16:51:19'!
initializeFor: anAccount

	account _ anAccount.! !


!AccountTransactionsVisitor methodsFor: 'transactions' stamp: 'AD 5/16/2018 17:35:23'!
accountTransactionsSum: aBlock

	| sum |
	
	sum  _ 0.
	
	account transactionsDo: [:transaction | sum _ sum + (aBlock value: transaction)].
	
	^ sum! !

!AccountTransactionsVisitor methodsFor: 'transactions' stamp: 'AD 5/16/2018 17:49:12'!
sumTransactionsAcceptance

	^ self accountTransactionsSum: [:transaction | transaction accept: self].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransactionsVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor class
	instanceVariableNames: ''!

!AccountTransactionsVisitor class methodsFor: 'instance creation' stamp: 'AD 5/16/2018 16:51:15'!
for: anAccount
	^ self new initializeFor: anAccount.! !


!classDefinition: #AccountInvestmentEarningsVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountInvestmentEarningsVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentEarningsVisitor methodsFor: 'value' stamp: 'AD 5/16/2018 17:50:30'!
value

	^ self sumTransactionsAcceptance
	
! !


!AccountInvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:57:16'!
visitCertificateOfDeposit: aCertificateOfDeposit

	^ aCertificateOfDeposit value * (aCertificateOfDeposit tna / 360) * aCertificateOfDeposit numberOfDays.! !

!AccountInvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:42'!
visitDeposit: aDeposit

	^ 0.! !

!AccountInvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:08'!
visitTransferDeposit: aTranferDeposit

	^ 0.! !

!AccountInvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:40'!
visitTransferWithdraw: aTransferWithdraw

	^ 0.! !

!AccountInvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:07'!
visitWithdraw: aWithdraw

	^ 0.! !


!classDefinition: #AccountInvestmentNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountInvestmentNetVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentNetVisitor methodsFor: 'value' stamp: 'AD 5/16/2018 17:50:22'!
value

	^ self sumTransactionsAcceptance! !


!AccountInvestmentNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:57:05'!
visitCertificateOfDeposit: aCertificateOfDeposit

 	^ aCertificateOfDeposit value
	! !

!AccountInvestmentNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:36'!
visitDeposit: aDeposit

	^ 0.! !

!AccountInvestmentNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:04'!
visitTransferDeposit: aTranferDeposit

	^ 0.! !

!AccountInvestmentNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:35'!
visitTransferWithdraw: aTransferWithdraw

	^ 0.! !

!AccountInvestmentNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:04'!
visitWithdraw: aWithdraw

	^ 0.! !


!classDefinition: #AccountSummaryVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountSummaryVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryVisitor methodsFor: 'value' stamp: 'AD 5/16/2018 16:53:40'!
value

	^ account transactionsCollect: [:transaction | transaction accept: self]! !


!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:53:54'!
visitCertificateOfDeposit: aCertificateOfDeposit

	^ 'Plazo fijo por ' , aCertificateOfDeposit value printString , 
		' durante ' , aCertificateOfDeposit numberOfDays printString ,
		' dias a una tna de ' , (aCertificateOfDeposit tna * 100) printString , '%'.! !

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:54:02'!
visitDeposit: aDeposit

	^ 'Deposito por ' , aDeposit value printString.! !

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:54:14'!
visitTransferDeposit: aTranferDeposit

	^ 'Transferencia por ' , aTranferDeposit value printString.! !

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:54:30'!
visitTransferWithdraw: aTransferWithdraw

	^ 'Transferencia por ' , aTransferWithdraw value negated printString.! !

!AccountSummaryVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:54:38'!
visitWithdraw: aWithdraw

	^ 'Extraccion por ' , aWithdraw value printString.! !


!classDefinition: #AccountTransferNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionsVisitor subclass: #AccountTransferNetVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNetVisitor methodsFor: 'value' stamp: 'AD 5/16/2018 17:50:06'!
value
	^ self sumTransactionsAcceptance
! !


!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:54'!
visitCertificateOfDeposit: aCertificateOfDeposit

	^ 0.! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:56:26'!
visitDeposit: aDeposit

	^ 0.! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:53'!
visitTransferDeposit: aTranferDeposit

	^ aTranferDeposit value.! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:55:24'!
visitTransferWithdraw: aTransferWithdraw

	^ aTransferWithdraw value negated.! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:54:51'!
visitWithdraw: aWithdraw

	^ 0.! !


!classDefinition: #PorfolioTreePrinterVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #PorfolioTreePrinterVisitor
	instanceVariableNames: 'accountNames portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PorfolioTreePrinterVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:27:15'!
visitPortfolio: aPortfolio

	self subclassResponsibility.! !

!PorfolioTreePrinterVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:27:24'!
visitReceptiveAccount: aReceptiveAccount

	self subclassResponsibility.! !


!PorfolioTreePrinterVisitor methodsFor: 'value' stamp: 'AD 5/16/2018 16:03:13'!
value

	self subclassResponsibility.! !


!PorfolioTreePrinterVisitor methodsFor: 'initialization' stamp: 'AD 5/16/2018 17:17:53'!
initializeFor: aPortfolio namingAccountsWith: aDictionaryOfAccountNames

	accountNames _ aDictionaryOfAccountNames.
	
	portfolio _ aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PorfolioTreePrinterVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
PorfolioTreePrinterVisitor class
	instanceVariableNames: ''!

!PorfolioTreePrinterVisitor class methodsFor: 'instance creation' stamp: 'AD 5/16/2018 16:48:58'!
for: aPortfolio namingAccountsWith: aDictionaryOfAccountNames
 
	^ self new initializeFor: aPortfolio namingAccountsWith: aDictionaryOfAccountNames! !


!classDefinition: #PorfolioReverseTreePrinterVisitor category: #'PortfolioTreePrinter-Ejercicio'!
PorfolioTreePrinterVisitor subclass: #PorfolioReverseTreePrinterVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PorfolioReverseTreePrinterVisitor methodsFor: 'value' stamp: 'AD 5/16/2018 16:35:00'!
value

	self shouldBeImplemented.! !


!PorfolioReverseTreePrinterVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:35:38'!
visitPortfolio: aPortfolio

	self shouldBeImplemented.! !

!PorfolioReverseTreePrinterVisitor methodsFor: 'visiting' stamp: 'AD 5/16/2018 16:35:56'!
visitReceptiveAccount: aReceptiveAccount

	self shouldBeImplemented.! !


!classDefinition: #PortfolioDepthFirstTreePrinterVisitor category: #'PortfolioTreePrinter-Ejercicio'!
PorfolioTreePrinterVisitor subclass: #PortfolioDepthFirstTreePrinterVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioDepthFirstTreePrinterVisitor methodsFor: 'value' stamp: 'AD 5/17/2018 09:52:37'!
value

	^ self visitPortfolio: portfolio! !


!PortfolioDepthFirstTreePrinterVisitor methodsFor: 'visiting' stamp: 'AD 5/17/2018 12:18:27'!
addPrefix: aPrefix to: aTree


		
		^ aTree collect: [:aTreeElement | aPrefix append: aTreeElement ]
		
		! !

!PortfolioDepthFirstTreePrinterVisitor methodsFor: 'visiting' stamp: 'AD 5/17/2018 12:20:19'!
visitPortfolio: aPortfolio

	|father tree prefix|
	
	prefix := ' '.
	
	tree := OrderedCollection new.
	
	father := accountNames  at: aPortfolio.
	
	tree add: father.
	
	aPortfolio accountsDo: [:anAccount | tree addAll: 
		
		(self addPrefix: prefix to: (anAccount accept: self))
		
		].
	

	^ tree! !

!PortfolioDepthFirstTreePrinterVisitor methodsFor: 'visiting' stamp: 'AD 5/17/2018 11:59:45'!
visitReceptiveAccount: aReceptiveAccount

	|tree|
	
	tree := OrderedCollection new.
	
	tree add: (accountNames at: aReceptiveAccount).

	^ tree.! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'visitor acceptance' stamp: 'AD 5/16/2018 16:26:45'!
accept: aVisitor

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'visitor acceptance' stamp: 'AD 5/16/2018 16:28:27'!
accept: aVisitor

	^ aVisitor visitPortfolio: self! !


!Portfolio methodsFor: 'accounts' stamp: 'AD 5/17/2018 12:01:44'!
accountsDo: aBlock
	^ accounts collect: [ :anAccount |
		aBlock value: anAccount ].! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'AD 5/17/2018 12:02:04'!
accountsCollect: aBlock

	^ accounts do: [ :anAccount | aBlock value: anAccount ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!Portfolio class methodsFor: 'assertions' stamp: 'AD 5/17/2018 08:31:07'!
check: sourceAccount doesNotManageAnyOf: aCollectionOfAccounts
	^ aCollectionOfAccounts do: [ :targetAccount |
		(sourceAccount = targetAccount) not ifTrue: [
			(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ]]].! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'AD 5/17/2018 08:31:07'!
checkNoCircularReferencesIn: aCollectionOfAccounts
	aCollectionOfAccounts do: [ :sourceAccount |
		self
			check: sourceAccount
			doesNotManageAnyOf: aCollectionOfAccounts ].! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'AD 5/10/2018 20:46:29'!
balance
	^ transactions
		inject: 0
		into: [ :balance :transaction |
			transaction affectBalance: balance ].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AD 5/14/2018 18:51:39'!
transactionsCollect: aBlock

	^ transactions collect: [:transaction | aBlock value: transaction].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AD 5/14/2018 21:07:43'!
transactionsDo: aBlock

	^ transactions do: [:transaction | aBlock value: transaction].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'visitor acceptance' stamp: 'AD 5/16/2018 16:26:18'!
accept: aVisitor

	^ aVisitor visitReceptiveAccount: self! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value transferWithdraw tranferDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'AD 5/12/2018 12:11:37'!
initializeFor: aValue with: aTransferWithdraw with: aTransferDeposit 

	value _ aValue .
	transferWithdraw _ aTransferWithdraw .
	tranferDeposit _ aTransferDeposit ! !


!Transfer methodsFor: 'accessing' stamp: 'AD 5/14/2018 17:16:05'!
deposit

	^ tranferDeposit ! !

!Transfer methodsFor: 'accessing' stamp: 'AD 5/12/2018 12:19:23'!
value

	^ value! !

!Transfer methodsFor: 'accessing' stamp: 'AD 5/14/2018 17:16:15'!
withdraw

	^ transferWithdraw ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AD 5/14/2018 18:21:22'!
register: anAmount from: sourceAccount to: destinationAccount

	| deposit withdraw transfer|
	
	transfer _ self new.
	
	withdraw _ TransferWithdraw registerOn: sourceAccount asTransactionOf: transfer.
	
	deposit _ TransferDeposit registerOn: destinationAccount asTransactionOf: transfer.
	
	^ transfer initializeFor: anAmount with: withdraw with: deposit! !
