*** Settings ***
Documentation  Database One connections params generetor.
Resource  ${EXECDIR}/resources/common/database/ConnectionMaker.robot

*** Keywords ***
Create Connection
    [Arguments]  ${baseConn}
    ${dbOneConn}  Set Connection Params  ${baseConn}  ${project['database']['dbOneUser']}
    ...                                 ${project['database']['dbOnePass']}  ${project['database']['dbOneName']}
    
    [Return]  ${dbOneConn}