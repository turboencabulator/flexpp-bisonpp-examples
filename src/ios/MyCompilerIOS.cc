//
// Nom du Fichier : 	|>nom_fichier<|
// Titre : 		|>Titre<|
// Auteur:		|>auteur<|
// Date de creation :	|>dateCreation<|
//
// Description :
//	Document de reference : |>doc<|
//	Objet : |>objet<|
//
//
//
// historique :
// |>date<|	|>auteur<|	|>objet<|
//
#include "MyScannerIOS.h"
#include "MyParserIOS.h"

class MyCompiler : public MyParser
{private:
 MyScanner theScanner;
 public:
 virtual int yylex();
 virtual void yyerror(const char *m);
 MyCompiler()
  {};
};

int MyCompiler::yylex()
{
 yylloc.first_line=theScanner.theLine;
 yylloc.first_column=theScanner.theColumn;
 int token=theScanner.yylex(&yylval,&yylloc);
 yylloc.last_line=theScanner.theLine;
 yylloc.last_column=theScanner.theColumn;
 yylloc.text=(char *)theScanner.yytext;
 return token;
}

void MyCompiler::yyerror(const char *m)
{ std::cerr<<(int)yylloc.first_line<<": "<<m<<" at token '"
      <<(char *)yylloc.text<<"'"<<std::endl;
}

int main(int argc,char **argv)
{
 MyCompiler aCompiler;
 int result=aCompiler.yyparse();
 std::cout<<"Result of Parsing="<<(result?"Error":"OK")<<std::endl;
 return 0;
};
