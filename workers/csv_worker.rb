# frozen_string_literal: true

require './lib/medical_record'
require './utils/csv_handler'

class CSVJob
  include Sidekiq::Job
  def perform(csv_text)
    table = CSVHandler.read_text(csv_text)

    table.each do |t|
      med = MedicalRecord.new(t)
      med.create
    end
  end
end
