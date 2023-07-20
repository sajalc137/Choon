%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>

	void yyerror(const char*);
	int yylex();

	extern FILE * yyin, *yyout;

	FILE *fp_choon;
	
	extern int line;
	
	char buffer[100];
	int ln = 0, tempno = 0;

	int assignop = -1;		//assignment operator == += -=
	int unaryop = -1;		//unary operator type
	int exprno = -1;		//FOR loop , 3rd expression
	int m = 0;				//string length for buffer
	char intbuf[20];
	char secIDbuf[20];

	char* num_conv();
	char* prefix();

%}

%token  HASH INCLUDE CSTDIO STDLIB MATH STRING TIME IOSTREAM CONIO
%token  NAMESPACE 
%token COUT ENDL
%token  STRING_LITERAL HEADER_LITERAL PRINT RETURN
%left 	'+' '-'
%left 	'/' '*' '%'
%right 	'='
%right UMINUS


%union{	
	char sval[300];
}


%token 	<sval> INTEGER_LITERAL 
%token 	<sval> CHARACTER_LITERAL
%token 	<sval> FLOAT_LITERAL 
%token	<sval> IDENTIFIER  
%token 	<sval> FOR 
%token  <sval> WHILE

%token	INC_OP 	DEC_OP 	LE_OP 	GE_OP 	EQ_OP 	NE_OP
%token	MUL_ASSIGN 	DIV_ASSIGN 	MOD_ASSIGN 	ADD_ASSIGN 	SUB_ASSIGN
%token	CHAR 	INT 	FLOAT 	VOID
%token  IF ELSE


%type <sval> 	additive_expression 
%type <sval>  	multiplicative_expression
%type <sval>	unary_expression
%type <sval>	relational_expression
%type <sval>	primary_expression
%type <sval> 	expression
%type <sval> 	postfix_expression
%type <sval>  	assignment_expression
%type <sval> 	conditional_expression
%type <sval>	unary_operator
%type <sval>	expr
%type <sval>	declarator
%type <sval>	printstat


%start S

%%
S : program 
  	;

program
	: HASH INCLUDE '<' libraries '>'  program
	| HASH INCLUDE HEADER_LITERAL 	 program
	| NSPACE translation_unit
	;
NSPACE
	: NAMESPACE ';'
translation_unit
	: ext_dec
	| translation_unit ext_dec
	;


ext_dec
	: declaration
	| function_definition	
	;


libraries
	: CSTDIO
	| STDLIB
	| MATH
	| STRING
	| TIME
	| IOSTREAM
	| CONIO
	;


compound_statement
	: '{' '}' 
	| '{' block_item_list '}'
	;


block_item_list
	: block_item
	| block_item_list block_item 	
	;


block_item
	: declaration
	| statement
	| RETURN expression_statement	
	| function_call ';'
	| printstat ';'
	;


printstat:
    COUT '<''<' IDENTIFIER 
    {
        fprintf(fp_choon, " . %s + C", num_conv($4));
    }
    ;


declaration
	: type_specifier init_declarator_list ';' 
	;


statement
	: compound_statement 
	| expression_statement
	| iteration_statement
	| conditional_statement
	;

conditional_statement
	: IF '('

	  conditional_expression ')'
	  {
			fprintf(fp_choon, ". t%d ||:",(tempno-1));
	  }
	  statement
	  {
			fprintf(fp_choon, ". C ~ :||");			
	  }
	  conditional_statement;
	| ELSE
	  statement
	  {
			fprintf(fp_choon, ":||");
	  }
	|
	;

