*** Settings ***
Documentation  Doc.

Resource  ${EXECDIR}/resources/common/webService/SessionManager.robot

Variables   ${EXECDIR}/resources/locators.py

*** Keywords ***
Open Session
    CREATE SESSION  url=${project['api']['apiHost']}  alias=${project['api']['apiAlias']}

Close Session
    Close Session REST
