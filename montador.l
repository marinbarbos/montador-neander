%{
unsigned char buffer[516] = {0x03, 0x4E, 0x44, 0x52};
int currSize = 4;

// necessario para executar sem todas as bibliotecas(caso de rodar em linux)
// como apenas lemos um arquivo não precisamos do yywrap correto
int yywrap(){return(1);}

void escreverNoArquivo(FILE* fp) {
    if (fp) {
		  	fwrite(buffer, sizeof(unsigned char), sizeof(buffer), fp);
				fclose(fp);
		}
}

void addToBuffer(unsigned char toWrite) {
  buffer[currSize++] = toWrite;
	buffer[currSize++] = 0x00;
}

%}

%%
NOP addToBuffer(0x00);
STA addToBuffer(0x10);
LDA addToBuffer(0x20);
ADD addToBuffer(0x30);
OR  addToBuffer(0x40);
AND addToBuffer(0x50);
NOT addToBuffer(0x60);
JMP addToBuffer(0x80);
JN  addToBuffer(0x90);
JZ  addToBuffer(0xA0);
HLT addToBuffer(0xF0);
[0-9]+ {
    unsigned int numeroHex = strtol(yytext, NULL, 16);
    addToBuffer(numeroHex);
}
<<EOF>> return 0;
%%

int main(int argc, char *argv[]){

	FILE *fin;
	FILE* arquivo;
	arquivo = fopen("teste.mem", "w+b"); // Cria o arquivo se não existir
	if (arquivo != NULL) {
			printf("Arquivo criado com sucesso!\n");
	} else {
			printf("Não foi possível criar o arquivo.\n");
			return 1;
	}
	if (argc == 2) {
		if (fin = fopen(argv[1],"r"))
			yyin = fin;
		else
			perror(argv[0]);
	} else
		yyin = stdin;

	yylex ();
	escreverNoArquivo(arquivo);
	return (0);
}