require './config/dbconnection.rb'

class MedicalRecord < DBConnection
   def initialize(data)
      super()
      @patient_cpf = data[:cpf]
      @patient_name = data[:nome_paciente]
      @patient_email = data[:email_paciente]
      @patient_birthday = data[:data_nascimento_paciente]
      @patient_address = data[:endereorua_paciente]
      @patient_city = data[:cidade_paciente]
      @patient_state = data[:estado_patiente]
      @doctor_crm = data[:crm_mdico]
      @doctor_name = data[:nome_mdico]
      @doctor_crm_state = data[:crm_mdico_estado]
      @doctor_email = data[:email_mdico]
      @result_token = data[:token_resultado_exame]
      @result_date = data[:data_exame]
      @test_type = data[:tipo_exame]
      @test_limits = data[:limites_tipo_exame]
      @test_result =  data[:resultado_tipo_exame]
   end

   def create
      sql_write("INSERT INTO medical_records (patient_cpf, patient_name, patient_email, patient_birthday, patient_address, patient_city, patient_state, doctor_crm, doctor_crm_state, doctor_name, doctor_email, result_token, result_date, test_type, test_limits, test_result) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)", [@patient_cpf, @patient_name, @patient_email, @patient_birthday, @patient_address, @patient_city, @patient_state, @doctor_crm, @doctor_crm_state, @doctor_name, @doctor_email, @result_token, @result_date, @test_type, @test_limits, @test_result])
   end

   def self.db_prepare
      db_drop_table && db_create_table
   end

   def self.all
      conn = DBConnection.new

      conn.sql_write("SELECT * FROM medical_records")
   end

   private

   def self.db_drop_table
      conn = DBConnection.new

      conn.sql_write("DROP TABLE IF EXISTS medical_records")
   end

   def self.db_create_table
      conn = DBConnection.new

      conn.sql_write("CREATE TABLE medical_records (id SERIAL PRIMARY KEY, patient_cpf TEXT, patient_name TEXT, patient_email TEXT, patient_birthday TEXT, patient_address TEXT, patient_city TEXT, patient_state TEXT, doctor_crm TEXT, doctor_crm_state TEXT, doctor_name TEXT, doctor_email TEXT, result_token TEXT, result_date TEXT, test_type TEXT, test_limits TEXT, test_result TEXT)")
   end
end


