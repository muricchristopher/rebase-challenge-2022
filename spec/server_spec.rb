# frozen_string_literal: true

require 'spec_helper'
require './lib/medical_record'

describe Server, type: :request do
  context 'GET /tests' do
    it 'should return all medical records in database' do
      data = { cpf: '048.973.170-88', nome_paciente: 'Emilly Batista Neto',
               email_paciente: 'gerald.crona@ebert-quigley.com', data_nascimento_paciente: '2001-03-11', endereorua_paciente: '165 Rua Rafaela', cidade_paciente: 'Ituverava', estado_patiente: 'Alagoas', crm_mdico: 'B000BJ20J4', crm_mdico_estado: 'PI', nome_mdico: 'Maria Luiza Pires', email_mdico: 'denna@wisozk.biz', token_resultado_exame: 'IQCZ17', data_exame: '2021-08-05', tipo_exame: 'hemácias', limites_tipo_exame: '45-52', resultado_tipo_exame: '97' }
      expected_response = [{ 'result_token' => 'IQCZ17', 'result_date' => '2021-08-05',
                             'patient' => { 'cpf' => '048.973.170-88', 'name' => 'Emilly Batista Neto', 'email' => 'gerald.crona@ebert-quigley.com', 'birthday' => '2001-03-11', 'address' => '165 Rua Rafaela', 'city' => 'Ituverava', 'state' => 'Alagoas' }, 'doctor' => { 'crm' => 'B000BJ20J4', 'doctor_name' => 'Maria Luiza Pires', 'doctor_crm_state' => 'PI', 'doctor_email' => 'denna@wisozk.biz' }, 'test' => { 'type' => 'hemácias', 'limits' => '45-52', 'results' => '97' } }]
      medical_record = MedicalRecord.new(data)
      medical_record.create

      response = get '/tests'
      json_response = JSON.parse(response.body)

      expect(response.content_type).to include('application/json')
      expect(response.status).to eq(200)
      expect(json_response).to eq(expected_response)
    end

    it 'should return a message when no medical records were found in database' do
      response = get '/tests'
      json_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_response['message']).to eq('No medical records found')
    end
  end

  context 'GET /tests/:id' do
    it 'should return test details from a token' do
      first_data = { cpf: '048.973.170-88', nome_paciente: 'Emilly Batista Neto',
                     email_paciente: 'gerald.crona@ebert-quigley.com', data_nascimento_paciente: '2001-03-11', endereorua_paciente: '165 Rua Rafaela', cidade_paciente: 'Ituverava', estado_patiente: 'Alagoas', crm_mdico: 'B000BJ20J4', crm_mdico_estado: 'PI', nome_mdico: 'Maria Luiza Pires', email_mdico: 'denna@wisozk.biz', token_resultado_exame: 'IQCZ17', data_exame: '2021-08-05', tipo_exame: 'hemácias', limites_tipo_exame: '45-52', resultado_tipo_exame: '97' }
      second_data = { cpf: '048.973.170-88', nome_paciente: 'Emilly Batista Neto',
                      email_paciente: 'gerald.crona@ebert-quigley.com', data_nascimento_paciente: '2001-03-11', endereorua_paciente: '165 Rua Rafaela', cidade_paciente: 'Ituverava', estado_patiente: 'Alagoas', crm_mdico: 'B000BJ20J4', crm_mdico_estado: 'PI', nome_mdico: 'Maria Luiza Pires', email_mdico: 'denna@wisozk.biz', token_resultado_exame: 'IQCZ17', data_exame: '2021-08-05', tipo_exame: 'glicemia', limites_tipo_exame: '25-83', resultado_tipo_exame: '78' }
      expected_response = { 'result_token' => 'IQCZ17', 'result_date' => '2021-08-05', 'cpf' => '048.973.170-88',
                            'name' => 'Emilly Batista Neto', 'email' => 'gerald.crona@ebert-quigley.com', 'birthday' => '2001-03-11', 'doctor' => { 'crm' => 'B000BJ20J4', 'crm_state' => 'PI', 'name' => 'Maria Luiza Pires' }, 'tests' => [{ 'test_type' => 'hemácias', 'test_limits' => '45-52', 'test_result' => '97' }, { 'test_type' => 'glicemia', 'test_limits' => '25-83', 'test_result' => '78' }] }
      MedicalRecord.new(first_data).create
      MedicalRecord.new(second_data).create

      response = get '/tests/IQCZ17'
      json_response = JSON.parse(response.body)

      expect(response.content_type).to include('application/json')
      expect(json_response).to eq(expected_response)
      expect(response.status).to eq(200)
    end

    it 'should return a status 404 and an error message when test details from a token were not found' do
      response = get '/tests/asmdkasdjsandjandsadjsan'

      json_response = JSON.parse(response.body)

      expect(json_response['error']).to eq('Could not find a medical record with token -> asmdkasdjsandjandsadjsan')
      expect(response.status).to eq(404)
    end
  end

  context 'POST /import_sync' do
    csv = Rack::Test::UploadedFile.new('./test_data.csv', 'csv')

    it 'should import a csv file into database' do
      response = post('/import_sync', csv_file: csv)
      json_response = JSON.parse(response.body)

      expect(json_response['message']).to eq('File successfully imported to DB')
      expect(MedicalRecord.all.length).to eq(42)
      expect(response.status).to eq(201)
    end

    it 'should return status 500 when no files are assigned to the request' do
      response = post '/import_sync', csv_file: nil

      expect(response.status).to eq(500)
    end
  end

  context 'POST /import' do
    csv = Rack::Test::UploadedFile.new('./test_data.csv', 'csv')

    it 'should import csv file asynchronously into database' do
      response = post('/import', csv_file: csv)
      json_response = JSON.parse(response.body)

      expect(json_response['message']).to eq('File successfully queued to be imported')
      expect(response.status).to eq(201)
    end

    it 'should return status 500 when no files are assigned to the request' do
      response = post '/import', csv_file: nil

      expect(response.status).to eq(500)
    end
  end
end
