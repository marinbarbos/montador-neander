%{

FILE *arquivo;

void escreverNumeroHexaNoArquivo(FILE *arquivo, unsigned int numeroHex) {
	unsigned char byte = numeroHex & 0xFF;
	size_t elementosEscritos = fwrite(&byte, sizeof(unsigned char), 1, arquivo);
}

void escreverInstrucaoHexaNoArquivo(FILE *arquivo, unsigned int numero) {
    if (arquivo != NULL) {
			escreverNumeroHexaNoArquivo(arquivo, numero);
			escreverNumeroHexaNoArquivo(arquivo, 0);
			printf("%x %x0", numero, 0);
    }
}

%}

%%
NOP escreverInstrucaoHexaNoArquivo (arquivo, 0x0);
STA escreverInstrucaoHexaNoArquivo (arquivo, 0x10);
LDA escreverInstrucaoHexaNoArquivo (arquivo, 0x20);
ADD escreverInstrucaoHexaNoArquivo (arquivo, 0x30);
OR escreverInstrucaoHexaNoArquivo (arquivo, 0x40);
AND escreverInstrucaoHexaNoArquivo (arquivo, 0x50);
NOT escreverInstrucaoHexaNoArquivo (arquivo, 0x60);
JMP escreverInstrucaoHexaNoArquivo (arquivo, 0x80);
JN escreverInstrucaoHexaNoArquivo (arquivo, 0x90);
JZ escreverInstrucaoHexaNoArquivo (arquivo, 0xA0);
HLT escreverInstrucaoHexaNoArquivo (arquivo, 0xF0);
[0-9]+ {
    unsigned int numeroHex = strtol(yytext, NULL, 16);
    escreverInstrucaoHexaNoArquivo(arquivo, numeroHex);
}
<<EOF>> return 0;
%%

int main(int argc, char *argv[]){

	FILE *fin;
	arquivo = fopen("teste.mem", "w+b"); // Cria o arquivo se não existir
	if (arquivo != NULL) {
			printf("Arquivo criado com sucesso!\n");
			escreverNumeroHexaNoArquivo(arquivo, 0x03);
     	escreverNumeroHexaNoArquivo(arquivo, 0x4E);
			escreverNumeroHexaNoArquivo(arquivo, 0x44);
			escreverNumeroHexaNoArquivo(arquivo, 0x52);
	} else {
			printf("Não foi possível criar o arquivo.\n");
			return 1;
	}
	if (argc == 2) {
		if (fin = fopen(argv[1],"w"))
			yyin = fin;
		else
			perror(argv[0]);
	} else
		yyin = stdin;

	yylex ();
	return (0);
}