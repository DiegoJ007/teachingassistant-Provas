Feature: Cadastro de respostas da prova
  Como um aluno de uma disciplina
  Eu quero registrar e revisar minhas respostas durante a realização da prova
  Para que minhas respostas sejam submetidas para correção e cálculo da minha nota

  # ===========================================================================
  # Cenários de Interface (GUI)
  # ===========================================================================

  Scenario: Aluno inicia a realização de uma avaliação disponível
    Given eu estou logado como "aluno" com o login "joao"
    And a avaliação "1ª EE" com "3" questões está disponível para o aluno "joao"
    And eu estou na página "Provas Disponíveis"
    And eu vejo a avaliação "1ª EE" na listagem com o status "Disponível"
    When eu seleciono a opção "Iniciar Prova" para a avaliação "1ª EE"
    Then eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo o enunciado da questão número "1"
    And eu vejo as alternativas "A", "B", "C", "D" e "E" disponíveis para a questão número "1"

  Scenario: Aluno seleciona uma alternativa para uma questão da prova
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a questão número "1" sem nenhuma alternativa selecionada
    When eu seleciono a alternativa "A" para a questão número "1"
    Then eu permaneço na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a alternativa "A" selecionada para a questão número "1"

  Scenario: Aluno altera a alternativa selecionada em uma questão antes do envio
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a questão número "1" com a alternativa "A" selecionada
    When eu seleciono a alternativa "C" para a questão número "1"
    Then eu permaneço na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a alternativa "C" selecionada para a questão número "1"
    And eu não vejo a alternativa "A" selecionada para a questão número "1"

  Scenario: Aluno navega para a próxima questão e retorna mantendo a resposta anterior
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a questão número "1" com a alternativa "B" selecionada
    When eu seleciono a opção "Próxima Questão"
    And eu seleciono a opção "Questão Anterior"
    Then eu vejo a questão número "1" na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a alternativa "B" selecionada para a questão número "1"

  Scenario: Sistema mantém separadas as respostas registradas em diferentes questões da prova
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a questão número "1" com a alternativa "A" selecionada
    When eu seleciono a opção "Próxima Questão"
    And eu seleciono a alternativa "D" para a questão número "2"
    Then eu vejo a alternativa "D" selecionada para a questão número "2"
    And o resumo da prova exibe a questão número "1" marcada com "A" e a questão número "2" marcada com "D"

  Scenario: Aluno avança deixando uma questão em branco durante a prova
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a questão número "2" sem nenhuma alternativa selecionada
    When eu seleciono a opção "Próxima Questão"
    Then eu vejo a questão número "3" na página "Prova em Andamento" da avaliação "1ª EE"
    And o resumo da prova exibe a questão número "2" com o status "Em branco"

  Scenario: Aluno cancela a confirmação de finalização e mantém as respostas preenchidas
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu selecionei a alternativa "A" para a questão número "1" e "C" para a questão número "2"
    When eu seleciono a opção "Finalizar Prova"
    And eu seleciono a opção "Cancelar Envio" no modal de confirmação
    Then eu permaneço na página "Prova em Andamento" da avaliação "1ª EE"
    And eu vejo a alternativa "A" selecionada para a questão número "1"
    And eu vejo a alternativa "C" selecionada para a questão número "2"

  Scenario: Aluno confirma o envio da prova com todas as questões respondidas
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu selecionei a alternativa "A" para a questão número "1", "C" para a questão número "2" e "B" para a questão número "3"
    When eu seleciono a opção "Finalizar Prova"
    And eu seleciono a opção "Confirmar Envio" no modal de confirmação
    Then eu estou na página "Provas Disponíveis"
    And eu vejo a mensagem "Prova enviada com sucesso"
    And eu vejo a avaliação "1ª EE" na listagem com o status "Respondida"

  Scenario: Aluno confirma o envio de uma prova contendo questão sem resposta
    Given eu estou logado como "aluno" com o login "joao"
    And eu estou na página "Prova em Andamento" da avaliação "1ª EE"
    And eu selecionei a alternativa "A" para a questão número "1" e "B" para a questão número "3"
    And eu deixei a questão número "2" sem nenhuma alternativa selecionada
    When eu seleciono a opção "Finalizar Prova"
    And eu vejo o aviso "Você possui 1 questão em branco" no modal de confirmação
    And eu seleciono a opção "Confirmar Envio" no modal de confirmação
    Then eu estou na página "Provas Disponíveis"
    And eu vejo a mensagem "Prova enviada com sucesso"
    And eu vejo a avaliação "1ª EE" na listagem com o status "Respondida"

  Scenario: Aluno tenta iniciar novamente uma avaliação já respondida
    Given eu estou logado como "aluno" com o login "joao"
    And o aluno "joao" já enviou as respostas da avaliação "1ª EE"
    When eu acesso a página "Provas Disponíveis"
    Then eu vejo a avaliação "1ª EE" na listagem com o status "Respondida"
    And a opção "Iniciar Prova" para a avaliação "1ª EE" está desabilitada

  # ===========================================================================
  # Cenários de Serviço (API / Servidor)
  # ===========================================================================

  Scenario: Registrar respostas de uma prova com todas as questões respondidas, serviço
    Given o sistema possui a avaliação "1ª EE" ativa com as questões "1", "2" e "3"
    And o sistema não possui respostas registradas do aluno "joao" para a avaliação "1ª EE"
    When o aluno "joao" envia as respostas "1:A, 2:C, 3:B" para a avaliação "1ª EE"
    Then o sistema armazena as respostas "1:A, 2:C, 3:B" do aluno "joao" para a avaliação "1ª EE"

  Scenario: Registrar respostas de uma prova contendo questão em branco, serviço
    Given o sistema possui a avaliação "1ª EE" ativa com as questões "1", "2" e "3"
    And o sistema não possui respostas registradas do aluno "joao" para a avaliação "1ª EE"
    When o aluno "joao" envia as respostas "1:A, 2:EM_BRANCO, 3:B" para a avaliação "1ª EE"
    Then o sistema armazena as respostas "1:A, 2:EM_BRANCO, 3:B" do aluno "joao" para a avaliação "1ª EE"
    And a questão "2" do aluno "joao" na avaliação "1ª EE" fica registrada como não respondida para a correção

  Scenario: Rejeitar novo envio de respostas para uma avaliação já respondida pelo aluno, serviço
    Given o sistema já armazena as respostas "1:A, 2:C, 3:B" do aluno "joao" para a avaliação "1ª EE"
    When o aluno "joao" tenta enviar novas respostas "1:D, 2:E, 3:A" para a avaliação "1ª EE"
    Then o sistema rejeita a submissão duplicada para a avaliação "1ª EE"
    And o sistema mantém armazenadas as respostas "1:A, 2:C, 3:B" do aluno "joao" para a avaliação "1ª EE"
