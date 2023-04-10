# robot -d ./results -L trace  .\src\tests\companies_test.robot

*** Settings ***
Resource    ../resource/companies_resource.robot

*** Variables ***

# Utilizado para escrever variáveis estáticas, xpath, variáveis globais

*** Test Cases ***

Validação Quantidade de endereços a Empresa possui
    ${response}    GET Empresa    quantidade=20
    GET Empresa - Validação Endereços    quantidade=20   GET_RESPONSE=${response}
    
Validação quantidade de elemementos
    ${response}    GET Empresa    quantidade=1
    GET Empresa - Validação Quantidade    quantidade=1    GET_RESPONSE=${response}

    ${response}    GET Empresa    quantidade=15
    GET Empresa - Validação Quantidade    quantidade=15    GET_RESPONSE=${response}

*** Keywords ***



