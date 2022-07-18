require 'spec_helper'
require './lib/medical_record'

describe Server, type: :request do
   context "GET /tests" do
      it "should return all medical records in database" do
         data = {:cpf=>"048.973.170-88", :nome_paciente=>"Emilly Batista Neto", :email_paciente=>"gerald.crona@ebert-quigley.com", :data_nascimento_paciente=>"2001-03-11", :endereorua_paciente=>"165 Rua Rafaela", :cidade_paciente=>"Ituverava", :estado_patiente=>"Alagoas", :crm_mdico=>"B000BJ20J4", :crm_mdico_estado=>"PI", :nome_mdico=>"Maria Luiza Pires", :email_mdico=>"denna@wisozk.biz", :token_resultado_exame=>"IQCZ17", :data_exame=>"2021-08-05", :tipo_exame=>"hemácias", :limites_tipo_exame=>"45-52", :resultado_tipo_exame=>"97"}
         expected_response = [{"result_token"=>"IQCZ17", "result_date"=>"2021-08-05", "patient"=>{"cpf"=>"048.973.170-88", "name"=>"Emilly Batista Neto", "email"=>"gerald.crona@ebert-quigley.com", "birthday"=>"2001-03-11", "address"=>"165 Rua Rafaela", "city"=>"Ituverava", "state"=>"Alagoas"}, "doctor"=>{"crm"=>"B000BJ20J4", "doctor_name"=>"Maria Luiza Pires", "doctor_crm_state"=>"PI", "doctor_email"=>"denna@wisozk.biz"}, "test"=>{"type"=>"hemácias", "limits"=>"45-52", "results"=>"97"}}]
         medical_record = MedicalRecord.new(data)
         medical_record.create


         response = get "/tests"
         json_response = JSON.parse(response.body)

         expect(response.content_type).to include('application/json')
         expect(response.status).to eq(200)
         expect(json_response).to eq(expected_response)
      end

      it "should return a message when no medical records were found in database" do
         response = get "/tests"
         json_response = JSON.parse(response.body)

         expect(response.status).to eq(200)
         expect(json_response).to eq("No medical records found")
      end
   end

   context "POST /import" do
      csv = Rack::Test::UploadedFile.new('./test_data.csv', 'csv')

      it "should import a csv file to database" do
         response = post('/import', csv_file: csv)

         expect(MedicalRecord.all.length).to eq(42)
         expect(response.status).to eq(201)
      end

      it "should return status 500 when no files are assigned to the request" do
         response = post '/import'

         expect(response.status).to eq(500)
      end
   end
end

