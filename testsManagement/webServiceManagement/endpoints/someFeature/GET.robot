*** Setting ***
Documentation  GET request endpoints manager.
Resource       ../Standard.robot

*** Keywords ***
GET: Features
    [Return]  /${SOME_FEATURE}

GET: Feature by id
    [Arguments]  ${id}
    [Return]  /${SOME_FEATURE}/${id}
