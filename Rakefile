require 'pg'
require './lib/medical_record'

namespace :db do
   task :setup do
      MedicalRecord.db_setup
   end

   task :create do
      MedicalRecord.db_create
   end

   task :drop do
      MedicalRecord.db_drop
   end
end
