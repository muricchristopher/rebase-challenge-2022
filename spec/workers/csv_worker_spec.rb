require 'spec_helper'
require './workers/csv_worker'
require './lib/medical_record'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe CSVJob do
   context 'perform' do
      it "should import an csv text directly to database" do
         csv_text = "cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame\n048.973.170-88;Emilly Batista Neto;gerald.crona@ebert-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;IQCZ17;2021-08-05;hemácias;45-52;97\n048.108.026-04;Juliana dos Reis Filho;mariana_crist@kutch-torp.com;1995-07-03;527 Rodovia Júlio;Lagoa da Canoa;Paraíba;B0002IQM66;SC;Maria Helena Ramalho;rayford@kemmer-kunze.info;0W9I67;2021-07-09;hemácias;45-52;28\n066.126.400-90;Matheus Barroso;maricela@streich.com;1972-03-09;9378 Rua Stella Braga;Senador Elói de Souza;Pernambuco;B000B7CDX4;SP;Sra. Calebe Louzada;kendra@nolan-sawayn.co;T9O6AI;2021-11-21;hemácias;45-52;48\n"

         CSVJob.new.perform(csv_text)
         query = MedicalRecord.all

         expect(query.length).to eq(3)
         expect(query[0]["patient_cpf"]).to eq("048.973.170-88")
         expect(query[0]["patient_name"]).to eq("Emilly Batista Neto")
         expect(query[0]["result_token"]).to eq("IQCZ17")
         expect(query[1]["patient_cpf"]).to eq("048.108.026-04")
         expect(query[1]["patient_name"]).to eq("Juliana dos Reis Filho")
         expect(query[1]["result_token"]).to eq("0W9I67")
         expect(query[2]["patient_cpf"]).to eq("066.126.400-90")
         expect(query[2]["patient_name"]).to eq("Matheus Barroso")
         expect(query[2]["result_token"]).to eq("T9O6AI")
      end
   end
end

