# Todo esse aquivo é uma SUITE DE TESTE / SCRIPT DE TESTE

*** Settings ***
Library    RequestsLibrary
Library    String
Library    DateTime


*** Variables ***

@{bandeiras_validas}    Discover Card    Visa Retired    Visa    MasterCard  American Expres

*** Keywords ***

GET Cartão de Crédito
    [Arguments]    ${quantidade}
    Create Session    alias=faker_api    url=https://fakerapi.it/api/v1

    ${RESPONSE}    GET On Session    alias=faker_api    url=/credit_cards?_quantity=${quantidade}
    
    # Log To Console    ${RESPONSE.json()}

    [Return]    ${RESPONSE}

GET Cartão de Crédito - Validação Quantidade
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

    ${var}    Set Variable    ${GET_RESPONSE.json()['total']}    
    Log To Console    ${GET_RESPONSE.json()['total']}

    ${var}    Convert To String    ${var}

    Should Be Equal    ${quantidade}    ${var}





GET Cartão de Crédito - Validação data expiração
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

    FOR  ${i}  IN RANGE     ${quantidade}
        Log To Console    **** Elemento número ${i} ****

        ${data_cartao}    Set Variable    ${GET_RESPONSE.json()['data'][${i}]['expiration']}    
        Log To Console    ${data_cartao}
        
        ${tempo}    Tempo de expiração    ${data_cartao}

    END

GET Cartão de Crédito - Validação bandeira
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

        FOR  ${i}  IN RANGE     ${quantidade}
        Log To Console    **** Elemento número ${i} ****

        ${bandeira_cartao}    Set Variable    ${GET_RESPONSE.json()['data'][${i}]['type']}    
        Log To Console    ${bandeira_cartao}

        Run Keyword And Continue On Failure    Should Contain Any    ${bandeira_cartao}    @{bandeiras_validas}
        
    END

Tempo de expiração    
    [Arguments]    ${cartao}
    
    ${date} =	Convert Date	${cartao}	date_format=%m/%y    exclude_millis=true
    # Log To Console    Data de expiração: ${date}
    ${date_now}    Get Current Date    time_zone=local    exclude_millis=true
    # Log To Console    Data hoje: ${date_now}

    ${time} =	Subtract Date From Date	    ${date}    ${date_now}    result_format=compact
    # Log To Console    ${time}

    IF  '- ' in '${time}'    
        Log To Console   Cartão -> ${cartao} já está expirado
        ${tempo}    Set Variable   ${time}

    ELSE
        Log To Console    Faltando ${time}    até o cartão expirar
        ${tempo}    Set Variable   ${time}
    END       


    [Return]    ${tempo} 