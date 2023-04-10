# robot -d ./results -L trace  .\src\tests\credit_card_test.robot

*** Settings ***
Resource    ../resource/credit_card_resource.robot

*** Variables ***

# Utilizado para escrever variáveis estáticas, xpath, variáveis globais

*** Test Cases ***
# Validação de data do cartão de Crédito
#     ${response}    GET Cartão de Crédito    quantidade=100
#     GET Cartão de Crédito - Validação data expiração    quantidade=100   GET_RESPONSE=${response}

Validação de bandeira do cartão de Crédito
    ${response}    GET Cartão de Crédito    quantidade=15
    GET Cartão de Crédito - Validação bandeira    quantidade=15   GET_RESPONSE=${response}
   
# Validação quantidade de elemementos
#     ${response}    GET Cartão de Crédito    quantidade=1
#     GET Cartão de Crédito - Validação Quantidade    quantidade=1    GET_RESPONSE=${response}

#     ${response}    GET Cartão de Crédito    quantidade=15
#     GET Cartão de Crédito - Validação Quantidade    quantidade=15    GET_RESPONSE=${response}

*** Keywords ***



