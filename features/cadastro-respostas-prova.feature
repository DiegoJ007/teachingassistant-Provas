Feature: Cadastro de respostas da prova
  Como um aluno de uma disciplina
  Eu quero preencher um formulário informando a avaliação, o número da minha prova e a soma das alternativas corretas de cada questão
  Para que minhas respostas sejam registradas de acordo com o meu tipo de prova

  Background:
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Formulário de Respostas"

  Scenario: Aluno seleciona a avaliação e o número da prova para exibir as questões no formulário
    Given a avaliação "1ª EE" está disponível com os números de prova "101" e "102" de "3" questões
    When eu seleciono a avaliação "1ª EE"
    And eu informo o número da prova "101"
    Then eu estou na página "Formulário de Respostas"
    And eu vejo a avaliação "1ª EE" e o número da prova "101" selecionados no formulário
    And eu vejo os campos de soma para a "Questão 1", a "Questão 2" e a "Questão 3"

  Scenario: Aluno preenche e envia as somas de todas as questões de um tipo de prova com sucesso
    Given eu selecionei a avaliação "1ª EE" e o número da prova "101" com "3" questões
    When eu preencho a soma "21" para a "Questão 1"
    And eu preencho a soma "10" para a "Questão 2"
    And eu preencho a soma "33" para a "Questão 3"
    And eu seleciono a opção "Finalizar Prova"
    And eu seleciono a opção "Confirmar Envio"
    Then eu vejo a mensagem "Respostas enviadas com sucesso"
    And eu vejo o comprovante da avaliação "1ª EE" para a prova "101" com as somas "21", "10" e "33" nas questões "Questão 1", "Questão 2" e "Questão 3"

  Scenario: Aluno altera a soma de uma questão no formulário antes de confirmar o envio
    Given eu selecionei a avaliação "2ª EE" e o número da prova "202" com "2" questões
    And eu preenchi a soma "12" para a "Questão 1"
    And eu preenchi a soma "5" para a "Questão 2"
    When eu altero a soma da "Questão 1" para "19"
    Then eu vejo a soma "19" preenchida na "Questão 1"
    And eu vejo a soma "5" preenchida na "Questão 2"

  Scenario: Aluno cancela a confirmação de envio e mantém as somas preenchidas
    Given eu selecionei a avaliação "1ª EE" e o número da prova "101" com "2" questões
    And eu preenchi a soma "21" para a "Questão 1"
    And eu preenchi a soma "10" para a "Questão 2"
    When eu seleciono a opção "Finalizar Prova"
    And eu seleciono a opção "Cancelar Envio"
    Then eu permaneço na página "Formulário de Respostas"
    And eu vejo a soma "21" preenchida na "Questão 1"
    And eu vejo a soma "10" preenchida na "Questão 2"

  Scenario: Sistema mantém separadas as respostas de avaliações diferentes
    Given eu já enviei o formulário da avaliação "1ª EE" para o número da prova "101" com a soma "21" na "Questão 1"
    When eu seleciono a avaliação "2ª EE"
    And eu informo o número da prova "202"
    And eu preencho a soma "36" para a "Questão 1"
    And eu seleciono a opção "Finalizar Prova"
    And eu seleciono a opção "Confirmar Envio"
    Then eu vejo a mensagem "Respostas enviadas com sucesso"
    And eu vejo o comprovante da avaliação "2ª EE" para a prova "202" com a soma "36" na "Questão 1"
    And o comprovante da avaliação "1ª EE" para a prova "101" mantém a soma "21" na "Questão 1"

  Scenario: Aluno envia o formulário deixando uma questão sem soma preenchida
    Given eu selecionei a avaliação "1ª EE" e o número da prova "101" com "3" questões
    When eu preencho a soma "21" para a "Questão 1"
    And eu deixo a "Questão 2" sem soma preenchida
    And eu preencho a soma "33" para a "Questão 3"
    And eu seleciono a opção "Finalizar Prova"
    And eu seleciono a opção "Confirmar Envio"
    Then eu vejo a mensagem "Respostas enviadas com sucesso"
    And eu vejo o comprovante da avaliação "1ª EE" para a prova "101" com as somas "21", "0" e "33" nas questões "Questão 1", "Questão 2" e "Questão 3"

  Scenario Outline: Aluno envia somas nos valores limítrofes válidos de 0 e 63 (Caso Limítrofe)
    Given eu selecionei a avaliação "1ª EE" e o número da prova "101" com "1" questões
    When eu preencho a soma "<soma>" para a "Questão 1"
    And eu seleciono a opção "Finalizar Prova"
    And eu seleciono a opção "Confirmar Envio"
    Then eu vejo a mensagem "Respostas enviadas com sucesso"
    And eu vejo o comprovante da avaliação "1ª EE" para a prova "101" com a soma "<soma>" na "Questão 1"

  Scenario: Aluno tenta enviar o formulário sem informar o número da prova (Caso de Falha)
    Given a avaliação "1ª EE" está disponível com os números de prova "101" e "102"
    When eu seleciono a avaliação "1ª EE"
    And eu não informo o número da prova
    And eu seleciono a opção "Finalizar Prova"
    Then eu vejo uma mensagem de erro informando que o número da prova é obrigatório
    And eu permaneço na página "Formulário de Respostas"

  Scenario: Aluno tenta informar um número de prova inexistente para a avaliação selecionada (Caso de Falha)
    Given a avaliação "1ª EE" possui apenas os números de prova "101" e "102" cadastrados
    When eu seleciono a avaliação "1ª EE"
    And eu informo o número da prova "999"
    Then eu vejo uma mensagem de erro informando que o número da prova "999" não é válido para a avaliação "1ª EE"
    And eu permaneço na página "Formulário de Respostas"

  Scenario Outline: Aluno tenta preencher uma soma fora do intervalo de 0 a 63 (Caso de Falha)
    Given eu selecionei a avaliação "1ª EE" e o número da prova "101" com "2" questões
    When eu preencho a soma "<soma>" para a "Questão 1"
    And eu preencho a soma "10" para a "Questão 2"
    And eu seleciono a opção "Finalizar Prova"
    Then eu vejo uma mensagem de erro informando que a soma da "Questão 1" deve ser um valor entre "0" e "63"
    And eu permaneço na página "Formulário de Respostas"
