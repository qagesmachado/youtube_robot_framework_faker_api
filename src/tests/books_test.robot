# robot -d ./results -L trace  .\src\tests\books_test.robot

*** Settings ***
Resource    ../resource/books_resource.robot

*** Variables ***

# Utilizado para escrever variáveis estáticas, xpath, variáveis globais

*** Test Cases ***

Validação Data de lançamento livro
    ${response}    GET Livro    quantidade=15
    GET Livro - Validação Data    quantidade=15    GET_RESPONSE=${response}
    
Validação quantidade de elemementos
    ${response}    GET Livro    quantidade=15
    GET Livro - Validação Quantidade    quantidade=15   GET_RESPONSE=${response}

*** Keywords ***



