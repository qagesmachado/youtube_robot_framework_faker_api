# Todo esse aquivo é uma SUITE DE TESTE / SCRIPT DE TESTE

*** Settings ***
Library    RequestsLibrary
Library    String


*** Variables ***

# Utilizado para escrever variáveis estáticas, xpath, variáveis globais

*** Keywords ***

GET Empresa
    [Arguments]    ${quantidade}
    Create Session    alias=faker_api    url=https://fakerapi.it/api/v1

    ${RESPONSE}    GET On Session    alias=faker_api    url=/companies?_quantity=${quantidade}
    
    # Log To Console    ${RESPONSE.json()}

    [Return]    ${RESPONSE}

GET Empresa - Validação Quantidade
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

    ${var}    Set Variable    ${GET_RESPONSE.json()['total']}    
    Log To Console    ${GET_RESPONSE.json()['total']}

    # ${var}    Convert To String    ${var}
    ${quantidade}    Convert To Integer    ${quantidade}

    Should Be Equal    ${quantidade}    ${var}

GET Empresa - Validação Endereços    
    [Arguments]    ${quantidade}    ${GET_RESPONSE}

    FOR  ${i}  IN RANGE     ${quantidade}
        Log To Console    **** Elemento número ${i} ****
        # Log To Console    ${GET_RESPONSE.json()['data'][${i}]} 

        ${address}    Set Variable    ${GET_RESPONSE.json()['data'][${i}]['addresses']}    
        # Log To Console    ${GET_RESPONSE.json()['data'][${i}]['addresses']}
        
        ${address_str}  Convert To String  ${address}
        ${count}    Get Count    ${address_str}    'zipcode':
        Log To Console    Possui ${count} endereços

        FOR    ${j}  IN RANGE     ${count}
            Log To Console    **** Endereço número ${j} do elemento ${i}****

            Log To Console    ${GET_RESPONSE.json()['data'][${i}]['addresses'][${j}]}

        END

    END