iteration_statement
	:FOR '(' expression_statement 
		{
			fprintf(fp_choon, "%% ||:");
		}
	expression_statement
		{
			fprintf(fp_choon, ". =t%d - C ||: C ~ :|| ~",tempno-1);
		}
	expr  ')' statement 	 
		{
		
			//expression 3

			switch(exprno){
				case 0:
						fprintf(fp_choon, ". =%s + %s C#", $7, $7);
						break;

				case 1:
						fprintf(fp_choon, ". =%s + %s B", $7, $7);
						break;

				case 2:
						fprintf(fp_choon, ". =%s + %s C#", $7, $7);
						break;

				case 3:
						fprintf(fp_choon, ". =%s + %s B", $7, $7);
						break;

				case 4:
						fprintf(fp_choon, ". %s + %s =%s", num_conv(intbuf), $7, $7);
						break;

				case 5:
						fprintf(fp_choon, ". %s - %s =%s", num_conv(intbuf), $7, $7);
						break;

				case 6:
						sprintf(buffer,"t%d",tempno++);
						m = strlen(buffer);
						buffer[m] = '\0';
						fprintf(fp_choon, ". %s C %s + C ||: . =%s + %s =%s :|| . %s + C - - C ||: . =%s - %s =%s :|| . %s =%s", buffer, num_conv(intbuf), $7, buffer, buffer, num_conv(intbuf), $7, buffer, buffer, $7, buffer);
						break;

				case 7:
						fprintf(fp_choon, ". t%d C %s + t%d C - - C ||: . =%s - %s C . =t%d - t%d C . C ~ :|| ",tempno,num_conv(intbuf),tempno+1,$7,$7,tempno+1,tempno+1);
						fprintf(fp_choon, ". =%s ||: . =t%d - %s =%s . - B ||: . C ~ :|| ~ . C# + t%d =t%d :||",$7,tempno+1,$7,$7,tempno,tempno);
						fprintf(fp_choon, ". =%s - C ||: . =t%d + %s =%s . + B ||: . C ~ :|| ~ . B + t%d =t%d :||",$7,tempno+1,$7,$7,tempno,tempno);
						fprintf(fp_choon, ". %s =t%d",$7,tempno);
						tempno+=2;
						break;

				case 8:
						fprintf(fp_choon, ". %s + %s C . %s + %s =%s", num_conv(intbuf), $7, num_conv(secIDbuf), $7, $7);
						break;

				case 9:
						fprintf(fp_choon, ". %s + %s C . %s - %s =%s", num_conv(secIDbuf), $7, num_conv(intbuf), $7, $7);
						break;

				case 10:
						sprintf(buffer,"t%d",tempno++);
						m = strlen(buffer);
						buffer[m] = '\0';
						fprintf(fp_choon, ". %s C %s + C ||: . %s + %s =%s :|| . %s + C - - C ||: . %s - %s =%s :|| . %s =%s", buffer, num_conv(intbuf), num_conv(secIDbuf), buffer, buffer, num_conv(intbuf), num_conv(secIDbuf), buffer, buffer, $7, buffer);
						break;

				case 11:
						fprintf(fp_choon, ". t%d C %s + t%d C - - C ||: . =%s - %s C . =t%d - t%d C . C ~ :|| ",tempno,num_conv(intbuf),tempno+1,secIDbuf,secIDbuf,tempno+1,tempno+1);
						fprintf(fp_choon, ". =%s ||: . =t%d - %s =%s . - B ||: . C ~ :|| ~ . C# + t%d =t%d :||",secIDbuf,tempno+1,secIDbuf,secIDbuf,tempno,tempno);
						fprintf(fp_choon, ". =%s - C ||: . =t%d + %s =%s . + B ||: . C ~ :|| ~ . B + t%d =t%d :||",secIDbuf,tempno+1,secIDbuf,secIDbuf,tempno,tempno);
						fprintf(fp_choon, ". %s =t%d",$7,tempno);
						tempno+=2;
						break;
			}

			exprno = -1;

			//end of expression 3
			fprintf(fp_choon, ":||");
		}
		| WHILE '(' 
			{
				fprintf(fp_choon, "%% ||:");
			}
		conditional_expression ')'
			{
				fprintf(fp_choon, ". =t%d - C ||: C ~ :|| ~",tempno-1);
			}
		    statement
			{
				fprintf(fp_choon, ":||");
			}
			;


