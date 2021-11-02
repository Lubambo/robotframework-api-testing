*** Settings ***
Documentation  Resource that is used by more than one test file from some_spec.

*** Keywords ***
Class Like Mounter
    [Documentation]  Emulates a class using a dictionary, to ease data management.
    [Arguments]  ${response}  ${value1}  ${value2}

    ${propOne}  Convert To Integer  ${value1}
    ${propTwo}  Method Like         ${value2}

    ${obj}  Create Dictionary  propOne=${propOne}  propTwo=${propTwo}

    [return]  ${obj}

Method Like
    [Documentation]  Manage value.
    [Arguments]  ${value}

    ${result}  Set Variable  ${value}

    [Return]  ${result}
