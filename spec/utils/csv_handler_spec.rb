require 'spec_helper'
require './utils/csv_handler'

describe CSVHandler do
  context 'self.read_file' do
    it 'should read a csv file and return a table csv class' do
      read_file = CSVHandler.read_file("./spec/fixtures/data_example.csv")

      expect(read_file.length).to eq(3)
      expect(read_file.class).to eq(CSV::Table)
    end

    context "self.read_text" do
      it "should read a text formatted in csv and return a table csv class" do
        csv_text = "cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame\n048.973.170-88;Emilly Batista Neto;gerald.crona@ebert-quigley.com;2001-03-11;165 Rua Rafaela;Ituverava;Alagoas;B000BJ20J4;PI;Maria Luiza Pires;denna@wisozk.biz;IQCZ17;2021-08-05;hemácias;45-52;97\n048.108.026-04;Juliana dos Reis Filho;mariana_crist@kutch-torp.com;1995-07-03;527 Rodovia Júlio;Lagoa da Canoa;Paraíba;B0002IQM66;SC;Maria Helena Ramalho;rayford@kemmer-kunze.info;0W9I67;2021-07-09;hemácias;45-52;28\n066.126.400-90;Matheus Barroso;maricela@streich.com;1972-03-09;9378 Rua Stella Braga;Senador Elói de Souza;Pernambuco;B000B7CDX4;SP;Sra. Calebe Louzada;kendra@nolan-sawayn.co;T9O6AI;2021-11-21;hemácias;45-52;48\n"

        read_csv_text = CSVHandler.read_text(csv_text)
        gi
        expect(read_csv_text.length).to eq(3)
        expect(read_csv_text.class).to eq(CSV::Table)
      end
    end
  end
end

