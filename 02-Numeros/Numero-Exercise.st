!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'AD 4/19/2018 21:22:55'!
test08FraccionAddsWithFraccionCorrectly
	"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |
	sevenTenths _ (Entero with: 7) / (Entero with: 10).
	self
		assert: oneFifth + oneHalf
		equals: sevenTenths.! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'AD 4/19/2018 21:22:55'!
test11EnteroAddsFraccionCorrectly
	"
	Ahora empieza la diversion!!
"
	self
		assert: one + oneFifth
		equals: (Entero with: 6) / (Entero with: 5).! !

!NumeroTest methodsFor: 'tests' stamp: 'AD 4/19/2018 21:22:55'!
test12FraccionAddsEnteroCorrectly
	self
		assert: oneFifth + one
		equals: (Entero with: 6) / (Entero with: 5).! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !


!NumeroTest methodsFor: 'setup' stamp: 'AD 4/19/2018 21:22:55'!
setUp
	zero _ Entero with: 0.
	one _ Entero with: 1.
	two _ Entero with: 2.
	four _ Entero with: 4.
	five _ Entero with: 5.
	oneHalf _ one / two.
	oneFifth _ one / five.
	twoFifth _ two / five.
	twoTwentyfifth _ two / (Entero with: 25).
	fiveHalfs _ five / two.! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:21:58'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !


!Numero methodsFor: 'testing' stamp: 'AD 4/20/2018 08:59:02'!
ifCero: aBlockToValueIfSelfIsCero

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'AD 4/20/2018 08:59:25'!
ifUno: aBlockToValueIfSelfIsUno

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:00:03'!
addEnteroDistintoDeCeroYUno: anEnteroDistintoDeCeroYUnoToAdd

	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:25:16'!
addFraccion: unSumandoFraccional
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:18:54'!
addUno: anUnoToAdd
	^ super class with: self integerValue + 1! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:31:57'!
divideCero: aCeroToDivide

	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:19:17'!
divideEnteroDistintoDeCeroYUno: unDIvidendoEntero
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:28:21'!
divideFraccion: unDividendoFraccional
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:32:24'!
divideUno: anUnoToDivide

	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:21:18'!
multiplyEnteroDistintoDeCeroYUno: anEnteroToMultiply
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:14:09'!
multiplyFraccion: aFraccionToMultiply
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !



!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:17:46'!
greatestCommonDivisorWith: anEntero 	
	^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'AD 4/20/2018 09:52:08'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [^ Cero new].
	aValue = 1  ifTrue: [^ Uno new].
	
	^ EnteroDistintoDeCeroYUno new initalizeWith: aValue! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:58:46'!
* aMultiplier

	^ self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:01:04'!
+ anAdder

	^ anAdder! !

!Cero methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:34:24'!
/ aDivisor

	^ aDivisor divideCero: self.! !

!Cero methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:23:37'!
greatestCommonDivisorWith: anEntero 
	
	^ anEntero! !


!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:28:42'!
addEnteroDistintoDeCeroYUno: anEnteroToAdd

	^ anEnteroToAdd.! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:28:38'!
addFraccion: aFraccionToAdd

	^ aFraccionToAdd ! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:28:31'!
addUno: anUnoToAdd

	^ anUnoToAdd ! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:24:43'!
divideCero: aCeroToDivide

	self error: self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:24:50'!
divideEnteroDistintoDeCeroYUno: anEnteroToDivide

	self error: self class canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:22:13'!
divideFraccion: aFraccionToDivide

	self error: self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:21:12'!
divideUno: anUnoToDivide

	self error: self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:29:37'!
multiplyEnteroDistintoDeCeroYUno: anEnteroToMultiply

	^ self.! !

!Cero methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:29:46'!
multiplyFraccion: aFraccionToMultiply

	^ self! !


