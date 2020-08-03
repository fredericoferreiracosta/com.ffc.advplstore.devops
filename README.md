# Compilação automática TOTVS Protheus

Este projeto contém exemplos de scripts para compilação automática de código (.prw ou .tlpp) no repositório de objetos do Protheus. Este exemplo foi montado usando a ferramenta de linha de comando do appserver (-compile) e script nativo do sistema operacional.

## Quick start

Edite o arquivo compile.bat (Windows) ou compile.sh (Linux) de acordo com o sistema operacional onde seu servidor Protheus está e então altere as seguintes variáveis:

* rootSrcFolder: Diretório principal onde está os fontes a serem compilados. Todos os subdiretórios também serão considerados na busca.
* rpo: Caminho completo do RPO a ser usado como template na compilação. Este RPO em si não será alterado, mas em toda compilação ele será duplicado e sua cópia receberá as atualizações.
* environment: Ambiente da compilação.
* appServer: Binário do TOTVS Application Server
* includeFolder: Pasta dos includes que será utilizado na compilação

No arquivo fileChangeDetector.bat ou fileChangeDetector.sh altere a seguinte variável:

* fileToMonitor: Este é o arquivo que irá nos informar quando trigar a compilação. Neste exemplo estamos usando o Git index que será alterado toda vez que um arquivo for estagiado, commits feitos, pull do servidor, etc.

Após este setup copie os arquivos para o servidor Protheus e inicie o arquivo fileChangeDetector.bat ou fileChangeDetector.sh via linha de comando e ele estará ouvindo as changes.

## Artefatos

* compile.bat: Este arquivo faz um hot swap no repositório de objetos do Protheus (atualizando o appserver.ini e tudo) e então compila os fontes neste novo repositório
* fileChangeDetector.bat: Este arquivo fica observando por alguma alteração no repositório Git e quando há alguma ele executa o arquivo compile.bat.

As versões Linux (compile.sh e fileChangeDetector.sh) é uma TODO task deste repositório. Fique a vontade para subir sua versão caso tenha conhecimento em Linux Scripting :smiley:

A pasta Examples são apenas programas de testes usados na criação deste repositório. Você não precisa mover seu código pra cá, apenas altere a variável rootSrcFolder no arquivo compile.bat apontando para o sua pasta raiz de fontes.

## Disclaimer

Este repositório é apenas um exemplo de como automatizar o processo de compilação do Protheus. Note que ele gera backups do arquivo appserver.ini e multiplica os RPOs do Protheus. Com o tempo isso pode sujar o seu servidor. Por isso é importante que você monitore a sua pasta "apo" e "appserver" e faça as devidas manutenções.

## TODOs
Melhorias para este framework

* Implementação dos scritps em Linux
* Execução de git pull automático
* Limpeza de repositórios antigos automático via novo script