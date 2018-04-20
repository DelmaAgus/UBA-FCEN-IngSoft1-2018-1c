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

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !


!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 21:44:00'!
addCero

	^ self! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:24:21'!
addEntero: unSumandoEntero
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:25:16'!
addFraccion: unSumandoFraccional
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 21:41:55'!
addUno

	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 21:04:44'!
divideCero

	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:27:46'!
divideEntero: unDIvidendoEntero
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:28:21'!
divideFraccion: unDividendoFraccional
	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:32:35'!
multiplyEntero: anEnteroToMultiply

	self subclassResponsibility.! !

!Numero methodsFor: 'double dispatch' stamp: 'AD 4/19/2018 20:32:11'!
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


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:58:46'!
* aMultiplier

	^ self! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:01:04'!
+ anAdder

	^ anAdder! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:00:17'!
/ aDivisor

	^ aDivisor divideCero.! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:58:06'!
addEntero: anEnteroToAdd

	^ anEnteroToAdd ! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:57:17'!
addFraccion: aFraccionToAdd

	^ aFraccionToAdd ! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:03:06'!
divideCero

	self class canNotDivideByZeroErrorDescription

	! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:56:02'!
divideEntero: anEnteroToDivide

	self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:56:24'!
divideFraccion: aFraccionToDivide

	self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:04:14'!
isOne

	^ false! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:04:03'!
isZero

	^ true! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:02:04'!
multiplyEntero: anEnteroToMultiply

	^ self! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:02:18'!
multiplyFraccion: aFraccionToMultiply

	^ self! !


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


!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:26:06'!
* aMultiplier
	^ aMultiplier multiplyEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:24:21'!
+ anAdder
	^ anAdder addEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:27:46'!
/ aDivisor
	^ aDivisor divideEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:24:21'!
addEntero: unSumandoEntero
	^ self class with: value + unSumandoEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:25:16'!
addFraccion: unSumandoFraccional
	^ self * unSumandoFraccional denominator + unSumandoFraccional numerator / unSumandoFraccional denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:05:27'!
divideCero

	^ Cero new.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:46:57'!
divideEntero: unDividendoEntero

	^ Fraccion
		with: unDividendoEntero
		over: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:28:21'!
divideFraccion: unDividendoFraccional
	^ unDividendoFraccional numerator / (self * unDividendoFraccional denominator).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:48:33'!
greatestCommonDivisorWith: anEntero 
	
	^ self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:32:54'!
multiplyEntero: anEnteroToMultiply

	^ self class with: value * anEnteroToMultiply integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:31:54'!
multiplyFraccion: aFraccionToMultiply

	^ self * aFraccionToMultiply numerator / aFraccionToMultiply denominator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'AD 4/19/2018 21:45:45'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue isZero ifTrue: [^ Cero new].
	aValue isOne ifTrue: [^ Uno new].
	
	^ EnteroDistintoDeCeroYUno new initalizeWith: aValue! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:58:46'!
* aMultiplier

	^ self! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:01:04'!
+ anAdder

	^ anAdder! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:00:17'!
/ aDivisor

	^ aDivisor divideCero.! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:58:06'!
addEntero: anEnteroToAdd

	^ anEnteroToAdd ! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:57:17'!
addFraccion: aFraccionToAdd

	^ aFraccionToAdd ! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:03:06'!
divideCero

	self class canNotDivideByZeroErrorDescription

	! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:56:02'!
divideEntero: anEnteroToDivide

	self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 20:56:24'!
divideFraccion: aFraccionToDivide

	self class canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:04:14'!
isOne

	^ false! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:04:03'!
isZero

	^ true! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:02:04'!
multiplyEntero: anEnteroToMultiply

	^ self! !

!Cero methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:02:18'!
multiplyFraccion: aFraccionToMultiply

	^ self! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:33:36'!
* aMultiplier

	^ aMultiplier! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:34:03'!
+ anAdder

	anAdder addUno.! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:34:32'!
/ aDivisor

	^ aDivisor divideUno.! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:37:13'!
addEntero: anEnteroToAdd

	^ anEnteroToAdd addUno.! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:38:03'!
addFraccion: aFraccionToAdd

	^ aFraccionToAdd addUno.! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:43:11'!
addUno

	^ Entero with: 2.! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:40:08'!
divideEntero: anEnteroToDivide

	^ anEnteroToDivide ! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:40:21'!
