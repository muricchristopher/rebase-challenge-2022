require 'pg'
require './lib/medical_record'
require 'byebug'

namespace :db do
   task :setup_development do
      ENV['RACK_ENV'] ||= 'development'

      conn = DBConnection.new(root: true)
      conn.setup_database(name: "medical_records")

      MedicalRecord.db_prepare
      pp "Sucessfully prepared DB in development environment"
   end

   task :setup_test do
      ENV['RACK_ENV'] = 'test'

      conn = DBConnection.new(root: true)
      conn.setup_database(name: "medical_records_test")

      MedicalRecord.db_prepare

      ENV['RACK_ENV'] = 'development'
   end

   task :create do
      ENV['RACK_ENV'] ||= 'development'

      MedicalRecord.db_create
   end

   task :drop do
      ENV['RACK_ENV'] ||= 'development'

      MedicalRecord.db_drop
   end
end
