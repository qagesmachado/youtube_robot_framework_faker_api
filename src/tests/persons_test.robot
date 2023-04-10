# robot -d ./results -L trace  .\src\tests\persons_test.robot

*** Settings ***
Resource    ../resource/persons_resource.robot

*** Variables ***

# Utilizado para escrever variáveis estáticas, xpath, variáveis globais

*** Test Cases ***

Validação de Gênero
    ${response}    GET Person    quantidade=5    gender=male    birthday=1994-01-13
    GET Person - Validação de gênero    genero_escolhido=male    quantidade=5   GET_RESPONSE=${response}

Validação de idade
    ${response}    GET Person    quantidade=100    gender=male    birthday=2005-01-13
    GET Person - validação de data de nascimento    ano_escolhido=2005    quantidade=100   GET_RESPONSE=${response}
   
Validação quantidade de elemementos
    ${response}    GET Person    quantidade=1    gender=male    birthday=2005-01-13
    GET Person - Validação Quantidade    quantidade=1    GET_RESPONSE=${response}

    ${response}    GET Person    quantidade=15    gender=male    birthday=2005-01-13
    GET Person - Validação Quantidade    quantidade=15    GET_RESPONSE=${response}

*** Keywords ***



