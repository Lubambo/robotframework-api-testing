*** Settings ***
Documentation  Roteador de criação de parâmetros de conexão com os bancos de dados.

Resource  ./connections/DbOneConnection.robot
Resource  ./connections/DbTwoConnection.robot
Resource  ${EXECDIR}/resources/common/database/ConnectionsRouter.robot

Library  Collections

*** Keywords ***
Create Database Connection Params
    ${dbConn}  Create Base Connection  apiModule=${project['database']['dbApi']}
    ...            service=${project['database']['dbService']}
    ...            host=${project['database']['dbHost']}
    ...            port=${project['database']['dbPort']}
    [Return]  ${dbConn}

Set Database Connection
    [Arguments]  ${dbName}

    # Create the base connection params.
    ${dbConn}  Create Database Connection Params

    # Create DatabaseOne connection params.
    ${dbOne}      DbOneConnection.Create Connection  ${dbConn}

    # Create a dictionary that will keep the database connection.
    &{dbOptions}  Create Dictionary  dbOne=&{dbOne}
    
    # If there is more than database connection, create them and
    # add to the connections dictionary keeper.
    &{dbTwo}      DbTwoConnection.Create Connection  ${dbConn}
    Set To Dictionary  ${dbOptions}  dbTwo=&{dbTwo}

    # Manage what database connection will be used according to the
    # database name informed. 
    ${params}     Get DB Connection Params  ${dbName}  &{dbOptions}

    [Return]  ${params}
