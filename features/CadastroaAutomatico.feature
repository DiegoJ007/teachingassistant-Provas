Feature: Cadastro de respostas da prova
Como um aluno de uma disciplina
Eu quero registrar minhas respostas durante a realização da prova
Para que minhas respostas possam ser corrigidas e minha nota seja calculada

--------------------------------------------------------------------------------------

Scenarios

Scenario: Aluno inicia a realização da prova
Given eu estou logado como "aluno"
And eu estou na página "provas disponíveis"
And eu vejo uma prova disponível
When eu seleciono a opção "iniciar prova"
Then eu vejo a página "prova em andamento"

Scenario: Aluno visualiza uma questão da prova
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a questão número "1"
Then eu vejo o enunciado da questão número "1"
And eu vejo as alternativas disponíveis para a questão

Scenario: Aluno seleciona uma alternativa
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a questão número "1"
And eu vejo as alternativas disponíveis para a questão
When eu seleciono a alternativa "A"
Then eu vejo a alternativa "A" selecionada para a questão número "1"

Scenario: Aluno altera sua resposta
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a questão número "1"
And eu vejo a alternativa "A" selecionada
When eu seleciono a alternativa "C"
Then eu vejo a alternativa "C" selecionada para a questão número "1"
And eu não vejo a alternativa "A" selecionada para a questão número "1"

Scenario: Aluno navega para outra questão
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a questão número "1"
When eu seleciono a opção "próxima questão"
Then eu vejo a questão número "2"

Scenario: Aluno retorna para uma questão anterior
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a questão número "11"
When eu seleciono a opção "questão anterior"
Then eu vejo a questão número "10"
And eu vejo a resposta anteriormente selecionada para a questão número "1"

Scenario: Aluno deixa uma questão sem resposta
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a questão número "11"
And nenhuma alternativa está selecionada
When eu seleciono a opção "próxima questão"
Then eu vejo a questão número "12"
And a questão número "11" permanece sem resposta

Scenario: Aluno finaliza a prova
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo todas as questões da prova respondidas ou não respondidas
When eu seleciono a opção "finalizar prova"
Then eu vejo uma mensagem de confirmação para finalizar a prova
And eu vejo a opção "confirmar envio"

Scenario: Aluno confirma o envio da prova
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a mensagem de confirmação para finalizar a prova
When eu seleciono a opção "confirmar envio"
Then eu vejo a mensagem "prova enviada com sucesso"
And minhas respostas são registradas no sistema

Scenario: Aluno envia uma prova com questão sem resposta
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo uma ou mais questões sem resposta
When eu seleciono a opção "confirmar envio"
Then eu vejo a mensagem "prova enviada com sucesso"
Then as questões sem resposta são registradas como incorretas para a correção

Scenario: Sistema mantém respostas de diferentes questões separadas
Given eu estou logado como "aluno"
And eu estou na página "prova em andamento"
And eu vejo a questão número "1"
When eu seleciono a alternativa "A"
And eu navego para a questão número "2"
And eu seleciono a alternativa "C"
Then eu vejo a alternativa "A" registrada para a questão número "1"
And eu vejo a alternativa "C" registrada para a questão número "2"