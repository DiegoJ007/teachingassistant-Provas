Feature: Cadastro de respostas da prova
  Como um aluno de uma disciplina
  Eu quero preencher o formulário da avaliação informando o tipo da minha prova e a soma das proposições corretas de cada questão
  Para que minhas respostas sejam submetidas para correção de acordo com o gabarito do meu tipo de prova e minha nota seja calculada

  # ===========================================================================
  # Cenários de Interface (GUI)
  # ===========================================================================

  Scenario: Aluno acessa o formulário de respostas de uma avaliação disponível
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Provas Disponíveis"
    And eu vejo a avaliação "1ª EE" com o status "Disponível"
    When eu seleciono a avaliação "1ª EE"
    Then eu estou na página "Formulário da 1ª EE"
    And eu vejo o campo "Tipo da Prova" vazio
    And eu vejo o campo "Questão 1" vazio
    And eu vejo o campo "Questão 2" vazio
    And eu vejo o campo "Questão 3" vazio

  Scenario: Aluno altera a soma digitada em uma questão enquanto o formulário está aberto
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Formulário da 1ª EE"
    And eu vejo o campo "Tipo da Prova" preenchido com "1"
    And eu vejo o campo "Questão 1" preenchido com "21"
    When eu preencho o campo "Questão 1" com "19"
    Then eu permaneço na página "Formulário da 1ª EE"
    And eu vejo o campo "Questão 1" preenchido com "19"

  Scenario: Aluno envia o formulário da prova com todas as somas preenchidas com sucesso
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Formulário da 1ª EE"
    And eu vejo os campos "Tipo da Prova", "Questão 1", "Questão 2" e "Questão 3" vazios
    When eu preencho o campo "Tipo da Prova" com "1"
    And eu preencho o campo "Questão 1" com "21"
    And eu preencho o campo "Questão 2" com "10"
    And eu preencho o campo "Questão 3" com "33"
    And eu seleciono a opção "Enviar"
    Then eu estou na página "Provas Disponíveis"
    And eu vejo a mensagem "Respostas enviadas com sucesso"
    And eu vejo a avaliação "1ª EE" com o status "Respondida"

  Scenario: Aluno envia o formulário indicando soma zero para uma questão que não soube responder
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Formulário da 1ª EE"
    And eu vejo os campos "Tipo da Prova", "Questão 1", "Questão 2" e "Questão 3" vazios
    When eu preencho o campo "Tipo da Prova" com "2"
    And eu preencho o campo "Questão 1" com "21"
    And eu preencho o campo "Questão 2" com "0"
    And eu preencho o campo "Questão 3" com "63"
    And eu seleciono a opção "Enviar"
    Then eu estou na página "Provas Disponíveis"
    And eu vejo a mensagem "Respostas enviadas com sucesso"
    And eu vejo a avaliação "1ª EE" com o status "Respondida"

  Scenario: Aluno tenta enviar o formulário deixando o campo de uma questão vazio
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Formulário da 1ª EE"
    And eu vejo o campo "Questão 2" vazio
    When eu preencho o campo "Tipo da Prova" com "1"
    And eu preencho o campo "Questão 1" com "21"
    And eu preencho o campo "Questão 3" com "33"
    And eu seleciono a opção "Enviar"
    Then eu permaneço na página "Formulário da 1ª EE"
    And eu vejo a mensagem de erro "Todas as questões são obrigatórias. Digite 0 caso não marque nenhuma proposição"
    And eu vejo o campo "Questão 1" preenchido com "21"
    And eu vejo o campo "Questão 2" vazio
    And eu vejo o campo "Questão 3" preenchido com "33"

  Scenario: Aluno tenta enviar o formulário sem informar o tipo da prova
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Formulário da 1ª EE"
    And eu vejo o campo "Tipo da Prova" vazio
    When eu preencho o campo "Questão 1" com "21"
    And eu preencho o campo "Questão 2" com "10"
    And eu preencho o campo "Questão 3" com "33"
    And eu seleciono a opção "Enviar"
    Then eu permaneço na página "Formulário da 1ª EE"
    And eu vejo a mensagem de erro "O tipo da prova é obrigatório"

  Scenario: Aluno tenta enviar o formulário com uma soma acima do limite máximo de 63
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Formulário da 1ª EE"
    And eu vejo os campos "Tipo da Prova", "Questão 1", "Questão 2" e "Questão 3" vazios
    When eu preencho o campo "Tipo da Prova" com "1"
    And eu preencho o campo "Questão 1" com "64"
    And eu preencho o campo "Questão 2" com "10"
    And eu preencho o campo "Questão 3" com "33"
    And eu seleciono a opção "Enviar"
    Then eu permaneço na página "Formulário da 1ª EE"
    And eu vejo a mensagem de erro "A soma de cada questão deve ser um valor entre 0 e 63"

  Scenario: Aluno tenta acessar novamente o formulário de uma avaliação já respondida
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Provas Disponíveis"
    And eu vejo a avaliação "1ª EE" com o status "Respondida"
    When eu seleciono a avaliação "1ª EE"
    Then eu permaneço na página "Provas Disponíveis"
    And eu vejo a mensagem de erro "Você já enviou as respostas desta avaliação"

  # ===========================================================================
  # Cenários de Serviço (API / Servidor)
  # ===========================================================================

  Scenario: Registrar respostas válidas com tipo de prova e somas entre 0 e 63, serviço
    Given o sistema possui a avaliação "1ª EE" ativa com "3" questões para os tipos de prova "1", "2" e "3"
    And o sistema não possui respostas armazenadas do aluno "joao" para a avaliação "1ª EE"
    When o aluno "joao" submete para a avaliação "1ª EE" o tipo de prova "1" com as somas "1:21, 2:0, 3:63"
    Then o sistema armazena para o aluno "joao" na avaliação "1ª EE" o tipo de prova "1" e as somas "1:21, 2:0, 3:63"

  Scenario: Rejeitar submissão de respostas com questão não preenchida, serviço
    Given o sistema possui a avaliação "1ª EE" ativa com "3" questões para os tipos de prova "1", "2" e "3"
    And o sistema não possui respostas armazenadas do aluno "joao" para a avaliação "1ª EE"
    When o aluno "joao" tenta submeter para a avaliação "1ª EE" o tipo de prova "1" com as somas "1:21, 2:, 3:33"
    Then o sistema rejeita a submissão para a avaliação "1ª EE"
    And o sistema não possui respostas armazenadas do aluno "joao" para a avaliação "1ª EE"

  Scenario: Rejeitar submissão de respostas com soma fora do intervalo de 0 a 63, serviço
    Given o sistema possui a avaliação "1ª EE" ativa com "3" questões para os tipos de prova "1", "2" e "3"
    And o sistema não possui respostas armazenadas do aluno "joao" para a avaliação "1ª EE"
    When o aluno "joao" tenta submeter para a avaliação "1ª EE" o tipo de prova "1" com as somas "1:64, 2:10, 3:33"
    Then o sistema rejeita a submissão para a avaliação "1ª EE"
    And o sistema não possui respostas armazenadas do aluno "joao" para a avaliação "1ª EE"

  Scenario: Rejeitar nova submissão para uma avaliação já respondida pelo aluno, serviço
    Given o sistema possui a avaliação "1ª EE" ativa com "3" questões para os tipos de prova "1", "2" e "3"
    And o sistema possui armazenadas para o aluno "joao" na avaliação "1ª EE" o tipo de prova "1" e as somas "1:21, 2:10, 3:33"
    When o aluno "joao" tenta submeter para a avaliação "1ª EE" o tipo de prova "1" com as somas "1:15, 2:8, 3:32"
    Then o sistema rejeita a submissão para a avaliação "1ª EE"
    And o sistema mantém armazenadas para o aluno "joao" na avaliação "1ª EE" o tipo de prova "1" e as somas "1:21, 2:10, 3:33"
