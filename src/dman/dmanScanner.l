/*
 * Nom du Fichier : 	|>nom_fichier<|
 * Titre : 		|>Titre<|
 * Auteur:		|>auteur<|
 * Date de creation :	|>dateCreation<|
 */
/* Description :
 *	Document de reference : |>doc<|
 *	Objet : |>objet<|
 *
 */
/*
 * historique :
 * |>date<|	|>auteur<|	|>objet<|
 */
/* -------------- declaration section -------------- */
%s DANS_LIGNE
%x DANS_COMMENT
%name DmanScanner
%{
#include "dmanParser.h"
#define YY_NULL 0
#define YY_USER_ACTION BeginAction();
%}

%define INHERIT
%define LEX_RETURN int
%define LEX ScanValue
%define LEX_PARAM TokenValue &theValue
%define MEMBERS \
	protected: \
		int theLine, theColumn; \
		void BeginAction(); \
		virtual void SetDebug(int) = 0;
%define CONSTRUCTOR_PARAM void
%define CONSTRUCTOR_INIT : theLine(1), theColumn(1)
%define CONSTRUCTOR_CODE ;
%define TEXT theText
%define LENG theTextLength




SPACES1 [ \t]+
SPACES [ \t]*
LF (\r\n)|(\r)|(\n)|(\x0c)
ANY_CHAR [^\r\n\x0c]
PRINT_CHAR [\x21-\x7e]
/* -------------- rules section -------------- */
%%
<INITIAL>{SPACES1}      {BEGIN(INITIAL);}
{SPACES}{LF}            {BEGIN(INITIAL); theLine++; theColumn = 1; return DmanParser::TOK_LF;}
\\{LF}                  {theLine++; theColumn = 1;}

<INITIAL>":"[Hh][eE][aA][Dd][Ee][Rr]            {BEGIN(DANS_LIGNE); return DmanParser::CMD_HEADER;}
<INITIAL>":"[Ss][eE][cC][Tt][Ii][Oo][Nn]        {BEGIN(DANS_LIGNE); return DmanParser::CMD_SECTION;}
<INITIAL>":"[Ss][Ss][eE][cC][Tt][Ii][Oo][Nn]    {BEGIN(DANS_LIGNE); return DmanParser::CMD_SSECTION;}
<INITIAL>":"[A-Za-z0-9_]*                       {BEGIN(DANS_LIGNE); return DmanParser::CMD_BAD;}

<INITIAL>("-"){SPACES}          {BEGIN(DANS_LIGNE); return DmanParser::TOK_ITEM1;}
<INITIAL>("--"){SPACES}         {BEGIN(DANS_LIGNE); return DmanParser::TOK_ITEM2;}
<INITIAL>("---"){SPACES}        {BEGIN(DANS_LIGNE); return DmanParser::TOK_ITEM3;}
<INITIAL>("-"+)                 {BEGIN(DANS_LIGNE); return DmanParser::TOK_ITEM_BAD;}
<INITIAL>(">"){SPACES}          {BEGIN(DANS_LIGNE); return DmanParser::TOK_INDENT1;}
<INITIAL>(">>"){SPACES}         {BEGIN(DANS_LIGNE); return DmanParser::TOK_INDENT2;}
<INITIAL>(">>>"){SPACES}        {BEGIN(DANS_LIGNE); return DmanParser::TOK_INDENT3;}
<INITIAL>(">"+)                 {BEGIN(DANS_LIGNE); return DmanParser::TOK_INDENT_BAD;}

\\{SPACES1}             {BEGIN(DANS_LIGNE); theValue.theChar = ' '; return DmanParser::TOK_CHAR;}
\\{ANY_CHAR}            {BEGIN(DANS_LIGNE); theValue.theChar = theText[1]; return DmanParser::TOK_CHAR;}

{SPACES1}               {BEGIN(DANS_LIGNE); return DmanParser::TOK_SPACE;}
"\""                    {BEGIN(DANS_LIGNE); return DmanParser::TOK_DQUOTE;}
{SPACES}"{"{SPACES}     {BEGIN(DANS_LIGNE); return DmanParser::TOK_BEGIN;}
{SPACES}"}"{SPACES}     {BEGIN(DANS_LIGNE); return DmanParser::TOK_END;}
"<"                     {BEGIN(DANS_LIGNE); return DmanParser::TOK_INF;}
">"                     {BEGIN(DANS_LIGNE); return DmanParser::TOK_SUP;}

