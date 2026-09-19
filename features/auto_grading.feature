Feature: Correção automática e atualização de notas de cada aluno
As a Usuário
I Want poder corrigir automaticamente todas as provas da turma com gabarito cadastrado
So that todas as notas possam ser entregues de forma eficiente e segura

@gui
Scenario: Professor corrige as notas de uma turma com gabarito cadastrado
    Given que eu sou o professor "Paulo"
    And eu estou na página de notas da turma "Engenharia de Software e Sistemas 2026.2"
    And as respostas são "3", "9" e "15" para as questões da prova 01
    And as respostas são "9", "15" e "3" para as questões da prova 02
    And o aluno "Pedro" marcou a prova 01 com as respostas "3", "3" e "15"
    And a aluna "Maria" marcou a prova 02 com as respostas "9", "15" e "3"
    And eu enviei a planilha com os gabaritos com a formatação correta
    And eu enviei a planilha de respostas com a formatação correta
    When eu tocar no botão de correção automática
    Then aparecerá uma mensagem informando que as notas foram cadastradas
    And a nota do aluno "Pedro" constará como 67%
    And a nota da aluna "Maria" constará como 100%

@gui
Scenario Outline: Professor tenta corrigir notas com planilha de gabarito malformada
    Given que eu sou o professor "Paulo"
    And eu estou na página de notas da turma "Engenharia de Software e Sistemas 2026.2"
    And eu enviei uma planilha de gabaritos com o problema "<problema>"
    And eu enviei a planilha de respostas com a formatação correta
    When eu tocar no botão de correção automática
    Then aparecerá a mensagem de erro
    And nenhuma nota será cadastrada para a turma

    Examples:
        | problema                           |
        | coluna de número da prova ausente  |
        | extensão de arquivo inválida (.txt)|
        | gabarito com questão vazia         |

@gui
Scenario: Professor tenta corrigir as notas de uma turma com a planilha de respostas possuindo formatação errada
    Given que eu sou o professor "Paulo"
    And eu estou na página de notas da turma "Engenharia de Software e Sistemas 2026.2"
    And as respostas são "3", "9" e "15" para as questões da prova 01
    And eu enviei a planilha com os gabaritos com a formatação correta
    And eu enviei a planilha de respostas com o "<problema>"
    When eu tocar no botão de correção automática
    Then aparecerá uma mensagem de erro informando que a planilha de respostas está em formato inválido
    And nenhuma nota será cadastrada para a turma

    Examples:
        | problema                                               |
        | Número de prova que não existe                         |
        | extensão de arquivo inválida (.txt)                    |
        | questão 3 faltando (numero de colunas invalido)        |

@gui
Scenario: Professor corrige notas de uma turma e um aluno preenche uma resposta inválida
    Given que eu sou o professor "Paulo"
    And eu estou na página de notas da turma "Engenharia de Software e Sistemas 2026.2"
    And as respostas são "3", "9" e "15" para as questões da prova 01
    And o aluno "João" marcou a prova 01 com as respostas "3", "B" e "40"
    And eu enviei a planilha com os gabaritos com a formatação correta
    And eu enviei a planilha de respostas com a formatação correta
    When eu tocar no botão de correção automática
    Then aparecerá uma mensagem informando que as notas foram cadastradas com alertas de respostas inválidas
    And a nota do aluno "João" constará como 33%
    And o sistema indicará que as questões 2 e 3 do aluno "João" possuem respostas inválidas

