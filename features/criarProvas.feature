O sistema deve ser capaz de permitir a geração de provas individuais pelos professores para
suas turmas.

# -------------------------------------------------------------------------------------- #

Feature: Geração de provas
    Como um professor responsável por uma disciplina
    Eu quero gerar provas individuais para a turma
    Para que eu possa monitorar o desempenho dos alunos e gerir melhor a turma

# -------------------------------------------------------------------------------------- #

Scenarios

Scenario: Professor inicia a seleção de questões
    Given eu estou logado como "professor"
    And eu estou na página "criação de provas"
    When eu seleciono a opção "selecionar de questões"
    Then eu vejo o campo de texto "assunto" vazio
    And eu vejo o campo "questões do assunto" vazio

Scenario: Professor busca por questões de um assunto
    Given eu estou logado como "professor"
    And eu estou na página "criação de provas"
    And eu vejo o campo de texto "assunto" vazio
    And eu vejo o campo "questões do assunto" vazio
    When eu coloco a palavra "requisitos" no campo "assunto"
    Then eu vejo o campo "assunto" com a palavra "requisitos"
    And eu vejo o campo "questões do assunto" com uma lista de questões sobre "requisitos"

# -------------------------------------------------------------------------------------- #