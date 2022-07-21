require 'spec_helper'
require './lib/medical_record'
require './config/dbconnection'

describe MedicalRecord do
   context "#create" do
      it "should insert medical records into database" do
         @database = DBConnection.new

         data = {:cpf=>"048.973.170-88", :nome_paciente=>"Emilly Batista Neto", :email_paciente=>"gerald.crona@ebert-quigley.com", :data_nascimento_paciente=>"2001-03-11", :endereorua_paciente=>"165 Rua Rafaela", :cidade_paciente=>"Ituverava", :estado_patiente=>"Alagoas", :crm_mdico=>"B000BJ20J4", :crm_mdico_estado=>"PI", :nome_mdico=>"Maria Luiza Pires", :email_mdico=>"denna@wisozk.biz", :token_resultado_exame=>"IQCZ17", :data_exame=>"2021-08-05", :tipo_exame=>"hemácias", :limites_tipo_exame=>"45-52", :resultado_tipo_exame=>"97"}

         medical_record = MedicalRecord.new(data)
         medical_record.create

         query = @database.sql_write("SELECT * FROM medical_records")
         expect(query.length).to eq(1)
         expect(query[0]["patient_cpf"]).to eq("048.973.170-88")
         expect(query[0]["patient_birthday"]).to eq("2001-03-11")
         expect(query[0]["doctor_crm_state"]).to eq("PI")
         expect(query[0]["doctor_email"]).to eq("denna@wisozk.biz")
         expect(query[0]["test_limits"]).to eq("45-52")
      end
   end

   context "self.all" do
      it "should return all medical records in the database" do
         first_data = {:cpf=>"048.973.170-88", :nome_paciente=>"Emilly Batista Neto", :email_paciente=>"gerald.crona@ebert-quigley.com", :data_nascimento_paciente=>"2001-03-11", :endereorua_paciente=>"165 Rua Rafaela", :cidade_paciente=>"Ituverava", :estado_patiente=>"Alagoas", :crm_mdico=>"B000BJ20J4", :crm_mdico_estado=>"PI", :nome_mdico=>"Maria Luiza Pires", :email_mdico=>"denna@wisozk.biz", :token_resultado_exame=>"IQCZ17", :data_exame=>"2021-08-05", :tipo_exame=>"hemácias", :limites_tipo_exame=>"45-52", :resultado_tipo_exame=>"97"}
         second_data = {:cpf=>"041.222.111-85", :nome_paciente=>"João Pereira Bastos", :email_paciente=>"joao.crona@ebert-quigley.com", :data_nascimento_paciente=>"2004-02-11", :endereorua_paciente=>"165 Rua Dos Andares", :cidade_paciente=>"SP", :estado_patiente=>"São Paulo", :crm_mdico=>"5AAACD2345", :crm_mdico_estado=>"PI", :nome_mdico=>"Joana Albuquerque", :email_mdico=>"joana@wisozk.biz", :token_resultado_exame=>"ACDA13", :data_exame=>"2021-06-05", :tipo_exame=>"hemácias", :limites_tipo_exame=>"87-94", :resultado_tipo_exame=>"97"}

         first_medical_record = MedicalRecord.new(first_data)
         second_medical_record = MedicalRecord.new(second_data)
         first_medical_record.create && second_medical_record.create

         query = MedicalRecord.all
         expect(query.length).to eq(2)
         expect(query[0]["patient_cpf"]).to eq("048.973.170-88")
         expect(query[0]["patient_name"]).to eq("Emilly Batista Neto")
         expect(query[0]["patient_city"]).to eq("Ituverava")
         expect(query[0]["doctor_crm"]).to eq("B000BJ20J4")
         expect(query[0]["doctor_email"]).to eq("denna@wisozk.biz")
         expect(query[0]["result_token"]).to eq("IQCZ17")
         expect(query[0]["test_result"]).to eq("97")
         expect(query[1]["patient_cpf"]).to eq("041.222.111-85")
         expect(query[1]["patient_name"]).to eq("João Pereira Bastos")
         expect(query[1]["patient_city"]).to eq("SP")
         expect(query[1]["doctor_crm"]).to eq("5AAACD2345")
         expect(query[1]["doctor_email"]).to eq("joana@wisozk.biz")
         expect(query[1]["result_token"]).to eq("ACDA13")
         expect(query[1]["test_result"]).to eq("97")
      end

      it "should return an empty array if no medical records were registered" do
         query = MedicalRecord.all

         expect(query).to eq([])
      end
   end

   context "self.db_prepare" do
      it "should prepare database" do
         data = {:cpf=>"048.973.170-88", :nome_paciente=>"Emilly Batista Neto", :email_paciente=>"gerald.crona@ebert-quigley.com", :data_nascimento_paciente=>"2001-03-11", :endereorua_paciente=>"165 Rua Rafaela", :cidade_paciente=>"Ituverava", :estado_patiente=>"Alagoas", :crm_mdico=>"B000BJ20J4", :crm_mdico_estado=>"PI", :nome_mdico=>"Maria Luiza Pires", :email_mdico=>"denna@wisozk.biz", :token_resultado_exame=>"IQCZ17", :data_exame=>"2021-08-05", :tipo_exame=>"hemácias", :limites_tipo_exame=>"45-52", :resultado_tipo_exame=>"97"}

         medical_record = MedicalRecord.new(data)
         medical_record.create

         MedicalRecord.db_prepare

         expect(MedicalRecord.all).to eq([])
      end
   end
end


