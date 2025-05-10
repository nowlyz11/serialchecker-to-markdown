# Coletor de Informações de Hardware (Script Batch)

Este script Batch (`.bat`) foi projetado para coletar uma variedade de informações de hardware e sistema de uma máquina Windows. A saída é formatada em um arquivo Markdown (`.md`) para facilitar a leitura e a organização.

## Funcionalidades

* Coleta informações detalhadas sobre diversos componentes de hardware e do sistema operacional.
* Salva o relatório em um arquivo Markdown (`hardware_info.md`) no mesmo diretório onde o script é executado.
* Organiza as informações em seções claras e legíveis.
* Utiliza comandos nativos do Windows como `wmic`, `getmac` e `mountvol`.

## Informações Coletadas

O script coleta as seguintes categorias de informações:

* **Informações do Sistema Operacional:** Versão, arquitetura, nome do computador, data de instalação, último boot, dispositivo de boot.
* **UUID do Produto do Sistema (CSProduct):** Identificador único do sistema.
* **Informações da BIOS:** Fabricante, nome, número de série, versão SMBIOS, data de lançamento.
* **Informações da Placa-mãe (Baseboard):** Produto, fabricante, número de série, versão.
* **Informações do Processador (CPU):** Nome, fabricante, ID do processador, velocidade máxima, número de núcleos e processadores lógicos, cache L2/L3.
* **Informações da Memória Física (RAM):**
    * **Módulos de Memória:** Rótulo do banco, capacidade, número da peça, número de série, velocidade, fabricante, tipo de memória, fator de forma.
    * **Capacidade Total e Slots:** Capacidade máxima suportada, número de dispositivos de memória.
* **Informações dos Adaptadores de Vídeo (GPU):** Nome, compatibilidade do adaptador, RAM do adaptador, versão do driver, ID PNP do dispositivo, processador de vídeo, descrição do modo de vídeo, resolução atual.
* **Informações dos Discos Físicos (HDD/SSD):** Modelo, número de série, ID PNP do dispositivo, tipo de interface, tamanho, partições, tipo de mídia, revisão do firmware.
* **Informações das Partições Lógicas:** ID do dispositivo (letra da unidade), nome do volume, sistema de arquivos, tamanho total, espaço livre, número de série do volume.
* **GUIDs de Volume:**
    * Saída do comando `mountvol`.
    * Informações de Volume WMI (DeviceID, DriveLetter, Label, FileSystem, SerialNumber, Capacity, FreeSpace).
* **Informações dos Adaptadores de Rede:**
    * Endereços MAC e detalhes da conexão (via `getmac`).
    * Nome, endereço MAC, tipo de adaptador, ID PNP do dispositivo, ID da conexão de rede, velocidade, fabricante (via `wmic nic`).
* **Informações de Dispositivos de Som:** Nome, fabricante, ID PNP do dispositivo, status.
* **Monitores:** Nome, ID PNP do dispositivo, altura e largura da tela.
* **Dispositivos USB Conectados:** IDs de dispositivos dependentes (informação básica).

## Como Usar

1.  **Download/Cópia:**
    * Baixe o arquivo `.bat` ou copie o código para um novo arquivo de texto.
    * Se estiver copiando, salve o arquivo com a extensão `.bat`.

2.  **Execução:**
    * Navegue até a pasta onde você salvou o arquivo `.bat`.
    * **Recomendado:** Execute o script como administrador para garantir que todas as informações possam ser acessadas. Para fazer isso, clique com o botão direito no arquivo `.bat` e selecione "Executar como administrador".
    * Se não for executado como administrador, algumas informações (especialmente números de série de baixo nível ou UUIDs) podem não ser coletadas.
    * O script exibirá uma mensagem "Coletando informacoes de hardware... Por favor, aguarde."

3.  **Verificar a Saída:**
    * Após a conclusão, uma mensagem "Coleta de informacoes concluida!" será exibida.
    * Um arquivo chamado `hardware_info.md` será criado no mesmo diretório do script.
    * Abra este arquivo com qualquer editor de texto ou visualizador de Markdown (por exemplo, VS Code, Typora, ou diretamente no GitHub).

4. **Como ver o markdown ja formatado?**
    * Acesse o site https://markdownlivepreview.com/
    * Cole o que esta dentro do arquivo .md, para o site.

## Requisitos

* **Sistema Operacional:** Windows (testado em versões mais recentes, mas deve funcionar em muitas versões que suportam `wmic`).
* **Permissões:** Recomenda-se execução como administrador para acesso completo aos dados de hardware.

## Formato da Saída

O script gera um arquivo `hardware_info.md` com a seguinte estrutura (exemplo simplificado):

```markdown
# RELATÓRIO DE INFORMAÇÕES DE HARDWARE E SISTEMA
---
**Data e Hora da Coleta:** DD/MM/AAAA HH:MM:SS,MS
**Computador:** NOME_DO_COMPUTADOR
**Usuário:** NOME_DO_USUARIO
---

## [Informacoes do Sistema Operacional]

` ``text
Caption=Microsoft Windows 10 Pro
Version=10.0.19045
...
` ``

## [Informacoes da BIOS]

` ``text
Manufacturer=Dell Inc.
SerialNumber=XXXXXXX
...
` ``
