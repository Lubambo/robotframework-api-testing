*** Settings ***
Documentation  Gerenciamento de interação com o banco de dados.
Resource  ./FileManager.robot
Resource  ./Database/ConnectionsRouter.robot
Resource  ${EXECDIR}/resources/common/database/DatabaseManager.robot

*** Variables ***
# Standard database, so it is not necessary to set in every test spec.
${standardDb}  ${project['database']['dbOneName']}

*** Keywords ***
Query and record test data
    [Documentation]  Solicita ao banco de dados os dados de testes utilizando
    ...              os parâmetros informados no argumento 'sqlSetup' e grava
    ...              o resultado obtido dentro de um arquivo CSV no formato
    ...              esperado pela biblioteca DataDriver.
    [Arguments]  ${sqlSetup}

    ${result}  Query through SQL script  ${sqlSetup}

    ${testDataFile}  Set Variable  ${project['testData']['filePath']}
    Save CSV test data file  ${testDataFile}  ${sqlSetup.columns}  @{result}  delimiter=\t

Update DataDriver
    [Documentation]  Atualiza o DataDriver antes do teste ser iniciado.
    ...              Permitindo que cada teste tenha seu próprio arquivo de teste.
    ...              https://github.com/Snooz82/robotframework-datadriver#configure-datadriver-by-pre-run-keyword.
    ...
    ...              Argumentos:
    ...                 ${original_config}: Argumento obrigatório da biblioteca DataDriver.
    ...                                     Carrega as definições da DataDriver;
    ...
    ...                 ${sqlSetup}: Argumento obrigatório, embora não possa ser forçado
    ...                              devido a limitação do parâmetro config_keyword.
    ...                              Informa os parâmetros utilizados na requisição ao Banco de dados.

    [Arguments]  ${original_config}

    ${sqlSetup}  Stardard database connection check  ${sqlSetup}

    # If the dbName is passed as None, the script will use the file path stated in sqlSetup.file.
    # It is mandatory to state the file path if dbName value it is None.
    IF  '${sqlSetup.dbName}' == '${None}'
        ${new_config}  Create Dictionary  file=${sqlSetup.file}  dialect=UserDefined  delimiter=\t  escapechar=\  quotechar='
    ELSE
        ${connParams}  Set DB Connection Params  ${sqlSetup.dbName}

        Set To Dictionary  ${sqlSetup}  connParams=${connParams}
        
        Query and record test data  ${sqlSetup}
        ${testDataFile}  Set Variable  ${project['testData']['filePath']}
        ${new_config}  Create Dictionary  file=${testDataFile}  dialect=UserDefined  delimiter=\t  escapechar=\  quotechar='
    END

    [Return]  ${new_config}

Stardard database connection check
    [Documentation]  If your there is a standard database connections, this verification
    ...              guarantees that it will be setted in case no database are specified.
    [Arguments]  ${sqlSetup}

    ${updatedSetup}  Set Variable  ${sqlSetup}

    IF  "dbName" not in ${sqlSetup}
        Set To Dictionary  ${updatedSetup}  dbName=${standardDb}
    END

    [Return]  ${updatedSetup}