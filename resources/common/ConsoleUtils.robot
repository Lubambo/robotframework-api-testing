*** Settings ***
Documentation  Utilities to interact with console.

*** Variables ***
${escape}  \\033
${resetColor}  [0;0m

### TAG NAMES
${alert}    ALERT
${error}    ERROR
${info}     INFO
${success}  SUCCESS
${warning}  WARN

### TEXT WEIGHTs
${regular}  [0;
${bold}     [1;

### COLORS
${red}           31m
${green}         32m
${yellow}        33m
${blue}          34m
${purple}        35m
${cyan}          36m
${white}         37m
${brightYellow}  93m 

### TAGS
&{TAG_ALERT}    name=${alert}    weight=${regular}  color=${yellow}
&{TAG_ERROR}    name=${error}    weight=${regular}  color=${red}
&{TAG_INFO}     name=${info}     weight=${regular}  color=${purple}
&{TAG_SUCCESS}  name=${success}  weight=${regular}  color=${green}
&{TAG_WARNING}  name=${warning}  weight=${regular}  color=${brightYellow}

*** Keywords ***
Mount tag
    [Arguments]  ${tag}
    ${result}  Evaluate  "[${escape}${tag.weight}${tag.color}${tag.name}${escape}${resetColor}]"
    [Return]  ${result}

Print console ALERT
    [Documentation]  Present on console a message with the tag "alert".
    ...              
    ...              Arguments:
    ...                 ${message}: message that will be presented.
    [Arguments]  ${message}

    ${tag}  Mount tag  ${TAG_ALERT}
    LOG TO CONSOLE  \n${tag} ${message}

Print console WARN
    [Documentation]  Present on console a message with the tag "alarm".
    ...              
    ...              Arguments:
    ...                 ${message}: message that will be presented.
    [Arguments]  ${message}

    ${tag}  Mount tag  ${TAG_WARNING}
    LOG TO CONSOLE  \n${tag} ${message}

Print console SUCCESS
    [Documentation]  Present on console a message with the tag "success".
    ...              
    ...              Arguments:
    ...                 ${message}: message that will be presented.
    [Arguments]  ${message}

    ${tag}  Mount tag  ${TAG_SUCCESS}
    LOG TO CONSOLE  \n${tag} ${message}

Print console INFO
    [Documentation]  Present on console a message with the tag "informative".
    ...              
    ...              Arguments:
    ...                 ${message}: message that will be presented.
    [Arguments]  ${message}

    ${tag}  Mount tag  ${TAG_INFO}
    LOG TO CONSOLE  \n${tag} ${message}

Print console ERROR
    [Documentation]  Present on console a message with the tag "erro".
    ...              
    ...              Arguments:
    ...                 ${message}: message that will be presented.
    [Arguments]  ${message}

    ${tag}  Mount tag  ${TAG_ERROR}
    LOG TO CONSOLE  \n${tag} ${message}