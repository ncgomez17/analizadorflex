# analizadorflex
Analizador léxico flex
Autor:Nicolás Cid Gómez
Practica 2.- Analizador L ́exico de Simple
TALF 19-20
27 de marzo de 2020
Para realizar el analisis se tiene que ejecutart el programa pasandole el path del fichero que queremos analizar.
Ejemplo: Para un programa como el siguiente: subprograma Radio_Circunferencia
comienzo
## Constante
PI: constante real := .3141592E1;
## Variables
area, radio: real;
otra_cosa : real := %x1F.34^-Faa;
escribir_consola("%nRadio de la #{circunferencia#}% %o151%O144%X69%O157%x74%O141: ");
leer_consola(radio); #{ Entrada de dato #}
## Calculo del area area := PI * radio ^ 2;
   #{ El resultado del area se saca por la "consola":
     se trata de un numero real #}
escribir_consola("%nArea de la %
%"circunferencia%": #f", area); escribir_consola("%n");
   DeVoLVeR area;
fin subprograma
la salida debe parecerse a:
linea 1, palabra reservada: subprograma linea 1, identificador: Radio_Circunferencia linea 3, identificador: comienzo
linea 5, identificador: PI
linea 5, delimitador: :
linea 5, palabra reservada: constante
linea 5, palabra reservada: real
linea 5, operador: :=
linea 5, ctc real: .3141592^1
linea 5, delimitador: ;
linea 8, identificador: area
linea 8, delimitador: ,
linea 8, identificador: radio
linea 8, delimitador: :
linea 8, palabra reservada: real
linea 8, delimitador: ;
linea 9, identificador: otra_cosa
linea 9, delimitador: :
linea 9, palabra reservada: real
2

linea 9, operador: :=
linea 9, ctc real: %x1F.34^-Faa
linea 9, delimitador: ;
linea 11, identificador: escribir_consola
linea 11, delimitador: (
linea 11, cadena: "%nRadio de la #{circunferencia#}%
                    %o151%O144%X69%O157%x74%O141: "
linea 12, delimitador: )
linea 12, delimitador: ;
linea 13, identificador: leer_consola linea 13, delimitador: (
linea 13, identificador: radio
linea 13, delimitador: )
linea 13, delimitador: ;
linea 16, identificador: area
linea 16, operador: :=
linea 16, identificador: PI
linea 16, operador: *
linea 16, identificador: radio
linea 16, operador: ^
linea 16, ctc entera: 2
linea 16, delimitador: ;
linea 20, identificador: escribir_consola linea 20, delimitador: (
linea 20, cadena: "%nArea de la %
                     %"circunferencia%": #f"
linea 21, delimitador: ,
linea 21, identificador: area
linea 21, delimitador: )
linea 21, delimitador: ;
linea 21, identificador:
linea 21, delimitador: (
linea 21, cadena: "%n"
linea 21, delimitador: )
linea 21, delimitador: ;
linea 23, palabra reservada: DeVoLVeR
linea 23, identificador: area
linea 23, delimitador: ;
linea 24, palabra reservada: fin
linea 24, palabra reservada: subprograma
2. Especificaci ́on l ́exica de Simple
Para que podais escribir el analizador l ́exico, vamos a especificar a continuaci ́on cada uno de los constituyentes l ́exicos de los programas Simple.
2.1. Palabras reservadas
  abstracto booleano bucle caracter casos clase como constante constructor corto cuando de
  descendente destructor devolver diccionario en entero entonces enumeracion es especifico
  excepcion exportar falso fin final finalmente generico importar largo lanza libreria lista
  mientras objeto otro para principio privado programa protegido prueba publico rango real
  referencia registro repetir salir si signo siguiente sino subprograma tabla tipo ultima
  valor verdadero
escribir_consola
3

Las palabras reservadas pueden escribirse totalmente en mayu ́sculas o minu ́sculas, o en cualquier combinaci ́on de ambas.
2.2. Identificadores
Un identificador es una secuencia de caracteres, que pueden pertenecer a las siguientes categor ́ıas:
letras mayu ́sculas o minu ́sculas pertenecientes al juego de caracteres ASCII. el subrayado: ’ ’
d ́ıgitos entre ’0’ y ’9’.
Importante: El primer car ́acter del identificador s ́olo puede ser una letra o ’ ’. Ejemplo:
identificadores --------------- uno _25diciembre tabla_123
TABLA Array_Modificado
2.3. Constantes
NO son identificadores ----------------------  ́uno
25diciembre
Vamos a considerar cuatro tipos de constantes: nu ́meros enteros, nu ́meros reales, caracteres y cadenas.
Constantes enteras: vamos a considerar tres notaciones: decimal, octal y hexadecimal. En los tres casos las constantes est ́an formadas por uno o m ́as caracteres en los siguientes rangos:
En notaci ́on decimal, los d ́ıgitos del ’0’ al ’9’.
En notaci ́on octal, d ́ıgitos de ’0’ a ’7’. Adem ́as, la secuencia de d ́ıgitos estar ́a precedida por un ’ %o’ o ’ %O’.
En hexadecimal, los d ́ıgitos de ’0’ a ’9’ y las letras de la ’a’ a la ’f’, tanto en mayu ́cula como en minu ́scula, con la secuencia ’ %x’ (o ’ %X’) al principio de la constante entera.
Ejemplos:
    %x23    ## 35 en hexadecimal
    %057    ## 47 en octal
    %XFfF   ## 4095 en hexadecimal
    %023    ## 18 en octal
25 38
Constantes reales: consideraremos dos tipos de nu ́meros decimales:
Los formados por una parte entera (que es opcional), el punto decimal ’.’, y una parte fraccionaria. Los d ́ıgitos de la parte entera y fraccionaria deben tener la misma codificaci ́on: decimal, octal o hexadecimal. En los dos u ́ltimos casos, el nu ́mero estar ́a precedido de la secuencia ’ %o’ y ’ %x’, respectivamente (donde ’o’ y ’x’ pueden estar en minu ́scula o mayu ́scula).
Ejemplos:
.45 38.25 %XF.0a %o.523
4

Los formados por una mantisa y un exponente. La mantisa puede ser un nu ́mero entero o fraccionario en codificaci ́on decimal, octal o hexadecimal. El exponente est ́a formado por el car ́acter ’^’ seguido por uno o m ́as d ́ıgitos decimales con la misma codificaci ́on que la mantisa (octal, decimal o hexadecimal), que pueden, opcionalmente, estar precedidos de un signo (’+’ o ’-’).
Ejemplos:
%O27.5^-7 45^10 .72^+1 %xF8^-a4 %O.254^2
Caracteres: est ́an formadas por dos comillas simples (’), que ir ́an antes y despu ́es de:
un u ́nico car ́acter, excepto el salto de l ́ınea, la comilla simple o la secuencia de escape ’ %’. los siguientes caracteres escapados:
%’ %" %% %n %r %t
el nu ́mero del car ́acter expresado en decimal, entre 0 y 255, precedido de ’ %’. Un nu ́mero de 3 d ́ıgitos mayor que
255 no es un car ́acter v ́alido.
el nu ́mero del car ́acter expresado en octal, formado por ’ %o’ (o ’ %O’), seguido de entre uno y tres d ́ıgitos octales. El mayor valor de un caracter en octal es ’ %o377’ (=255). Cualquier octal de tres d ́ıgitos mayor que ’ %o377’ no es un car ́acter v ́alido.
el nu ́mero del car ́acter expresado en hexadecimal, formado por ’ %x’ (o ’ %X’) y uno o dos d ́ıgitos hexadecimales. Ejemplos:
’%o171’ ’a’ ’%255’ ’9’ ’%n’ ’%xD’ ’%X1f’ ’%’’
Cadenas: est ́an formadas por dos comillas dobles ("), que ir ́an antes y despu ́es de una secuencia de 0 o m ́as:
caracteres, exceptuando el salto de l ́ınea, las comillas dobles y la secuencia de escape ’ %’. los caracteres escapados definidos en el apartado anterior.
los caracteres en decimal, octal o hexadecimal definidos en el apartado anterior.
’ %’, seguido de un salto de l ́ınea.
Ejemplos:
    "%nRadio de la {circunferencia}: "
    "primera %
     segunda %
     tercera"
2.4. Delimitadores
## es una cadena
## es una cadena escrita
## en tres lineas
Consideramos los siguientes (no los he entrecomillado para facilitar la lectura):
( ) : ; , .. | =>
5

2.5. Operadores
Consideramos los siguientes clases:
Operadores aritm ́eticos (los dos u ́ltimos son, respectivamente el m ́odulo y la potencia):
+ - * / -- ++ \ ^
Operadores de bits (desplazamiento izda y desplazamiento dcha):
<- ->
Asignacion (el primero es la asignaci ́on a secas y el resto aplican uno de los operadores aritmeticos o de bits sobre la variable en la que se almacena el resultado)
:= :+ :- :/ :\ :^ :< :>
Operadores de acceso a memoria (estructuras, tablas y nombres de librer ́ıas):
. [ ] { } ::
Operadores relacionales:
< > <= >= = ~=
Operadores logicos (respectivamente, negacion, and y or):
~ /\ \/
A la hora de escribir en la consola la cadena indicando el reconocimiento de un operador, no es necesario que escribais el tipo de operador (aritm ́etico, de bits, asignaci ́on, etc), pero podeis hacerlo si quereis.
2.6. Comentarios
En Simple podemos encontrar dos tipos de comentarios:
los que comienzan con la secuencia ’##’ y abarcan hasta el final de la l ́ınea.
los comentarios multil ́ınea, delimitados por ’#{’ y ’#}’.
Importante: Cuando las secuencias ’##’, ’#{’ o ’#}’ aparecen dentro de un cadena o un comentario no pueden ser
interpretados como comentarios.
Tambi ́en Importante: Se ignorar ́a la posibilidad de anidamiento de comentarios multilınea. Se considera que si, en el futuro, algu ́n programador siente la tentaci ́on de anidar comentarios multilınea en su codigo, sera detectado y puesto bajo la custodia de la seccion Q del SOE antes de que pueda hacerlo.
Ejemplos:
    "a##b"
    ## #}
    f := g#{#}/h;
    m := n###{o
+ p;
2.7. Errores
## una cadena
## un comentario de una sola l ́ınea ## f := g / h;
## m := n + p;
Cuando el analizador encuentre una porci ́on de la cadena de entrada que no se corresponda con ninguno de los tokens anteriores (o con espacios, tabuladores o saltos de l ́ınea), devolver ́a un mensaje de error, indicando la l ́ınea en el que ha encontrado el error. Sin embargo, el analisis proseguira hasta agotar el fichero de entrada.
