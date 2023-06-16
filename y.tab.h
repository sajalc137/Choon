/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    HASH = 258,                    /* HASH  */
    INCLUDE = 259,                 /* INCLUDE  */
    CSTDIO = 260,                  /* CSTDIO  */
    STDLIB = 261,                  /* STDLIB  */
    MATH = 262,                    /* MATH  */
    STRING = 263,                  /* STRING  */
    TIME = 264,                    /* TIME  */
    IOSTREAM = 265,                /* IOSTREAM  */
    CONIO = 266,                   /* CONIO  */
    NAMESPACE = 267,               /* NAMESPACE  */
    COUT = 268,                    /* COUT  */
    ENDL = 269,                    /* ENDL  */
    STRING_LITERAL = 270,          /* STRING_LITERAL  */
    HEADER_LITERAL = 271,          /* HEADER_LITERAL  */
    PRINT = 272,                   /* PRINT  */
    RETURN = 273,                  /* RETURN  */
    UMINUS = 274,                  /* UMINUS  */
    INTEGER_LITERAL = 275,         /* INTEGER_LITERAL  */
    CHARACTER_LITERAL = 276,       /* CHARACTER_LITERAL  */
    FLOAT_LITERAL = 277,           /* FLOAT_LITERAL  */
    IDENTIFIER = 278,              /* IDENTIFIER  */
    FOR = 279,                     /* FOR  */
    WHILE = 280,                   /* WHILE  */
    INC_OP = 281,                  /* INC_OP  */
    DEC_OP = 282,                  /* DEC_OP  */
    LE_OP = 283,                   /* LE_OP  */
    GE_OP = 284,                   /* GE_OP  */
    EQ_OP = 285,                   /* EQ_OP  */
    NE_OP = 286,                   /* NE_OP  */
    MUL_ASSIGN = 287,              /* MUL_ASSIGN  */
    DIV_ASSIGN = 288,              /* DIV_ASSIGN  */
    MOD_ASSIGN = 289,              /* MOD_ASSIGN  */
    ADD_ASSIGN = 290,              /* ADD_ASSIGN  */
    SUB_ASSIGN = 291,              /* SUB_ASSIGN  */
    CHAR = 292,                    /* CHAR  */
    INT = 293,                     /* INT  */
    FLOAT = 294,                   /* FLOAT  */
    VOID = 295,                    /* VOID  */
    IF = 296,                      /* IF  */
    ELSE = 297                     /* ELSE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define HASH 258
#define INCLUDE 259
#define CSTDIO 260
#define STDLIB 261
#define MATH 262
#define STRING 263
#define TIME 264
#define IOSTREAM 265
#define CONIO 266
#define NAMESPACE 267
#define COUT 268
#define ENDL 269
#define STRING_LITERAL 270
#define HEADER_LITERAL 271
#define PRINT 272
#define RETURN 273
#define UMINUS 274
#define INTEGER_LITERAL 275
#define CHARACTER_LITERAL 276
#define FLOAT_LITERAL 277
#define IDENTIFIER 278
#define FOR 279
#define WHILE 280
#define INC_OP 281
#define DEC_OP 282
#define LE_OP 283
#define GE_OP 284
#define EQ_OP 285
#define NE_OP 286
#define MUL_ASSIGN 287
#define DIV_ASSIGN 288
#define MOD_ASSIGN 289
#define ADD_ASSIGN 290
#define SUB_ASSIGN 291
#define CHAR 292
#define INT 293
#define FLOAT 294
#define VOID 295
#define IF 296
#define ELSE 297

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 42 "icg.y"
	
	char sval[300];

#line 155 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
