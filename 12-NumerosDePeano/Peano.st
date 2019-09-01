!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'error handling - private' stamp: 'SAS 8/30/2019 15:13:18'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'error handling - private' stamp: 'SAS 8/30/2019 15:10:55'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos no soportados'! !


!I class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 20:44:36'!
* otroNumero
	^otroNumero! !

!I class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 18:56:58'!
+ otroNumero
	^otroNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:31:52'!
- otroNumero
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:51:56'!
/ otroNumero
	otroNumero = I ifTrue: [
			^ I
		]
		ifFalse: [
			self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
		]! !

!I class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 20:51:59'!
< otroNumero
	^(otroNumero = self) not ! !

!I class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 18:30:48'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:31:23'!
previous
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:34:21'!
restaReversa: otroNumero
	^ otroNumero previous! !


!classDefinition: #II category: #Peano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'error handling - private' stamp: 'SAS 8/30/2019 15:15:09'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor'! !


!II class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 20:45:53'!
* otroNumero
	^self previous * otroNumero + otroNumero! !

!II class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 18:58:44'!
+ otroNumero
	^ self previous + otroNumero next! !

!II class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:36:21'!
- otroNumero
	^ otroNumero restaReversa: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:40:32'!
/ otroNumero
	^self < otroNumero
		ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
		ifFalse: [
			self < (II * otroNumero) 
				ifTrue: I
				ifFalse: [
					I + ((self - otroNumero) / otroNumero)
				]
		]! !

!II class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 20:54:59'!
< otroNumero
	^ otroNumero = I
		ifTrue: false
		ifFalse: [self previous < otroNumero previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:53:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 19:04:11'!
next
	next ifNil: [
		next := self cloneNamed: self name,'I'.
		next previous: self.
	].
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 18:59:46'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 19:04:51'!
previous: numero
	previous := numero.! !

!II class methodsFor: 'as yet unclassified' stamp: 'TACM 8/26/2019 18:43:36'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:34:21'!
restaReversa: otroNumero
	^ (self previous) restaReversa: (otroNumero previous)
! !


!classDefinition: #III category: #Peano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Peano!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'error handling - private' stamp: 'SAS 8/30/2019 15:47:13'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor'! !


!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
* otroNumero
	^self previous * otroNumero + otroNumero! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
+ otroNumero
	^ self previous + otroNumero next! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
- otroNumero
	^ otroNumero restaReversa: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
/ otroNumero
	^self < otroNumero
		ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
		ifFalse: [
			self < (II * otroNumero) 
				ifTrue: I
				ifFalse: [
					I + ((self - otroNumero) / otroNumero)
				]
		]! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
< otroNumero
	^ otroNumero = I
		ifTrue: false
		ifFalse: [self previous < otroNumero previous]! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:53:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
next
	next ifNil: [
		next := self cloneNamed: self name,'I'.
		next previous: self.
	].
	^next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
previous: numero
	previous := numero.! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
restaReversa: otroNumero
	^ (self previous) restaReversa: (otroNumero previous)
! !


!classDefinition: #IIII category: #Peano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Peano!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'error handling - private' stamp: 'SAS 8/30/2019 15:47:13'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor'! !


!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
* otroNumero
	^self previous * otroNumero + otroNumero! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
+ otroNumero
	^ self previous + otroNumero next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
- otroNumero
	^ otroNumero restaReversa: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
/ otroNumero
	^self < otroNumero
		ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
		ifFalse: [
			self < (II * otroNumero) 
				ifTrue: I
				ifFalse: [
					I + ((self - otroNumero) / otroNumero)
				]
		]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
< otroNumero
	^ otroNumero = I
		ifTrue: false
		ifFalse: [self previous < otroNumero previous]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:53:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
next
	next ifNil: [
		next := self cloneNamed: self name,'I'.
		next previous: self.
	].
	^next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
previous: numero
	previous := numero.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:13'!
restaReversa: otroNumero
	^ (self previous) restaReversa: (otroNumero previous)
! !


!classDefinition: #IIIII category: #Peano!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #Peano!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'error handling - private' stamp: 'SAS 8/30/2019 15:47:14'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor'! !


!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
* otroNumero
	^self previous * otroNumero + otroNumero! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
+ otroNumero
	^ self previous + otroNumero next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
- otroNumero
	^ otroNumero restaReversa: self! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
/ otroNumero
	^self < otroNumero
		ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]
		ifFalse: [
			self < (II * otroNumero) 
				ifTrue: I
				ifFalse: [
					I + ((self - otroNumero) / otroNumero)
				]
		]! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
< otroNumero
	^ otroNumero = I
		ifTrue: false
		ifFalse: [self previous < otroNumero previous]! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:53:03'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
next
	next ifNil: [
		next := self cloneNamed: self name,'I'.
		next previous: self.
	].
	^next.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
previous
	^previous! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
previous: numero
	previous := numero.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'SAS 8/30/2019 15:47:14'!
restaReversa: otroNumero
	^ (self previous) restaReversa: (otroNumero previous)
! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!