expr
	: IDENTIFIER INC_OP 							
		{  
			exprno = 0; 

			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';
		}
	| IDENTIFIER DEC_OP								
		{  
			exprno = 1;

			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';
		}		
	| INC_OP IDENTIFIER 							
		{  
			exprno = 2;

			m = strlen($2);
			strncpy($$, $2, m);
			$$[m] = '\0';
		}	
	| DEC_OP IDENTIFIER 							
		{  
			exprno = 3; 

			m = strlen($2);
			strncpy($$, $2, m);
			$$[m] = '\0';
		}	
	| IDENTIFIER ADD_ASSIGN INTEGER_LITERAL			
		{  
			exprno = 4; 

			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($3);
			strncpy(intbuf, $3, m);
			intbuf[m] = '\0';

		}	 
	| IDENTIFIER SUB_ASSIGN INTEGER_LITERAL			
		{  
			exprno = 5;
			
			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($3);
			strncpy(intbuf, $3, m);
			intbuf[m] = '\0';
		}	
	| IDENTIFIER MUL_ASSIGN INTEGER_LITERAL			
		{  
			exprno = 6;
			
			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($3);
			strncpy(intbuf, $3, m);
			intbuf[m] = '\0';
		}	
	| IDENTIFIER DIV_ASSIGN INTEGER_LITERAL			
		{  
			exprno = 7; 
			
			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($3);
			strncpy(intbuf, $3, m);
			intbuf[m] = '\0';
		}	
	| IDENTIFIER '=' IDENTIFIER '+' INTEGER_LITERAL	
		{  
			exprno = 8;

			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($5);
			strncpy(intbuf, $5, m);
			intbuf[m] = '\0';

			m = strlen($3);
			strncpy(secIDbuf, $3, m);
			secIDbuf[m] = '\0';
		}		
	| IDENTIFIER '=' IDENTIFIER '-' INTEGER_LITERAL	
		{  
			exprno = 9;
			
			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($5);
			strncpy(intbuf, $5, m);
			intbuf[m] = '\0';

			m = strlen($3);
			strncpy(secIDbuf, $3, m);
			secIDbuf[m] = '\0';
		}		
	| IDENTIFIER '=' IDENTIFIER '*' INTEGER_LITERAL	
		{  
			exprno = 10; 
			
			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($5);
			strncpy(intbuf, $5, m);
			intbuf[m] = '\0';

			m = strlen($3);
			strncpy(secIDbuf, $3, m);
			secIDbuf[m] = '\0';
		}		
	| IDENTIFIER '=' IDENTIFIER '/' INTEGER_LITERAL	
		{  
			exprno = 11; 

			m = strlen($1);
			strncpy($$, $1, m);
			$$[m] = '\0';

			m = strlen($5);
			strncpy(intbuf, $5, m);
			intbuf[m] = '\0';

			m = strlen($3);
			strncpy(secIDbuf, $3, m);
			secIDbuf[m] = '\0';
		}		
	;

type_specifier
	: VOID 	
	| CHAR 	
	| INT 	
	| FLOAT 
	;


init_declarator_list
	: init_declarator 
	| init_declarator_list ',' init_declarator
	;


init_declarator
	: IDENTIFIER  '=' assignment_expression		
		{
			fprintf(fp_choon, ". %s + %s C ", num_conv($3), $1);
		}			
	| IDENTIFIER
	;


assignment_expression
	: conditional_expression		{	strcpy($$, $1); }
	| unary_expression assignment_operator assignment_expression 		
		{ 
			switch(assignop){
				case 0: 
						fprintf(fp_choon, ". %s + %s C ", num_conv($3), $1);
						break;

				case 1: 
						fprintf(fp_choon, ". %s + %s =%s ", num_conv($3), $1, $1);
						break;
				case 2:
						fprintf(fp_choon, ". %s + C - - %s =%s ", num_conv($3), $1, $1);
						break;
				case 3:
						sprintf(buffer,"t%d",tempno++);
						m = strlen(buffer);
						buffer[m] = '\0';
						fprintf(fp_choon, ". %s C %s + C ||: . =%s + %s =%s :|| . %s + C - - C ||: . =%s - %s =%s :|| . %s =%s", buffer, num_conv($3), $1, buffer, buffer, num_conv($3), $1, buffer, buffer, $1, buffer);
						break;
				case 4:
						fprintf(fp_choon, ". t%d C %s + t%d C - - C ||: . =%s - %s C . =t%d - t%d C . C ~ :|| ",tempno,num_conv($3),tempno+1,$1,$1,tempno+1,tempno+1);
						fprintf(fp_choon, ". =%s ||: . =t%d - %s =%s . - B ||: . C ~ :|| ~ . C# + t%d =t%d :||",$1,tempno+1,$1,$1,tempno,tempno);
						fprintf(fp_choon, ". =%s - C ||: . =t%d + %s =%s . + B ||: . C ~ :|| ~ . B + t%d =t%d :||",$1,tempno+1,$1,$1,tempno,tempno);
						fprintf(fp_choon, ". %s =t%d",$1,tempno);
						tempno+=2;
						break;
				case 5:
						fprintf(fp_choon, ". t%d C %s + t%d C - - C ||: . =%s - %s C . =t%d - t%d C . C ~ :|| ",tempno,num_conv($3),tempno+1,$1,$1,tempno+1,tempno+1);
						fprintf(fp_choon, ". =%s ||: . =t%d - %s =%s . - B ||: . C ~ :|| ~ . C# + t%d =t%d :||",$1,tempno+1,$1,$1,tempno,tempno);
						fprintf(fp_choon, ". =%s - C ||: . =t%d + %s =%s . + B ||: . C ~ :|| ~ . B + t%d =t%d :||",$1,tempno+1,$1,$1,tempno,tempno);
						fprintf(fp_choon, ". =t%d + %s =t%d",tempno+1,$1,tempno);
						tempno+=2;
						break;
			}
			
			assignop = -1;

			
		}
	;


