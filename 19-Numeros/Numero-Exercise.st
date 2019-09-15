!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
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

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:

	a/b + c/d = (a.d + c.b) / (b.d)

	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

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

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

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

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly

	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |

	sixFifth := (Entero with: 6) / (Entero with: 5).

	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |

	threeHalfs := (Entero with: 3) / (Entero with: 2).

	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |

	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three.
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.

	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


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

!Numero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:14:33'!
- aSubtrahend

	^ self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:07:56'!
/ aDivisor

	^ self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:13:59'!
addEntero: anAdder
	^ self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:14:05'!
addFraccion: anAdder
	^ self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:13:22'!
divideEntero: anEnteroDividend
	^ self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:13:11'!
divideFraccion: aFraccionDividend
	^ self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:26:58'!
multiplyWithEntero: aMultiplier
	^ self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:27:03'!
multiplyWithFraccion: aMultiplier
	^ self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated

	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:33:19'!
subtractEnteroFrom: anEnteroMinuend
	^ self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:33:32'!
subtractFraccionFrom: aFraccionMinuend
	^ self subclassResponsibility .! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:58:13'!
invalidNumberTypeErrorDescription
	^ 'Tipo de número inválido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:35:21'!
* aMultiplier
	^ aMultiplier  multiplyWithEntero: self.

	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:07:00'!
+ anAdder

	^ anAdder addEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:17:11'!
- aSubtrahend
	^ aSubtrahend subtractEnteroFrom: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:08:24'!
/ aDivisor
	^ aDivisor divideEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor

	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:06:24'!
addEntero: anAdder
	^ self class with: value + anAdder integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:26:35'!
addFraccion: anAdder
	| newNumerator newDenominator |

	newNumerator := self * anAdder denominator + anAdder numerator.
	newDenominator := anAdder denominator.

	^ newNumerator / newDenominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:09:30'!
divideEntero: anEnteroDividend
	^ Fraccion  with: anEnteroDividend over: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:10:59'!
divideFraccion: aFraccionDividend
	^ Fraccion  with: aFraccionDividend numerator over: aFraccionDividend denominator  * self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 18:12:31'!
fibonacci
	^ self subclassResponsibility .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero

	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:18:55'!
multiplyWithEntero: aMultiplier

	^ self class with: value * aMultiplier integerValue.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:24:19'!
multiplyWithFraccion: aMultiplier

	^ Fraccion with: aMultiplier numerator * self over: aMultiplier denominator.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:20:50'!
subtractEnteroFrom: anEnteroMinuend
	^ self class with: anEnteroMinuend  integerValue - value.! !

!Entero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:32:13'!
subtractFraccionFrom: aFraccionMinuend
	^ Fraccion with: aFraccionMinuend numerator - (self * aFraccionMinuend  denominator ) over: aFraccionMinuend  denominator .! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue

	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"

	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 's.d 9/15/2019 18:23:39'!
with: aValue

	| aSubclass|

	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].

	aSubclass  := Entero subclasses detect: [ :subclass | subclass doesIntegerMatch: aValue ].

	^ aSubclass new initalizeWith:  aValue .

! !


!Entero class methodsFor: 'testing' stamp: 's.d 9/15/2019 18:31:53'!
doesIntegerMatch: anInteger
	^ self subclassResponsibility .! !


!Entero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'testing' stamp: 's.d 9/15/2019 17:49:34'!
isNegative
	^ false! !

!Cero methodsFor: 'testing' stamp: 's.d 9/15/2019 17:48:25'!
isOne
	^ false! !

!Cero methodsFor: 'testing' stamp: 's.d 9/15/2019 17:47:21'!
isZero
	^ true! !


!Cero methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 18:41:45'!
fibonacci
	^ Uno initializedInstance .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'testing' stamp: 's.d 9/15/2019 18:17:44'!
doesIntegerMatch: anInteger
	^ anInteger  = 0.! !


