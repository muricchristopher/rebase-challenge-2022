require 'csv'
require 'byebug'
require './lib/medical_record'
require './utils/csv_handler.rb'

ENV['RACK_ENV'] = 'development'

def import_to_db(file)
   csv = CSVHandler.read_file(file)

   csv.each_with_index do | row, index|
      MedicalRecord.new(row).create
      print "Importing... [#{index + 1}/#{csv.length}]\n"
   end

   print "## CSV imported succesfully! ## \n"
end

import_to_db("data.csv")
