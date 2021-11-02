*** Settings ***
Documentation  Operações que envolvem medidas de tempo.
Library  DateTime

*** Keywords ***
DateTime To Timestamp
    [Documentation]  Transforma DateTime em Timestamp (UNIX Epoch)
    [Arguments]  ${date}
    
    ${timestamp}  Set Variable   ${None}
    ${validDate}  Validate Date  ${date}
    
    IF  ${validDate}
        ${datetime}  Convert Date  ${date}  result_format=datetime
        
        # Lida com a limitação do SO para o cálculo de epochs das datas
        # anteriores a 1 de Janeiro de 1970, marco zero do sistema de
        # calendário utilizado pelo SO UNIX.
        # Referência: https://pt.wikipedia.org/wiki/Era_Unix
        IF  ${datetime.year} < 1970
            ${unixDateLimit}  Convert Date  1970-01-01 ${datetime.hour}:${datetime.minute}:${datetime.second}  result_format=datetime
            
            ${delta}  Subtract Date From Date  ${date}  ${unixDateLimit}
            
            ${unixEpochLimit}  Convert Date  ${unixDateLimit}  result_format=epoch
            
            ${timestamp}  Evaluate  ${delta} + ${unixEpochLimit}
        ELSE
            ${timestamp}  Convert Date  ${date}  result_format=epoch
        END

        # Normaliza o timestamp para o formato percebido
        # no JSON da response, adicionando três zeros e
        # removendo removendo o zero decimal.
        ${timestamp}  Evaluate  ${timestamp} * pow(10,3)
        ${timestamp}  Convert To Integer  ${timestamp}
    END

    [Return]  ${timestamp}

Calculate Age
    [Documentation]  Calcular a idade de alguém baseado na sua data de nascimento.
    [Arguments]  ${birthDate}

    ${age}  Set Variable  ${None}

    ${validDate}  Validate Date  ${birthDate}
    IF  ${validDate}
        ${birthDate}  Convert Date  ${birthDate}  result_format=datetime

        ${today}  Get Current Date  result_format=datetime

        ${delta}  Subtract Date From Date  ${today}  ${birthDate}

        # A keyword "Subtract Date From Date" retorna o resultado em
        # segundos. Por tanto, para obter o resultado em anos, este é
        # dividido por 31556952, que corresponde a um ano em segundos.
        ${age}  Evaluate  ${delta} / 31556952
        ${age}  Convert To Integer  ${age}
    END

    [Return]  ${age}

Validate Date
    [Arguments]  ${date}

    ${checkable}  Set Variable  ${date}
    ${checkable}  Convert To String  ${checkable}

    ${notNull}    Evaluate  ${true} if '${checkable}' != 'null' else ${false}
    ${notEmpty}   Evaluate  ${true} if '${checkable}' != 'None' else ${false}

    ${isValid}  Set Variable  ${false}

    IF  ${notNull} and ${notEmpty}
        ${isValid}  Set Variable  ${true}
    END

    [Return]  ${isValid}
