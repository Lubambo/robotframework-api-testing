*** Settings ***
Documentation  Biblioteca Utils.

Resource  ${EXECDIR}/resources/common/ConsoleUtils.robot
Resource  ${EXECDIR}/resources/common/Utils.robot

*** Variables ***
# Valores especiais do Robot Framework: SYSTEM, CONSOLE
${SAVING_ENCODING}   Windows-1252
${READING_ENCODING}  SYSTEM

*** Keywords ***
Save CSV test data file
    [Documentation]  Formata o modelo CSV padrão para o modelo exigido pela
    ...              bilioteca DataDriver, onde o cabeçalho do arquivo possui
    ...              os itens no formato de variável robot: ${item}.
    ...              
    ...              Argumentos:
    ...                 ${filename}: caminho onde o arquivo será salvo;
    ...
    ...                 ${columns}: lista dos itens usados como cabeçalho do CSV;
    ...
    ...                 @{rows}: lista com os valores de cada coluna;
    ...
    ...                 ${delimiter}: delimitador de itens do CSV.

    [Arguments]  ${filename}  ${columns}  @{rows}  ${delimiter}=;
    
    ${headers}  Create List  @{EMPTY}

    FOR  ${column}  IN  @{columns}
        # Remove tudo que vem antes do alias da coluna.
        # Ex.:
        # - Nome da coluna na query: CASE WHEN ***** END AS ALIAS
        # - String a ser removida: [CASE WHEN ***** END AS ]
        # - String desejada: [ALIAS]
        ${regexColAlias}  Set Variable  ( AS )(.+)$
        ${matches}  Get Regexp Matches  ${column}  ${regexColAlias}  1  2
        
        IF  ${matches} != []
            ${column}  Set Variable  ${matches}[0][1]
        END

        # Remove alias da tabela.
        # Ex.:
        # - Nome da coluna na query: alias.COLUNA
        # - String a ser removida: [alias.]
        # = String desejada: [COLUNA]
        ${regexTableAlias}  Set Variable  ^([a-zA-Z]+[^a-zA-Z_]{1})[a-zA-Z]+$
        ${matches}  Get Regexp Matches  ${column}  ${regexTableAlias}  1
        
        IF  ${matches} != []
            ${tableAlias}  Set Variable  ${matches}[0]
            ${tableAliasLength}  Get Length  ${tableAlias}
            ${colLength}  GetLength  ${column}
            ${column}  Get Substring  ${column}  ${tableAliasLength}  ${colLength}
        END

        ${header}  Catenate  SEPARATOR=  \$  \{  ${column}  \}
        Append To List  ${headers}  ${header}
    END

    ${content}  Evaluate  "${delimiter}".join(${headers})
    ${content}  Catenate  SEPARATOR=  ${content}  \n

    FOR  ${row}  IN  @{rows}
        ${record}  Convert To List  ${row}

        ${record}  Evaluate  "${delimiter}".join(str(e) for e in ${record})

        # Substitui qualquer registro da palavra None pela variável nativa do
        # robot framework ${None}. Isso evita problema com inserção indesejada
        # de áspas no JSON para propriedades com valor None.
        ${regex}     Set Variable  None
        ${replacer}  Catenate  SEPARATOR=  \${  None  }
        ${record}    Replace String Using Regexp  ${record}  ${regex}  ${replacer}

        ${content}  Catenate  SEPARATOR=  ${content}  ${record}  \n
    END
    
    Create File  ${filename}  ${content}  encoding=${SAVING_ENCODING}

    [Return]  ${content}

Read Test Data File
    ${content}  Get File  ${project['testData']['filePath']}  encoding=${READING_ENCODING}
    [Return]  ${content}

Remove Test Data File
    Remove File  ${project['testData']['filePath']}