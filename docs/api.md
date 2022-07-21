# Endpoints

## GET /tests

Retorna todos os registros médicos registrados no banco de dados:

```json
[
   {
    "result_token": "IQCZ17",
    "result_date": "2021-08-05",
    "patient": {
      "cpf": "048.973.170-88",
      "name": "Emilly Batista Neto",
      "email": "gerald.crona@ebert-quigley.com",
      "birthday": "2001-03-11",
      "address": "165 Rua Rafaela",
      "city": "Ituverava",
      "state": "Alagoas"
    },
    "doctor": {
      "crm": "B000BJ20J4",
      "doctor_name": "Maria Luiza Pires",
      "doctor_crm_state": "PI",
      "doctor_email": "denna@wisozk.biz"
    },
    "test": {
      "type": "hemácias",
      "limits": "45-52",
      "results": "97"
    }
  },
   {
    "result_token": "16GKAR",
    "result_date": "2021-08-05",
    "patient": {
      "cpf": "071.488.453-78",
      "name": "Antônio Rebouças",
      "email": "adalberto_grady@feil.org",
      "birthday": "1999-04-11",
      "address": "25228 Travessa Ladislau",
      "city": "Tefé",
      "state": "Sergipe"
    },
    "doctor": {
      "crm": "B0000DHDOF",
      "doctor_name": "Luiz Felipe Raia Jr.",
      "doctor_crm_state": "MT",
      "doctor_email": "marshall@brekke-funk.name"
    },
    "test": {
      "type": "ldl",
      "limits": "45-54",
      "results": "55"
    }
  }
  ...
]
```

## GET /tests/:token

Retorna informações de um exame a partir de um token:

```json
{
  "result_token": "E0GGJP",
  "result_date": "2021-12-22",
  "cpf": "076.638.088-27",
  "name": "Fabiano Casqueira Jr.",
  "email": "fidela@zieme.info",
  "birthday": "1982-07-10",
  "doctor": {
    "crm": "B0000DHDOF",
    "crm_state": "MT",
    "name": "Luiz Felipe Raia Jr."
  },
  "tests": [
    {
      "test_type": "hemácias",
      "test_limits": "45-52",
      "test_result": "30"
    },
    {
      "test_type": "leucócitos",
      "test_limits": "9-61",
      "test_result": "86"
    },
    {
      "test_type": "plaquetas",
      "test_limits": "11-93",
      "test_result": "25"
    },
    {
      "test_type": "hdl",
      "test_limits": "19-75",
      "test_result": "90"
    },
    {
      "test_type": "ldl",
      "test_limits": "45-54",
      "test_result": "97"
    },
    {
      "test_type": "vldl",
      "test_limits": "48-72",
      "test_result": "76"
    },
    {
      "test_type": "glicemia",
      "test_limits": "25-83",
      "test_result": "6"
    },
    {
      "test_type": "tgo",
      "test_limits": "50-84",
      "test_result": "26"
    },
    {
      "test_type": "tgp",
      "test_limits": "38-63",
      "test_result": "1"
    },
    {
      "test_type": "eletrólitos",
      "test_limits": "2-68",
      "test_result": "11"
    },
    {
      "test_type": "tsh",
      "test_limits": "25-80",
      "test_result": "0"
    },
    {
      "test_type": "t4-livre",
      "test_limits": "34-60",
      "test_result": "62"
    },
    {
      "test_type": "ácido úrico",
      "test_limits": "15-61",
      "test_result": "41"
    }
  ]
}
```

## POST /import_sync

Realiza a importação de um arquivo CSV ao Banco de Dados de forma **síncrona**

_Exemplo Requisição (Body):_

```json
{
  "csv_file": "data.csv"
}
```

_Exemplo de resposta:_

```json
{
  "message": "File successfully imported to DB"
}
```

## POST /import

Realiza a importação de um arquivo CSV ao Banco de Dados de forma **assíncrona**

_Exemplo Requisição (Body):_

```json
{
  "csv_file": "data.csv"
}
```

_Exemplo de resposta:_

```json
{
  "message": "File successfully queued to be imported"
}
```

## Cabeçalho CSV para POST's

Para os endpoints POST /import e POST /import_sync, segue o exemplo de um cabeçalho CSV válido com dados:

| cpf            | nome paciente        | email paciente                 | data nascimento paciente | endereço/rua paciente | cidade paciente | estado patiente | crm médico | crm médico estado | nome médico       | email médico     | token resultado exame | data exame | tipo exame | limites tipo exame | resultado tipo exame |
| -------------- | -------------------- | ------------------------------ | ------------------------ | --------------------- | --------------- | --------------- | ---------- | ----------------- | ----------------- | ---------------- | --------------------- | ---------- | ---------- | ------------------ | -------------------- |
| 048.973.170-88 | Emilly Batista Netoe | gerald.crona@ebert-quigley.com | 2001-03-11               | 165 Rua Rafaela       | Ituverava       | Alagoas         | B000BJ20J4 | PI                | Maria Luiza Pires | denna@wisozk.biz | IQCZ17                | 2021-08-05 | hemácias   | 45-52              | 97                   |