assignment_operator
	: '='			{ assignop = 0; 	}
	| ADD_ASSIGN	{ assignop = 1; 	}
	| SUB_ASSIGN	{ assignop = 2; 	}
	| MUL_ASSIGN	{ assignop = 3; 	}
	| DIV_ASSIGN	{ assignop = 4; 	}
	| MOD_ASSIGN	{ assignop = 5; 	}
	;

expression_statement
	: ';'				
	| expression ';' 	
	;


expression
	: assignment_expression		{	strcpy($$, $1); }
	| expression ',' assignment_expression 
	;


primary_expression
	: IDENTIFIER 			{	strcpy($$, $1); 	}
	| INTEGER_LITERAL		{	strcpy($$, $1); 	}
	| FLOAT_LITERAL			{	strcpy($$, $1); 	}
	| CHARACTER_LITERAL		{	strcpy($$, $1); 	}
	| '(' expression ')'	{	strcpy($$, $2); 	}
	;


postfix_expression
	: primary_expression		{	strcpy($$, $1); }	
	| postfix_expression INC_OP	
		{
			fprintf(fp_choon, ". =%s + %s C#", $1, $1);			
		}
	| postfix_expression DEC_OP 
		{
			fprintf(fp_choon, ". =%s + %s B", $1, $1);
		}
	;


unary_expression
	: postfix_expression				{	strcpy($$, $1); }
	| unary_operator unary_expression 
		{
			switch(unaryop){
				case 1: 
						sprintf(buffer,"t%d",tempno++);	
						m = strlen(buffer);
						buffer[m] = '\0';
						char* neg = (char*)malloc((strlen($2)+2) * sizeof(char));
						*neg = '-';
						strcpy(neg+1,$2);
						fprintf(fp_choon,". %s + %s C", num_conv(neg), buffer);
						free(neg);
						strncpy($$, buffer, m+1);						
						break;

				case 4: 
						sprintf(buffer,"t%d",tempno++);
						m = strlen(buffer);
						buffer[m] = '\0';
						fprintf(fp_choon, ". =%s + %s C#", $2, buffer);
						strncpy($$, buffer, m+1);		//check out
						break;

				case 5:
						sprintf(buffer,"t%d",tempno++);
						m = strlen(buffer);
						buffer[m] = '\0';
						fprintf(fp_choon, ". =%s + %s B", $2, buffer);
						strncpy($$, buffer, m+1);		//check out
						break;
			}
			unaryop = -1;
		}			
	;


unary_operator
	: '+' 		{	unaryop = 0; }
	| '-'		{	unaryop = 1; }	%prec UMINUS
	| '!'		{	unaryop = 2; }
	| '~'		{	unaryop = 3; }
	| "INC_OP"	{	unaryop = 4; }
	| "DEC_OP" 	{	unaryop = 5; }
	;


