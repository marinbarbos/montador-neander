%{

// FILE *arquivo;
unsigned char buffer[516] = {0x03, 0x4E, 0x44, 0x52};
int currSize = 4;

int yywrap(){return(1);}

// void escreverNumeroHexaNoArquivo(FILE *arquivo, unsigned int numeroHex) {
// 	unsigned char byte = numeroHex & 0xFF;
// 	size_t elementosEscritos = fwrite(&byte, sizeof(unsigned char), 1, arquivo);
// }

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

// void escreverInstrucaoHexaNoArquivo(FILE *arquivo, unsigned int numero) {
//     if (arquivo != NULL) {
// 			escreverNumeroHexaNoArquivo(arquivo, numero);
// 			escreverNumeroHexaNoArquivo(arquivo, 0);
// 			printf("%x %x0", numero, 0);
//     }
// }

%}

%%
NOP addToBuffer(0x00);//escreverInstrucaoHexaNoArquivo (arquivo, 0x0);
STA addToBuffer(0x10);//escreverInstrucaoHexaNoArquivo (arquivo, 0x10);
LDA addToBuffer(0x20);//escreverInstrucaoHexaNoArquivo (arquivo, 0x20);
ADD addToBuffer(0x30);//escreverInstrucaoHexaNoArquivo (arquivo, 0x30);
OR  addToBuffer(0x40);//escreverInstrucaoHexaNoArquivo (arquivo, 0x40);
AND addToBuffer(0x50);//escreverInstrucaoHexaNoArquivo (arquivo, 0x50);
NOT addToBuffer(0x60);//escreverInstrucaoHexaNoArquivo (arquivo, 0x60);
JMP addToBuffer(0x80);//escreverInstrucaoHexaNoArquivo (arquivo, 0x80);
JN  addToBuffer(0x90);//escreverInstrucaoHexaNoArquivo (arquivo, 0x90);
JZ  addToBuffer(0xA0);//escreverInstrucaoHexaNoArquivo (arquivo, 0xA0);
HLT addToBuffer(0xF0);//escreverInstrucaoHexaNoArquivo (arquivo, 0xF0);
[0-9]+ {
    unsigned int numeroHex = strtol(yytext, NULL, 16);
    addToBuffer(numeroHex);
	//escreverInstrucaoHexaNoArquivo(arquivo, numeroHex);
}
<<EOF>> return 0;
%%

int main(int argc, char *argv[]){

	FILE *fin;
	FILE* arquivo;
	arquivo = fopen("teste.mem", "w+b"); // Cria o arquivo se não existir
	if (arquivo != NULL) {
			printf("Arquivo criado com sucesso!\n");
			// escreverNumeroHexaNoArquivo(arquivo, 0x03);
     	// escreverNumeroHexaNoArquivo(arquivo, 0x4E);
			// escreverNumeroHexaNoArquivo(arquivo, 0x44);
			// escreverNumeroHexaNoArquivo(arquivo, 0x52);
	} else {
			printf("Não foi possível criar o arquivo.\n");
			return 1;
	}
	// printf("%s", buffer);
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