Feature: Correção automática e atualização de notas de cada aluno
As a Usuário
I Want poder corrigir automaticamente todas as provas da turma com gabarito cadastrado
So that todas as notas possam ser entregues de forma eficiente e segura

Scenario: Professor corrige as notas de uma turma com gabarito cadastrado
Given que eu sou o professor "Paulo"
And eu estou na página de notas da turma "Engenharia de Software e Sistemas 2026.2"
And o gabarito da prova de "Engenharia de Requisitos" está cadastrado com as respostas "1", "V,F,F,V" e "BDD" para as questões de ID 1, 2 e 3, respectivamente
And o aluno "Pedro" marcou as respostas "1", "V,F,V,F" e "BDD"
And a aluna "Maria" marcou as respostas "1", "V,F,F,V" e "BDD"
When eu tocar no botão de correção automática
Then aparecerá uma mensagem informando que as notas foram cadastradas
And a nota do aluno "Pedro" constará como 67%
And a nota da aluna "Maria" constará como 100%

Scenario: Professor tenta corrigir uma turma sem gabarito cadastrado
Given que eu sou o professor "Paulo"
And eu estou na página de notas da turma "Engenharia de Software e Sistemas 2026.2"
And não há gabarito cadastrado para a prova de "Engenharia de Requisitos"
When eu tocar no botão de correção automática
Then aparecerá uma mensagem de erro informando que é necessário cadastrar o gabarito antes de corrigir
And nenhuma nota será atualizada
And aparecerá um identificador nas questões sem gabarito