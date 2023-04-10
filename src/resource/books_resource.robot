# Todo esse aquivo é uma SUITE DE TESTE / SCRIPT DE TESTE

*** Settings ***
Library    RequestsLibrary
Library    String


*** Variables ***

# Utilizado para escrever variáveis estáticas, xpath, variáveis globais

*** Keywords ***

GET Livro
    [Arguments]    ${quantidade}
    Create Session    alias=faker_api    url=https://fakerapi.it/api/v1

    ${RESPONSE}    GET On Session    alias=faker_api    url=/books?_quantity=${quantidade}
    
    Log To Console    ${RESPONSE.json()}

    [Return]    ${RESPONSE}

GET Livro - Validação Quantidade
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

    ${var}    Set Variable    ${GET_RESPONSE.json()['total']}    
    Log To Console    ${GET_RESPONSE.json()['total']}

    ${var}    Convert To String    ${var}

    Should Be Equal    ${quantidade}    ${var}

GET Livro - Validação Data    
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

    FOR  ${i}  IN RANGE     ${quantidade}
        Log To Console    **** Elemento número ${i} ****
        # Log To Console    ${GET_RESPONSE.json()['data'][${i}]} 

        ${data}    Set Variable    ${GET_RESPONSE.json()['data'][${i}]['published']}    
        Log To Console    ${GET_RESPONSE.json()['data'][${i}]['published']}

        ${ano}    ${mes}    ${dia}    Separação Data Livro   ${data} 

        Log To Console    Publicado no dia ${dia} do mês ${mes} e ano de ${ano}

    END

Separação Data Livro   
    [Arguments]    ${data} 

    @{words}    Split String    ${data}  -
    Log To Console   ${words}
    ${ano}  Set Variable    ${words}[0]
    ${mes}  Set Variable    ${words}[1]
    ${dia}  Set Variable    ${words}[2]

    [Return]       ${ano}    ${mes}    ${dia}