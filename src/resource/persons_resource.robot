# Todo esse aquivo é uma SUITE DE TESTE / SCRIPT DE TESTE

*** Settings ***
Library    RequestsLibrary
Library    String
Library    DateTime


*** Variables ***

@{bandeiras_validas}    Discover Card    Visa Retired    Visa    MasterCard  American Expres

*** Keywords ***

GET Person
    [Arguments]    ${quantidade}    ${gender}    ${birthday}
    Create Session    alias=faker_api    url=https://fakerapi.it/api/v1

    ${RESPONSE}    GET On Session    alias=faker_api    url=/persons?_quantity=${quantidade}&_gender=${gender}&_birthday_start=${birthday}
    
    Log To Console    ${RESPONSE.json()}

    [Return]    ${RESPONSE}

GET Person - Validação Quantidade
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

    ${var}    Set Variable    ${GET_RESPONSE.json()['total']}    
    Log To Console    ${GET_RESPONSE.json()['total']}

    ${var}    Convert To String    ${var}

    Should Be Equal    ${quantidade}    ${var}


GET Person - validação de data de nascimento
    [Arguments]    ${ano_escolhido}    ${quantidade}    ${GET_RESPONSE}

    FOR  ${i}  IN RANGE     ${quantidade}
        Log To Console    **** Elemento número ${i} ****

        ${data_completa}    Set Variable    ${GET_RESPONSE.json()['data'][${i}]['birthday']}    


        ${data}     Split String    ${data_completa}    -
        Log To Console    ${data}
        ${ano}    Set Variable    ${data}[0]
        
        IF    ${ano} >= ${ano_escolhido}
            Log To Console    ${data_completa} -> dentro do range
        ELSE
            Log To Console    Data fora do range
            Fail
        END
        

    END

GET Person - Validação de gênero
    [Arguments]    ${genero_escolhido}     ${quantidade}    ${GET_RESPONSE}

        FOR  ${i}  IN RANGE     ${quantidade}
        Log To Console    **** Elemento número ${i} ****

        ${genero}    Set Variable    ${GET_RESPONSE.json()['data'][${i}]['gender']}    
        Should Be Equal   ${genero}    ${genero_escolhido} 
        
    END

