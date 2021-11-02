*** Settings ***
Documentation  Utils lib.

Resource  ./ConsoleUtils.robot

Library  OperatingSystem
Library  Collections
Library  String
Variables  ${EXECDIR}/resources/locators.py

*** Keywords ***
Convert CSV into List of Lists
    [Arguments]  ${csvContent}  ${separator}=;
    
    @{csvLines}  Split To Lines  ${csvContent}

    ${formatedList}  Create List  @{EMPTY}
    FOR  ${line}  IN  @{csvLines}
        ${data}  Split String  ${line}  separator=${separator}
        Append To List  ${formatedList}  ${data}
    END

    [Return]  ${formatedList}

Convert CSV into Dictionary
    [Arguments]  ${csvContent}  ${separator}=;
    
    ${fileLists}  Convert CSV into List of Lists  ${csvContent}  ${separator}

    @{keys}  Remove From List  ${fileLists}  0

    ${result}  Create Dictionary  &{EMPTY}

    FOR  ${key}  IN  @{keys}
        Set To Dictionary  ${result}  ${key}=@{EMPTY}
    END

    FOR  ${index}  ${key}  IN ENUMERATE  @{keys}
        FOR  ${i}  ${item}  IN ENUMERATE  @{fileLists}
            ${valueFromDict}  Get From Dictionary  ${result}  ${key}
            ${valueFromList}  Get From List  ${item}  ${index}
            
            Append To List  ${valueFromDict}  ${valueFromList}
            Set To Dictionary  ${result}  ${key}=${valueFromDict}
        END
    END

    [Return]  ${result}

Convert List of Lists into Dictionary
    [Arguments]  ${keys}  ${content}

    ${result}  Create Dictionary  &{EMPTY}

    FOR  ${key}  IN  @{keys}
        Set To Dictionary  ${result}  ${key}=@{EMPTY}
    END

    FOR  ${index}  ${key}  IN ENUMERATE  @{keys}
        FOR  ${i}  ${item}  IN ENUMERATE  @{content}
            ${valueFromDict}  Get From Dictionary  ${result}  ${key}
            ${valueFromList}  Get From List  ${item}  ${index}
            
            Append To List  ${valueFromDict}  ${valueFromList}
            Set To Dictionary  ${result}  ${key}=${valueFromDict}
        END
    END

    [Return]  ${result}

Convert String To Bytes And Decode
    [Arguments]  ${string}  ${encoding}=utf-8
    
    ${bytes}     Convert To Bytes  ${string}
    ${decoded}   Decode Bytes To String  ${bytes}  ${encoding}

    [Return]  ${decoded}

Check Operating System and Decode String
    [Documentation]  Manage the enconding that the string should contains according to
    ...              the Operational System where the project is.
    ...              
    ...              Arguments:
    ...                 ${string}: string that will or not be decoded;
    ...              
    ...                 ${decodeIfOs}: the string will be decoded only if the OS that is
    ...                                running the project is the same informed in this
    ...                                parameter.
    ...                                Standard value: Linux.

    [Arguments]  ${string}  ${decodeIfOs}=Linux  ${encoding}=utf-8

    ${os}  Evaluate  platform.system()  platform
    ${decoded}  Set Variable  ${string}
    
    IF  '${os}' == '${decodeIfOs}'
        ${decoded}  Convert String To Bytes And Decode  ${string}  ${encoding}
    END

    [Return]  ${decoded}
