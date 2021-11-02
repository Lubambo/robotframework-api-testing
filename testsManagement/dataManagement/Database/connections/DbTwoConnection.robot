*** Settings ***
Documentation  Database Two connections params generetor.
Resource  ${EXECDIR}/resources/common/database/ConnectionMaker.robot

*** Keywords ***
Create Connection
    [Arguments]  ${baseConn}
    ${dbTwoConn}  Set Connection Params  ${baseConn}  ${project['database']['dbTwoUser']}
    ...                                 ${project['database']['dbTwoPass']}  ${project['database']['dbTwoName']}
    [Return]  ${dbTwoConn}