divideFraccion: aFraccionToDivide

	^ aFraccionToDivide ! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:40:30'!
isOne

	^ true! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:40:36'!
isZero

	^ false! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:40:52'!
multiplyEntero: anEnteroToMultiply

	^ anEnteroToMultiply ! !

!Uno methodsFor: 'as yet unclassified' stamp: 'AD 4/19/2018 21:41:11'!
multiplyFraccion: aFraccionToMultiply

	^ aFraccionToMultiply ! !


!classDefinition: #EnteroDistintoDeCeroYUno category: #'Numero-Exercise'!
Entero subclass: #EnteroDistintoDeCeroYUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroDistintoDeCeroYUno methodsFor: 'value' stamp: 'AD 4/19/2018 21:46:49'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!EnteroDistintoDeCeroYUno methodsFor: 'testing' stamp: 'AD 4/19/2018 21:46:49'!
isOne
	
	^value = 1! !

!EnteroDistintoDeCeroYUno methodsFor: 'testing' stamp: 'AD 4/19/2018 21:46:49'!
isZero
	
	^value = 0! !


!EnteroDistintoDeCeroYUno methodsFor: 'comparing' stamp: 'AD 4/19/2018 21:46:49'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!EnteroDistintoDeCeroYUno methodsFor: 'comparing' stamp: 'AD 4/19/2018 21:46:49'!
hash

	^value hash! !


!EnteroDistintoDeCeroYUno methodsFor: 'initialization' stamp: 'AD 4/19/2018 21:46:49'!
initalizeWith: aValue 
	
	value := aValue! !


!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
* aMultiplier
	^ aMultiplier multiplyEntero: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
+ anAdder
	^ anAdder addEntero: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
/ aDivisor
	^ aDivisor divideEntero: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
addEntero: unSumandoEntero
	^ self class with: value + unSumandoEntero integerValue.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
addFraccion: unSumandoFraccional
	^ self * unSumandoFraccional denominator + unSumandoFraccional numerator / unSumandoFraccional denominator.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
divideCero

	^ Cero new.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
divideEntero: unDividendoEntero

	^ Fraccion
		with: unDividendoEntero
		over: self.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
divideFraccion: unDividendoFraccional
	^ unDividendoFraccional numerator / (self * unDividendoFraccional denominator).! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
multiplyEntero: anEnteroToMultiply

	^ self class with: value * anEnteroToMultiply integerValue.! !

!EnteroDistintoDeCeroYUno methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:46:49'!
multiplyFraccion: aFraccionToMultiply

	^ self * aFraccionToMultiply numerator / aFraccionToMultiply denominator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroDistintoDeCeroYUno class' category: #'Numero-Exercise'!
EnteroDistintoDeCeroYUno class
	instanceVariableNames: ''!

!EnteroDistintoDeCeroYUno class methodsFor: 'instance creation' stamp: 'AD 4/19/2018 21:46:49'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue isZero ifTrue: [^ Cero new].
	aValue isOne ifTrue: [^ Uno new].
	
	^ EnteroDistintoDeCeroYUno new initalizeWith: aValue! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
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

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:24:21'!
addEntero: unSumandoEntero
	| newNumerator newDenominator |
	newNumerator _ denominator * unSumandoEntero + numerator.
	newDenominator _ denominator.
	^ newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:25:16'!
addFraccion: unSumandoFraccional
	| newNumerator newDenominator |
	newNumerator _ numerator * unSumandoFraccional denominator + (denominator * unSumandoFraccional numerator).
	newDenominator _ denominator * unSumandoFraccional denominator.
	^ newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 21:06:01'!
divideCero

	^ Cero new.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:27:46'!
divideEntero: unDIvidendoEntero
	^ denominator * unDIvidendoEntero / numerator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:28:21'!
divideFraccion: unDividendoFraccional
	^ denominator * unDividendoFraccional numerator / (numerator * unDividendoFraccional denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:33:11'!
multiplyEntero: anEnteroToMultiply

	^ self numerator * anEnteroToMultiply / self denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AD 4/19/2018 20:26:32'!
multiplyFraccion: unMultiplicadorFraccional
	^ numerator * unMultiplicadorFraccional numerator / (denominator * unMultiplicadorFraccional denominator).! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'AD 4/19/2018 20:46:10'!
with: aDividend over: aDivisor

"	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
"	

	^ aDividend / aDivisor.! !
