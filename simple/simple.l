
%{ 
   #include <string.h>
   #include <stdlib.h>
   int num_linea=1;
%}
%x comentario
ID              [A-Za-z_][A-Za-z_0-9]*
SP              [\t]
DIGITO          [0-9]
CLAVE           (?i:abstracto)|(?i:booleano)|(?i:bucle)|(?i:caracter)|(?i:casos)|(?i:clase)|(?i:como)|(?i:constante)|(?i:constructor)|(?i:corto)|(?i:cuando)|(?i:de)|(?i:descendente)|(?i:destructor)|(?i:devolver)|(?i:diccionario)|(?i:en)|(?i:entero)|(?i:entonces)|(?i:enumeracion)|(?i:es)|(?i:especifico)|(?i:excepcion)|(?i:exportar)|(?i:falso)|(?i:fin)|(?i:final)|(?i:finalmente)|(?i:generico)|(?i:importar)|(?i:largo)|(?i:lanza)|(?i:libreria)|(?i:lista)|(?i:mientras)|(?i:objeto)|(?i:otro)|(?i:para)|(?i:principio)|(?i:privado)|(?i:programa)|(?i:protegido)|(?i:prueba)|(?i:publico)|(?i:rango)|(?i:real)|(?i:referencia)|(?i:registro)|(?i:repetir)|(?i:salir)|(?i:si)|(?i:signo)|(?i:siguiente)|(?i:sino)|(?i:subprograma)|(?i:tabla)|(?i:tipo)|(?i:ultima)|(?i:valor)|(?i:verdadero)
CONST_ENT       [0-9]*|(%[oO][0-7]*)|(%[xX][0-9a-fA-F]*)
CONST_FRAC      {CONST_ENT}?"."{CONST_ENT}
CONST_EXP       ({CONST_ENT}|{CONST_FRAC})"^"[+-]?({CONST_ENT}|{CONST_FRAC}|([0-9a-fA-F]*))
CARAC           [^\n'%]|"%'"|"%\""|"%%"|"%n"|"%r"|"%t"|(%[0-2]?[0-9]{1,2})|(%[oO][0-3]?[0-7]{0,2})|(%[xX][0-9a-fA-F]{1,2})
CARAC2          [^\n'%\"]|"%'"|"%\""|"%%"|"%n"|"%r"|"%t"|(%[0-2]?[0-9]{1,2})|(%[oO][0-3]?[0-7]{0,2})|(%[xX][0-9a-fA-F]{1,2})
DELIMITADOR      \(|\)|\:|\;|\,|\||\=>|\¨|".."
CIRCUNFLEJO     "^"[^DIGITO]
PUNTO           "."[^DIGITO] 
OPERADOR        \+|\-|\*|\/|\-\-|\++|\\|{CIRCUNFLEJO}|\<\-|\-\>|\:=|\:\+|\:\-|\:\/|\:\\|\:\^|\:\<|\:\>|{PUNTO}|\[|\]|\{|\}|\:\:|\<|\>|\<\=|\>\=|\=|\/\\|\\\/
CADENAS         ({CARAC2})*(["%"][\n])*({CARAC2})*
COMENTARIOS     \##(.)*
ERROR           [^{ID}{DELIMITADOR}{CONST_ENT}{CONST_FRAC}{CONST_EXP}{CLAVE}{CARAC}{OPERADOR}{CADENAS}{COMENTARIOS}\n[:blank:]]

%%

{CLAVE}            printf("Línea:%d,Palabra reservada: %s\n",num_linea,yytext );

{ID}               printf("Línea:%d,Identificador: %s\n",num_linea,yytext );

{CONST_ENT}        printf("Línea:%d,Constante entera: %s\n",num_linea,yytext);

{CONST_FRAC}       printf("Línea:%d,Constante  fraccionaria: %s\n",num_linea,yytext);

{CONST_EXP}        printf("Línea:%d,Constante real: %s\n",num_linea,yytext);

’{CARAC}’          printf("Línea:%d,Caracter: %s\n",num_linea,yytext);

{DELIMITADOR}      printf("Línea:%d,Delimitador: %s\n",num_linea,yytext);

{OPERADOR}         printf("Línea:%d,Operador: %s\n",num_linea,yytext);

\"{CADENAS}\"      printf("Línea:%d,Cadena: %s\n",num_linea,yytext);

{COMENTARIOS}      ;

"#{"               BEGIN(comentario);
<comentario>"#}"   BEGIN(INITIAL);
<comentario>(.|\n)    BEGIN(comentario);

{ERROR}            printf("Línea:%d,ERROR: %s\n",num_linea,yytext);


\n                 num_linea++;


%%

int yywrap() {
  return(1);
  }

int main(int argc, char *argv[]) {

  if (argc < 2) {
    printf("Uso: ./simple NombreArchivo\n");
    }
  else {
    yyin = fopen(argv[1],"r");
    yylex();
    }
  }
