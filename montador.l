%%
NOP printf ("0");
STA printf ("10");
LDA printf ("20");
ADD printf ("30");
OR printf ("40");
AND printf ("50");
NOT printf ("60");
JMP printf ("80");
JN printf ("90");
JZ printf ("A0");
HLT printf ("F0");
<<EOF>> return 0;
%%
int main(int argc, char *argv[]){
	FILE *fin;
	if (argc == 2) {
		if (fin = fopen(argv[1],"r"))
			yyin = fin;
		else
			perror(argv[0]);
	} else
		yyin = stdin;

	yylex ();
	return (0);
}