!classDefinition: #EnteroMayorAUno category: #'Numero-Exercise'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorAUno methodsFor: 'testing' stamp: 's.d 9/15/2019 17:49:42'!
isNegative
	^ false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 's.d 9/15/2019 17:49:03'!
isOne
	^ false! !

!EnteroMayorAUno methodsFor: 'testing' stamp: 's.d 9/15/2019 17:47:51'!
isZero
	^ false! !


!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 18:44:18'!
fibonacci

	| one two |

	one := Uno initializedInstance.
	two := Entero with: 2.

	^ (self - one) fibonacci + (self - two) fibonacci
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: #'Numero-Exercise'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'testing' stamp: 's.d 9/15/2019 18:18:31'!
doesIntegerMatch: anInteger
	^ anInteger  > 1.! !


!classDefinition: #EnteroNegativo category: #'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'testing' stamp: 's.d 9/15/2019 17:49:49'!
isNegative
	^ true! !

!EnteroNegativo methodsFor: 'testing' stamp: 's.d 9/15/2019 17:49:09'!
isOne
	^ false! !

!EnteroNegativo methodsFor: 'testing' stamp: 's.d 9/15/2019 17:48:05'!
isZero
	^ false! !


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 18:09:12'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: #'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'testing' stamp: 's.d 9/15/2019 18:18:53'!
doesIntegerMatch: anInteger
	^ anInteger  < 0.! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'testing' stamp: 's.d 9/15/2019 17:49:56'!
isNegative
	^ false! !

!Uno methodsFor: 'testing' stamp: 's.d 9/15/2019 17:49:19'!
isOne
	^ true! !

!Uno methodsFor: 'testing' stamp: 's.d 9/15/2019 17:48:13'!
isZero
	^ false! !


!Uno methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 18:11:19'!
fibonacci
	^ self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'testing' stamp: 's.d 9/15/2019 18:19:19'!
doesIntegerMatch: anInteger
	^ anInteger  = 1.! !


!Uno class methodsFor: 'instance creation' stamp: 's.d 9/15/2019 18:41:09'!
initializedInstance
	^ Entero  with: 1.! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:24:45'!
* aMultiplier

	^ aMultiplier multiplyWithFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:12:56'!
+ anAdder

	^ anAdder addFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:17:34'!
- aSubtrahend
	^ aSubtrahend subtractFraccionFrom: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:08:53'!
/ aDivisor
	^ aDivisor divideFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:26:04'!
addEntero: anAdder
	^ anAdder addFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:09:55'!
addFraccion: anAdder

	| newNumerator newDenominator |

	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.

	^ newNumerator / newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:38:03'!
divideEntero: anEnteroDividend
	^ self class with: anEnteroDividend  * self  denominator  over: self numerator .! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:40:12'!
divideFraccion: aFraccionDividend
	|newNumerator newDenominator|

	newNumerator  := aFraccionDividend  numerator * self  denominator.
	newDenominator  := aFraccionDividend denominator * self numerator.

	^ self class with:  newNumerator  over: newDenominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TACM 9/12/2019 21:22:23'!
multiplyWithEntero: aMultiplier
	^ aMultiplier multiplyWithFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:41:41'!
multiplyWithFraccion: aMultiplier
	|newNumerator newDenominator|

	newNumerator := numerator * aMultiplier numerator .
	newDenominator := denominator * aMultiplier denominator.

	^ self class with: newNumerator over: newDenominator .
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:24:43'!
subtractEnteroFrom: anEnteroMinuend
	^ self class with: anEnteroMinuend  * denominator  - numerator over: denominator.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 's.d 9/15/2019 17:26:15'!
subtractFraccionFrom: aFraccionMinuend
	| newNumerator newDenominator |

	newNumerator :=  (denominator * aFraccionMinuend numerator) -  (numerator * aFraccionMinuend denominator).
	newDenominator := denominator * aFraccionMinuend denominator.

	^newNumerator / newDenominator ! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].

	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 's.d 9/15/2019 18:33:03'!
isNegative

	^numerator isNegative .! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne

	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero

	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |

	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].

	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].

	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor.
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.

	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