conditional_expression
	: relational_expression		{	strcpy($$, $1); }
	| conditional_expression EQ_OP relational_expression
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			fprintf(fp_choon, ". %s + %s C# . %s + C - - %s =%s . B + =%s ||: %s C# ~ :||",num_conv($1),buffer,num_conv($3),buffer,buffer,buffer,buffer);

			strncpy($$, buffer, m+1);		//check out
		}
	| conditional_expression NE_OP relational_expression
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			fprintf(fp_choon, ". %s + %s C . %s + C - - %s =%s ||: . =%s - %s C . C ~ :|| . =%s - %s C",num_conv($1),buffer,num_conv($3),buffer,buffer,buffer,buffer,buffer,buffer);			
	
			strncpy($$, buffer, m+1);		//check out
		}
	;


relational_expression
	: additive_expression		{	strcpy($$, $1); }
	| relational_expression '<' additive_expression
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			fprintf(fp_choon, ". %s + %s C",num_conv($3),buffer);
			fprintf(fp_choon, ". %s + C - - %s =%s",num_conv($1),buffer,buffer);

			strncpy($$, buffer, m+1);		//check out
		}
	| relational_expression '>' additive_expression
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			fprintf(fp_choon, ". %s + %s C",num_conv($1),buffer);
			fprintf(fp_choon, ". %s + C - - %s =%s",num_conv($3),buffer,buffer);

			strncpy($$, buffer, m+1);		//check out
		}
	| relational_expression LE_OP additive_expression
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			fprintf(fp_choon, ". %s + %s C#",num_conv($3),buffer);
			fprintf(fp_choon, ". %s + C - - %s =%s",num_conv($1),buffer,buffer);

			strncpy($$, buffer, m+1);		//check out
		}
	| relational_expression GE_OP additive_expression
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			fprintf(fp_choon, ". %s + %s C#",num_conv($1),buffer);
			fprintf(fp_choon, ". %s + C - - %s =%s",num_conv($3),buffer,buffer);

			strncpy($$, buffer, m+1);		//check out
		}		
	;


additive_expression
	: multiplicative_expression		{	strcpy($$, $1); }
	| additive_expression '+' multiplicative_expression 	
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			
			fprintf(fp_choon, ". %s + %s C ", num_conv($1), buffer);
			fprintf(fp_choon, ". %s + %s =%s", num_conv($3), buffer, buffer);
			strncpy($$, buffer, m+1);		//check out
		}
	| additive_expression '-' multiplicative_expression	
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';

			fprintf(fp_choon, ". %s + %s C ", num_conv($1), buffer);
			fprintf(fp_choon, ". %s - %s =%s", num_conv($3), buffer, buffer);

			strncpy($$, buffer, m+1);		//check out
		}
	;


multiplicative_expression
	: unary_expression			
	| multiplicative_expression '*' unary_expression 
		{
			sprintf(buffer,"t%d",tempno++);
			m = strlen(buffer);
			buffer[m] = '\0';
			fprintf(fp_choon, ". %s C %s + C ||: . %s + %s =%s :|| . %s + C - - C ||: . %s - %s =%s :||", buffer, num_conv($3), num_conv($1), buffer, buffer, num_conv($3), num_conv($1), buffer, buffer);
			strncpy($$, buffer, m+1);		//check out
		}						
	| multiplicative_expression '/' unary_expression	
		{
			// sprintf(buffer,"t%d",tempno++);
			// m = strlen(buffer);
			// buffer[m] = '\0';
			// fprintf(fp_icg, "%s = %s / %s\n",buffer, $1, $3);
			// fprintf(fp_quad, "\t/\t\t%s\t\t%s\t\t%s\n", $1, $3, buffer);
			// strncpy($$, buffer, m+1);		//check out
		}										
	| multiplicative_expression '%' unary_expression
		{
			// sprintf(buffer,"t%d",tempno++);
			// m = strlen(buffer);
			// buffer[m] = '\0';
			// fprintf(fp_icg, "%s = %s %c %s\n",buffer, $1, '%',$3);
			// fprintf(fp_quad, "\t%c\t\t%s\t\t%s\t\t%s\n", '%',$1, $3, buffer);
			// strncpy($$, buffer, m+1);		//check out
		}						
	;


function_definition
	: type_specifier declarator compound_statement 					
	| declarator compound_statement 								
	;

function_call
	: declarator '(' identifier_list ')'
	| declarator '(' ')'
	;


declarator
	: IDENTIFIER 	
		{ 
			m = strlen($1);
			strncpy($$, $1, m);	
			$$[m] = '\0';
		}
	| declarator '(' identifier_list ')'				
	| declarator '(' ')'					
	;


