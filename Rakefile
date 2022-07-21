require 'pg'
require './lib/medical_record'

namespace :db do
   task :setup_development do
      conn = DBConnection.new(root: true)
      conn.setup_database(name: "medical_records")

      MedicalRecord.db_prepare
      pp "Sucessfully prepared DB in development environment"
   end

   task :setup_test do
      conn = DBConnection.new(root: true)
      conn.setup_database(name: "medical_records_test")

      MedicalRecord.db_prepare

      pp "Sucessfully prepared DB in test environment"
   end
end
