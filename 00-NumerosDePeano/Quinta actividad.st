!classDefinition: #I category: #'Quinta actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:51:33'!
* unNumeroDePeano
	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:07:18'!
+ unNumeroDePeano
	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:13:16'!
- unNumeroDePeano
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:19:13'!
/ unNumeroDePeano
	self = unNumeroDePeano
	ifTrue:[^self]
	ifFalse:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/23/2018 09:22:27'!
> unNumeroDePeano
	^ false! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/23/2018 09:02:32'!
>= unNumeroDePeano
	^ unNumeroDePeano = I! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:49'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'En la division natural no se puede dividir por un número mayor al dividendo'! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:01:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'En la resta natural no se puede sustraer un número mayor al sustraendo'! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:02:56'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/26/2018 20:48:21'!
porMayorAI: unNumeroDePeano
	^unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 20:55:43'!
previous
	self error:'1 no tiene predecesor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'AD 3/26/2018 21:00:15'!
sustraeA: unNumeroDePeano
	^unNumeroDePeano previous! !


!classDefinition: #II category: #'Quinta actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta actividad'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/26/2018 20:46:28'!
* unNumeroDePeano
	^(unNumeroDePeano porMayorAI: self)! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:09:12'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/26/2018 21:03:51'!
- unNumeroDePeano

	^unNumeroDePeano sustraeA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:15:25'!
/ unNumeroDePeano
	|resto cociente |
	unNumeroDePeano > self 
	ifTrue:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	cociente := I.
	resto := self.
	[resto > unNumeroDePeano] 
	whileTrue:
	[
		resto := resto - unNumeroDePeano.
		cociente := cociente + I.	
	].
	resto = unNumeroDePeano 
	ifFalse:
	[
		cociente:= cociente - I
	].
	^cociente
! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/23/2018 09:24:27'!
> unNumeroDePeano
	^ self previous = unNumeroDePeano | (self previous > unNumeroDePeano)! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:02:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'En la division natural no se puede dividir por un número mayor al dividendo'! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:45:15'!
next
	
	next ifNil:[
		next := self cloneNamed: (self name,'I').
		next previous: self.
		].
	^next
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/26/2018 20:44:39'!
porMayorAI: unNumeroDePeano
	^self + (self * unNumeroDePeano previous)! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:22:03'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:23:54'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/22/2018 21:49:11'!
removeAllNext
	next ifNotNil:
		[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
		]! !

!II class methodsFor: 'as yet unclassified' stamp: 'AD 3/26/2018 21:02:24'!
sustraeA: unNumeroDePeano

	^unNumeroDePeano previous - self previous! !

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: I!

!classDefinition: #III category: #'Quinta actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta actividad'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
* unNumeroDePeano
	^(unNumeroDePeano porMayorAI: self)! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
- unNumeroDePeano

	^unNumeroDePeano sustraeA: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
/ unNumeroDePeano
	|resto cociente |
	unNumeroDePeano > self 
	ifTrue:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	cociente := I.
	resto := self.
	[resto > unNumeroDePeano] 
	whileTrue:
	[
		resto := resto - unNumeroDePeano.
		cociente := cociente + I.	
	].
	resto = unNumeroDePeano 
	ifFalse:
	[
		cociente:= cociente - I
	].
	^cociente
! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
> unNumeroDePeano
	^ self previous = unNumeroDePeano | (self previous > unNumeroDePeano)! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'En la division natural no se puede dividir por un número mayor al dividendo'! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
next
	
	next ifNil:[
		next := self cloneNamed: (self name,'I').
		next previous: self.
		].
	^next
	
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
porMayorAI: unNumeroDePeano
	^self + (self * unNumeroDePeano previous)! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
removeAllNext
	next ifNotNil:
		[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
		]! !

!III class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
sustraeA: unNumeroDePeano

	^unNumeroDePeano previous - self previous! !

III instVarNamed: 'next' put: IIII!
III instVarNamed: 'previous' put: II!

!classDefinition: #IIII category: #'Quinta actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta actividad'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
* unNumeroDePeano
	^(unNumeroDePeano porMayorAI: self)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
- unNumeroDePeano

	^unNumeroDePeano sustraeA: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
/ unNumeroDePeano
	|resto cociente |
	unNumeroDePeano > self 
	ifTrue:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	cociente := I.
	resto := self.
	[resto > unNumeroDePeano] 
	whileTrue:
	[
		resto := resto - unNumeroDePeano.
		cociente := cociente + I.	
	].
	resto = unNumeroDePeano 
	ifFalse:
	[
		cociente:= cociente - I
	].
	^cociente
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
> unNumeroDePeano
	^ self previous = unNumeroDePeano | (self previous > unNumeroDePeano)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'En la division natural no se puede dividir por un número mayor al dividendo'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
next
	
	next ifNil:[
		next := self cloneNamed: (self name,'I').
		next previous: self.
		].
	^next
	
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
porMayorAI: unNumeroDePeano
	^self + (self * unNumeroDePeano previous)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
previous: unNumeroDePeano
	previous := unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
removeAllNext
	next ifNotNil:
		[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
		]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'AD 3/27/2018 10:16:01'!
sustraeA: unNumeroDePeano

	^unNumeroDePeano previous - self previous! !

IIII instVarNamed: 'next' put: nil!
IIII instVarNamed: 'previous' put: III!