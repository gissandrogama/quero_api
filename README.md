![logo-quero-edu-small](https://user-images.githubusercontent.com/1139813/90247813-c9cfc780-de0d-11ea-9a97-485a7212d9dd.png)

# QueroApi

![Elixir CI](https://github.com/gissandrogama/quero_api/workflows/Elixir%20CI/badge.svg?branch=main)

Desafio **bac-kend** que o objetivo é criar uma API para exibição e filtragem de ofertas de curso.

# Informacoes Tecnicas
* Ecossistema Elixir

## Iniciando a api localmente

**1.** Clone o projeto:

 * ssh
```sh
$ git clone git@github.com:gissandrogama/quero_api.git
```

 * https
```sh
$ git clone https://github.com/gissandrogama/quero_api.git
```

**2.** Acesse a pasta do projeto:

```sh
$ cd quero_api
```

**3.** Instale as dependências:

```sh
$ mix deps.get
```

**4.** criar e migrar o banco de dados, e inserir dados do db.json:

```sh
$ mix ecto.setup
```

**5.** inicie o endpoit phoenix com:

```sh
$ mix phx.sever
```

# Sobre API

Como foi requisitado nos especificações das funcionalidades do teste, a api possui dois endpoints um para listar **cursos** e outro para listar **ofertas**, como mostra a tabela a seguir:

endpoint   | parametros de filtros | valores que podem ser passados para os parametros
--------- | ----------------------- | --------------
/api/courses | kind, level, shift e univerisity | kind(presencial, ead, ...), level(bacharelado, licenciatura, ...), shitf(manhã, noite, ...) e university(Estácio, ..)
/api/offers | city, course, kind, level, shift,university, prices | kind(presencial, ead, ...), level(bacharelado, licenciatura, ...), shitf(manhã, noite, ...), university(Estácio, ..), city(São Paulo, ...), course(Sistema de informação, ...), prices(maior ou menor)

Endpoint's de usuários para atenticação com JTW

endpoint   | parametros para users | valores que podem ser passados para os parametros
--------- | ----------------------- | --------------
/users     | email, password e password_confirmation | um email valido, um senha de no minimo 6 caracteres e repetir a senha para criar um user
/users/sign_in | email e password | o email e senha cadastrados para efetuar o login

obs.: prices oderna os dados de forma crescente(menor) ou decrescente(maior) de acordo o preço com desconto de ofertas.

para fazer os teste ultilizei o insomnia, mas pode ser ultilizado outros programa como o postman.

caso queira usar o insomnia, segue um arquivo já com as rotas para ultilizar, tanto local ou produção
[arquivo insomnia](./Insomnia_2020-12-11.json)

nas rotas ````/api/courses```` e ````/api/offers```` foi feito cache com ETS

# Deploy
A aplicação está no gigalixir no endereço <https://quero-api.gigalixirapp.com/>. Um dos motivos de escolher o gigalixir é que não tem sleeps da aplicação no plano free.

# GET listar cursos projeto local e em produção

## Sem passar nenhum parametro

usando navedador
```
http://localhost:4000/api/courses?university&kind&level&shift
```

```
https://quero-api.gigalixirapp.com/api/courses?university&kind&level&shift
```

usando o terminal
```sh
$ curl --request GET \
  --url 'http://localhost:4000/api/courses?university=&kind=&level=&shift='
```

usando o terminal
```sh
curl --request GET \
  --url 'https://quero-api.gigalixirapp.com/api/courses?university=&kind=&level=&shift='
```
recupera todos os cursos do banco de dados.


## Passando um ou mais parametros

usando navedador
```
http://localhost:4000/api/courses?university=unip&kind&level&shift
```

usando navedador server prod
```
https://quero-api.gigalixirapp.com/api/courses?university=unip&kind&level&shift
```

usando o terminal
```sh
$ curl --request GET \
  --url 'http://localhost:4000/api/courses?university=unip&kind=&level=&shift='
```

usando o terminal server prod
```sh
$ curl --request GET \
  --url 'https://quero-api.gigalixirapp.com/api/courses?university=unip&kind=&level=&shift='
```
na requisição acima ele recupera todos os cursos que tem relação com a **UNIP**.


# GET listar ofertas projeto local e produção

## Essa rota necessita de um usuário autenticado.
caso não tenha um usuário crie um da seguinte forma:

tipo post /users
```sh
curl --request POST \
  --url http://localhost:4000/api/users \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
	"email": "henry@gmail.com",
	"password": "456789",
	"password_confirmation": "456789"
}'
```

```sh
curl --request POST \
  --url https://quero-api.gigalixirapp.com/api/users \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
	"email": "henry@gmail.com",
	"password": "456789",
	"password_confirmation": "456789"
}'
```

Parametros
```json
{
	"email": "henry@gmail.com",
	"password": "456789",
	"password_confirmation": "456789"
}
```

Para autenticar
tipo post /users/sign_in
```sh
curl --request POST \
  --url http://localhost:4000/api/users/sign_in \
  --header 'Content-Type: application/json' \
  --data '{
	"email": "henry@gmail.com",
	"password": "456789"
}'
```

```sh
curl --request POST \
  --url https://quero-api.gigalixirapp.com/api/users/sign_in \
  --header 'Content-Type: application/json' \
  --data '{
	"email": "henry@gmail.com",
	"password": "456789"
}'
```

Parametros
```json
{
	"email": "henry@gmail.com",
	"password": "456789"
}
```


## Sem passar nenhum parametro

usando o navegador
```
http://localhost:4000/api/offers?university&course&kind&level&shift&city&prices
```

Produção
```
https://quero-api.gigalixirapp.com/api/offers?university&course&kind&level&shift&city&prices
```

usando o terminal

```sh
$ curl --request GET \
  --url 'http://localhost:4000/api/offers?university=&course=&kind=&level=&shift=&city=&prices='

```

```sh
$ curl --request GET \
  --url 'https://quero-api.gigalixirapp.com/api/offers?university=&course=&kind=&level=&shift=&city=&prices='

```

```sh
$ curl --request GET \
  --url 'http://localhost:4000/api/offers?university=&course=&kind=&level=&shift=&city=&prices='

```

```sh
$ curl --request GET \
  --url 'https://quero-api.gigalixirapp.com/api/offers?university=&course=&kind=&level=&shift=&city=&prices='

```
recupera todos as offertas do banco de dados.


## Passando um ou mais parametros

usando o navegador
```
http://localhost:4000/api/offers?university=unip&course&kind&level&shift&city&prices=maior
```

```
https://quero-api.gigalixirapp.com/api/offers?university=unip&course&kind&level&shift&city&prices=maior
```

usando o terminal
```sh
$ curl --request GET \
  --url 'http://localhost:4000/api/offers?university=unip&course=&kind=&level=&shift=&city=&prices=maior'
```

```sh
$ curl --request GET \
  --url 'https://quero-api.gigalixirapp.com/api/offers?university=unip&course=&kind=&level=&shift=&city=&prices=maior'
```
na requisição acima ela recupera todos as ofertas que tem relação com a **UNIP** e ordena do mario valor com desconto para o menor.

# Gerar documentação da aplicação

```sh
$ mix docs
```