"�"     {BEGIN(DANS_LIGNE); theValue.theString = "e'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "E'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "e`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "E`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "e^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "E^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "e:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "E:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "a'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "A'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "a`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "A`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "a^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "A^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "a:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "A:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "a~"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "A~"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "c,"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "C,"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "i'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "I'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "i`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "I`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "i^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "I^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "i:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "I:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "u'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "U'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "u`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "U`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "u^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "U^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "u:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "U:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "o:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "U:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "o^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "O^"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "o`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "O`"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "o'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "O'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "o~"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "O~"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "y:"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "y'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "Y'"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "n~"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "N~"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "*8"; return DmanParser::TOK_COMPOSED1;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "o/"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "O/"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "*(ae"; return DmanParser::TOK_COMPOSED1;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "*(Ae"; return DmanParser::TOK_COMPOSED1;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "*!"; return DmanParser::TOK_COMPOSED1;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "*?"; return DmanParser::TOK_COMPOSED1;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "ao"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "Ao"; return DmanParser::TOK_COMPOSED2;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "*R"; return DmanParser::TOK_COMPOSED1;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "(co"; return DmanParser::TOK_COMPOSED1;}
"�"     {BEGIN(DANS_LIGNE); theValue.theString = "(ct"; return DmanParser::TOK_COMPOSED1;}

"%"[A-Z]"%"     {BEGIN(DANS_LIGNE); theValue.theChar = '?'; return DmanParser::TOK_CHAR;} /* mode debug parser/lexer */
"%+%"           {SetDebug(1);} /* mode debug parser/lexer */
"%-%"           {SetDebug(0);}

"%"                             {BEGIN(DANS_COMMENT);}
<DANS_COMMENT>{ANY_CHAR}+       {}
<DANS_COMMENT>{LF}              {BEGIN(INITIAL); theLine++; theColumn = 1;}

\\              {BEGIN(DANS_LIGNE); return DmanParser::TOK_BAD;}
{PRINT_CHAR}    {BEGIN(DANS_LIGNE); theValue.theChar = theText[0]; return DmanParser::TOK_CHAR;}
.               {BEGIN(DANS_LIGNE); return DmanParser::TOK_BAD;}

<<EOF>> {yyterminate();}
%%
/* -------------- body section -------------- */
void DmanScanner::BeginAction()
{
	theColumn += theTextLength;
}


/* parseur sur scanner */

class DmanConverter : private DmanScanner,
                      public DmanParser
{
protected:
	int Scan();
public:
	void PrintError(const char *s);
	DmanConverter();
	void SetDebug(int d);
	~DmanConverter();
};

void DmanConverter::SetDebug(int d)
{
	debugFlag = d;
	fprintf(stderr, "DEBUG MODE = %d\n", debugFlag);
}

DmanConverter::DmanConverter() {debugFlag = 0;}
DmanConverter::~DmanConverter() {}

int DmanConverter::Scan()
{
	theTokenLocation.first_line = theLine;
	theTokenLocation.first_column = theColumn;
	int t = DmanScanner::ScanValue(theTokenValue);
	theTokenLocation.last_line = theLine;
	theTokenLocation.last_column = theColumn;
	theTokenLocation.text = (char *)theText;
	if (debugFlag) {
		fprintf(stderr, "TOKEN %d (l%d,c%d-l%d,c%d)=(%d)\"%*.*s\"\n", t,
		        theTokenLocation.first_line, theTokenLocation.first_column,
		        theTokenLocation.last_line,  theTokenLocation.last_column,
		        theTextLength, theTextLength,
		        theTextLength, theTokenLocation.text);
	}
	return t;
}

void DmanConverter::PrintError(const char *s)
{
	fprintf(stderr, "%s\n", s);
	fprintf(stderr, "Stopped at or near token (line %d, column %d - line %d, column %d):\"%s\"\n",
	        theTokenLocation.first_line, theTokenLocation.first_column,
	        theTokenLocation.last_line,  theTokenLocation.last_column,
	        theTokenLocation.text);
}

int main(int argc,char **argv)
{
	DmanConverter theConverter;
	int nok;
	nok = theConverter.Parse();
	if (nok || theConverter.errorCount > 0) {
		fprintf(stderr, "%d Errors when parsing.\n", theConverter.errorCount);
		nok = 1;
	}
	return nok;
}
