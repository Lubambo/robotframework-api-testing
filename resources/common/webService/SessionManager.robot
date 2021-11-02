*** Settings ***
Library     RequestsLibrary

*** Keywords ***
Open Session REST
    [Arguments]  ${url}  ${alias}
    CREATE SESSION  url=${url}  alias=${alias}

Close Session REST
    DELETE ALL SESSIONS