!Cero methodsFor: 'testing' stamp: 'AD 4/20/2018 09:05:49'!
ifCero: aBlockToValueIfSelfIsCero
	
	^ aBlockToValueIfSelfIsCero value! !

!Cero methodsFor: 'testing' stamp: 'AD 4/20/2018 09:06:01'!
ifUno: aBlockToValueIfSelfIsUno! !

!Cero methodsFor: 'testing' stamp: 'AD 4/19/2018 21:04:14'!
isOne

	^ false! !

!Cero methodsFor: 'testing' stamp: 'AD 4/19/2018 21:04:03'!
isZero

	^ true! !


!Cero methodsFor: 'initialization' stamp: 'AD 4/20/2018 09:23:42'!
initialize

	value _ 0! !


!classDefinition: #EnteroDistintoDeCeroYUno category: #'Numero-Exercise'!
Entero subclass: #EnteroDistintoDeCeroYUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroDistintoDeCeroYUno methodsFor: 'testing' stamp: 'AD 4/20/2018 09:06:36'!
ifCero: aBlockToValueIfSelfIsCero
	
	! !

!EnteroDistintoDeCeroYUno methodsFor: 'testing' stamp: 'AD 4/20/2018 09:06:46'!
ifUno: aBlockToValueIfSelfIsUno
	
	! !

!EnteroDistintoDeCeroYUno methodsFor: 'testing' stamp: 'AD 4/19/2018 21:46:49'!
isOne
	
	^value = 1! !

!EnteroDistintoDeCeroYUno methodsFor: 'testing' stamp: 'AD 4/19/2018 21:46:49'!
isZero
	
	^value = 0! !



!EnteroDistintoDeCeroYUno methodsFor: 'initialization' stamp: 'AD 4/19/2018 21:46:49'!
initalizeWith: aValue 
	
	value := aValue! !


!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:21:18'!
* aMultiplier
	^ aMultiplier multiplyEnteroDistintoDeCeroYUno: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:11:01'!
+ anAdder
	^ anAdder addEnteroDistintoDeCeroYUno: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:19:17'!
/ aDivisor
	^ aDivisor divideEnteroDistintoDeCeroYUno: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:18:17'!
addEnteroDistintoDeCeroYUno: unSumandoEntero

	^ self class with: value + unSumandoEntero integerValue.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
addFraccion: unSumandoFraccional
	^ self * unSumandoFraccional denominator + unSumandoFraccional numerator / unSumandoFraccional denominator.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:53:45'!
divideCero: aCeroToDivide
	^ aCeroToDivide.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:41:04'!
divideEnteroDistintoDeCeroYUno: unDividendoEntero

	^ Fraccion with: unDividendoEntero over: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
divideFraccion: unDividendoFraccional
	^ unDividendoFraccional numerator / (self * unDividendoFraccional denominator).! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:42:27'!
divideUno: anUnoToDivide
	^ Fraccion with: anUnoToDivide over: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:42:42'!
greatestCommonDivisorWith: anEntero 

	^self class with: (value gcd: anEntero integerValue)! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:42:46'!
multiplyEnteroDistintoDeCeroYUno: anEnteroToMultiply

	^ self class with: value * anEnteroToMultiply integerValue.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:42:54'!
multiplyFraccion: aFraccionToMultiply

	^ self * aFraccionToMultiply numerator / aFraccionToMultiply denominator.! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:33:36'!
* aMultiplier

	^ aMultiplier! !

!Uno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:00:52'!
+ anAdder
	^ anAdder addUno: self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 09:33:54'!
/ aDivisor

	^ aDivisor divideUno: self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'AD 4/20/2018 10:14:43'!
greatestCommonDivisorWith: anEntero 
	
	^ self! !


!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:59:27'!
addEnteroDistintoDeCeroYUno: anEnteroToAdd

	^ anEnteroToAdd addUno: self.! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:59:36'!
addFraccion: aFraccionToAdd

	^ aFraccionToAdd addUno: self.! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:58:09'!