identifier_list
	: IDENTIFIER				
	| identifier_list ',' IDENTIFIER
	;


%%


void yyerror(const char *str){
	fflush(stdout);
	printf("Line:%d: ", line);
	printf("\033[1;31m");
	printf("error: ");
	printf("\033[0m");
	printf("%s\n", str);
}

char* num_conv(const char* str) {
    if (atoi(str) || *str == '0') return prefix(str);

	size_t n = strlen(str);
    char* result = (char*)malloc((n + 2) * sizeof(char));

    if (result == NULL) {
        printf("Memory allocation failed.\n");
        return NULL;
    }

    *result = '=';
    strcpy(result + 1, str);

    return result;
}

char* prefix(char* str)
{
	int n = atoi(str);
	if (n == 0)
	{
		return "C";
	}
	else if (n > 0)
    {
		int temp = (n + 5) / 6, bits = 0, i, j, count = 0;
		while(temp)
		{
			bits++;
			temp /= 2;
		}
		int* repre = (int*)malloc(bits * sizeof(int));
		for (i = 0; i < bits; i++)
		{
			temp = n / pow(2, bits - i - 1);
			if (temp >= 6)
			{
				repre[i] = 6;
				count += 3;
			}
			else
			{
				repre[i] = temp;
				if (temp == 1 || temp == 3 || temp == 6)
					count += 3;
				else
					count += 2;
			}
			n -= repre[i] * (pow(2, bits - i - 1));
		}
		count--;
		char* ans = (char*)malloc(count * sizeof(char));
		j = 0;
		for (i = 0; i < bits; i++)
		{
			switch (repre[i])
			{
				case 0:
					strcpy(ans + j, "C");
					j += 1;
					break;
				case 1:
					strcpy(ans + j, "C#");
					j += 2;
					break;
				case 2:
					strcpy(ans + j, "D");
					j += 1;
					break;
				case 3:
					strcpy(ans + j, "D#");
					j += 2;
					break;
				case 4:
					strcpy(ans + j, "E");
					j += 1;
					break;
				case 5:
					strcpy(ans + j, "F");
					j += 1;
					break;
				case 6:
					strcpy(ans + j, "F#");
					j += 2;
					break;
			}
			if (j < count)
			{
				ans[j] = '+';
				j++;
			}
		}
		return ans;
	}
	else
	{
		n = abs(n);
		int temp = (n + 4) / 5, bits = 0, i, j, count = 0;
		while(temp)
		{
			bits++;
			temp /= 2;
		}
		int* repre = (int*)malloc(bits * sizeof(int));
		for (i = 0; i < bits; i++)
		{
			temp = n / pow(2, bits - i - 1);
			if (temp >= 5)
			{
				repre[i] = 5;
				count += 2;
			}
			else
			{
				repre[i] = temp;
				if (temp == 2 || temp == 4)
					count += 3;
				else
					count += 2;
			}
			n -= repre[i] * (pow(2, bits - i - 1));
		}
		count--;
		char* ans = (char*)malloc(count * sizeof(char));
		j = 0;
		for (i = 0; i < bits; i++)
		{
			switch (repre[i])
			{
				case 0:
					strcpy(ans + j, "C");
					j += 1;
					break;
				case 1:
					strcpy(ans + j, "B");
					j += 1;
					break;
				case 2:
					strcpy(ans + j, "A#");
					j += 2;
					break;
				case 3:
					strcpy(ans + j, "A");
					j += 1;
					break;
				case 4:
					strcpy(ans + j, "G#");
					j += 2;
					break;
				case 5:
					strcpy(ans + j, "G");
					j += 1;
					break;
			}
			if (j < count)
			{
				ans[j] = '+';
				j++;
			}
		}
		return ans;
	}
}

int main(int argc, char *argv[]){
	int printflag=0;
	if(argc>1)
	{
		if(!strcmp(argv[1],"--print"))
			printflag=1;
		else
			{
				printf("Invalid Option!\n");
				return 0;
			}
	}

	fp_choon	= fopen("choon.txt", "w");

	yyparse();
	

	fclose(fp_choon);

	if(printflag)
	{
		printf("\n\nChoon Code\n\n");
		system("cat choon.txt");
	}

	return 0;
}

