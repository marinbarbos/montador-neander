# montador-neander instruções

Projeto de Arquitetura e Organizacao de Computadores de um Montador Neander usando Flex

A ideia é conseguir pegar o arquico .asm e transformar em um .mem como nos arquivos de exemplo.

Pra abrir o neander-ex1.mem precisa de um editor de arquivo hex(hexed.it no browser ou algum outro local)

Vamos usar o Flex como compilador do nosso arquivo .l, onde temos a seção de regras(entre os %%) e a seção do código em C(depois do último %%), na seção de regras vamos querer colocar a leitura das strings correspondentes aos comandos em um buffer para escrever no arquivo binário .mem.

# Estrutura do binário para o Neander

```
Header (4 bytes): 03 4E 44 52
Para cada opcode, gravar mais um byte com 00
Ex: Instrução: LDA 80 (20 80)
Arquivo MEM: 20 00 80 00
Tamanho fixo de arquivo MEM: 516 bytes (4 do 
header e 512 das instrucoes/dados)
```

O arquivo não precisa obrigatoriamente ir até os 516 bytes pois o neander mesmo coloca valores 00 até preencher esse tamanho na hora da leitura.

Exemplos de asm(de cima, que nós escrevemos) para mem(de baixo, que o neander lê)

```
PROG1.MEM	PROG2.MEM	PROG3.MEM

LDA 80		LDA 80		LDA 80
ADD 81		AND 81		NOT
STA 82		STA 82		STA 81
HLT		LDA 80		HLT
		OR  81
		STA 83
		HLT

03 4E 44 52	03 4E 44 52	03 4E 44 52
20 00 80 00	20 00 80 00	20 00 80 00
30 00 81 00	50 00 81 00	60 00 10 00
10 00 82 00	10 00 82 00	81 00 F0 00
F0		20 00 80 00
		40 00 81 00
		10 00 83 00
		F0

```

# Rodar na máquina virtual do prof

Abaixo temos o readme do flex no windows xp, que pode ser rodado na virtual machine do professor

```
*Como Instalar:
-Execute "flex2541.exe"
-Coloque o caminho de instalacao para "C:\GnuWin32" e instale
-Copie o arquivo "C:\GnuWin32\lib\libfl.a" para "C:\Dev-Cpp\lib"
-Abra o DevCpp, Ferramentas -> Opções do Compilador
-Dentro da caixa "Adicionar os segn tes comandos quando chamar o compilador:" escreva "-lfl"

*Como utilizar:
(com o arquivo arq.l criado)
-Dentro de "C:\GnuWin32\bin" digitar: flex arq.l
-Irá gerar o arquivo "lex.yy.c"
-Vá até o "DevCpp" abra este arquivo
-Pressione F9 (equivale a Compilar/Executar)
```

Ainda não sei rodar no linux mas em um windows novo deve ser igual.

# Youtube

Abaixo também temos as instruções que o professor passou em aula

https://www.youtube.com/watch?v=s48kQK-LFT4

https://www.youtube.com/watch?v=GwtlzvTS2OU