addUno: anUnoToAdd

	^ Entero with: 2.! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:31:40'!
divideCero: aCeroToDivide

	^ aCeroToDivide.! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:26:59'!
divideEnteroDistintoDeCeroYUno: anEnteroToDivide

	^ anEnteroToDivide.! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:26:54'!
divideFraccion: aFraccionToDivide

	^ aFraccionToDivide ! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:26:44'!
divideUno: anUnoToDivide

	^ anUnoToDivide.! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:21:18'!
multiplyEnteroDistintoDeCeroYUno: anEnteroToMultiply
	^ anEnteroToMultiply.! !

!Uno methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 21:41:11'!
multiplyFraccion: aFraccionToMultiply

	^ aFraccionToMultiply ! !


!Uno methodsFor: 'testing' stamp: 'AD 4/20/2018 09:05:26'!
ifCero: aBlockToValueIfSelfIsCero
	! !

!Uno methodsFor: 'testing' stamp: 'AD 4/20/2018 09:04:54'!
ifUno: aBlockToValueIfSelfIsUno
	^ aBlockToValueIfSelfIsUno value! !

!Uno methodsFor: 'testing' stamp: 'AD 4/19/2018 21:40:30'!
isOne

	^ true! !

!Uno methodsFor: 'testing' stamp: 'AD 4/20/2018 09:27:21'!
isZero

	^ false! !


!Uno methodsFor: 'initialization' stamp: 'AD 4/20/2018 09:24:14'!
initialize

	value _ 1! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'AD 4/20/2018 09:07:51'!
ifCero: aBlockToValueIfSelfIsCero! !

!Fraccion methodsFor: 'testing' stamp: 'AD 4/20/2018 09:08:08'!
ifUno: aBlockToValueIfSelfIsUno! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'initialization' stamp: 'AD 4/20/2018 10:31:13'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator ifCero: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator ifUno: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:26:32'!
* aMultiplier
	^ aMultiplier multiplyFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:25:16'!
+ anAdder
	^ anAdder addFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:28:21'!
/ aDivisor
	^ aDivisor divideFraccion: self.! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:45:53'!
addEnteroDistintoDeCeroYUno: unSumandoEntero

	| newNumerator newDenominator |
	newNumerator _ denominator * unSumandoEntero + numerator.
	newDenominator _ denominator.
	
	^ newNumerator / newDenominator.! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:25:16'!
addFraccion: unSumandoFraccional
	| newNumerator newDenominator |
	newNumerator _ numerator * unSumandoFraccional denominator + (denominator * unSumandoFraccional numerator).
	newDenominator _ denominator * unSumandoFraccional denominator.
	^ newNumerator / newDenominator.! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:30:32'!
addUno: anUnoToAdd
	^ self numerator + self denominator / self denominator.! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:38:54'!
divideCero: aCeroToDivide

	^ aCeroToDivide.! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:19:17'!
divideEnteroDistintoDeCeroYUno: unDIvidendoEntero
	^ denominator * unDIvidendoEntero / numerator.! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:28:21'!
divideFraccion: unDividendoFraccional
	^ denominator * unDividendoFraccional numerator / (numerator * unDividendoFraccional denominator).! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 10:30:15'!
divideUno: anUnoToDivide

	^ self denominator / self numerator.! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/20/2018 09:22:14'!
multiplyEnteroDistintoDeCeroYUno: anEnteroToMultiply

	^ self numerator * anEnteroToMultiply / self denominator.! !

!Fraccion methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:26:32'!
multiplyFraccion: unMultiplicadorFraccional
	^ numerator * unMultiplicadorFraccional numerator / (denominator * unMultiplicadorFraccional denominator).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'AD 4/20/2018 09:03:56'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor ifCero: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend ifCero: [ ^aDividend ].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator ifUno: [ ^numerator ].
	
	^self new initializeWith: numerator over: denominator! !
