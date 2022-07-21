# Rebase Challenge 2022

API em Ruby para listagem de exames médicos.

## Requisitos

Acesse os requisitos dos desafios [aqui](https://git.campuscode.com.br/core-team/rebase-challenge-2022).

## Tech Stack

- [Docker](https://www.docker.com/)
- [Ruby](https://www.ruby-lang.org/pt/)
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)

<hr>


## Executando a aplicação

0. Instalar o [Docker](https://docs.docker.com/engine/install/), caso ainda não tenha instalado e configurado-o propiamente;

1. Clone o repositório:

```bash
git clone https://github.com/muricchristopher/rebase-challenge-2022.git
```

2. Acesse o diretório e inicialize os _contêiners_ docker:

```bash
cd rebase-challenge-2022
docker compose up -d
```

3. Configure o banco de dados, caso essa seja a primeira execução da aplicação:

```bash
docker exec -ti ruby_server bash -c 'rake db:setup_development'
```

4. Acesse a aplicação em http://localhost:3000/tests.


## Testando

1. Configure o banco de dados para testes, caso essa seja a primeira execução dos mesmos:

```bash
docker exec -ti ruby_server bash -c 'rake db:setup_test'
```

2. Rode os testes com o commando _rspec_:

```bash
docker exec -ti ruby_server bash -c 'bundle exec rspec'
```


## Populando o Banco de Dados

1. Rode o seguinte comando:

```bash
docker exec -ti ruby_server bash -c 'ruby import_from_csv.rb'
```


## Documentação da API

[Documentação API](API.md)
