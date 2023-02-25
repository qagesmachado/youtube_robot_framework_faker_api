# robot -d ./results -L trace  .\src\tests\books_test.robot

*** Settings ***
Resource    ../resource/books_resource.robot

*** Variables ***

# Utilizado para escrever variáveis estáticas, xpath, variáveis globais

*** Test Cases ***

Validação Data de lançamento livro
    ${response}    GET Livro    quantidade=1
    GET Livro - Validação Data    quantidade=1    GET_RESPONSE=${response}
    


*** Keywords ***



