require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require './lib/medical_record'
require './utils/csv_handler'
require 'bundler'
require 'byebug'
require 'pry'

Bundler.require
class Server < Sinatra::Base
  set :server, 'puma'
  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests' do
    @tests = MedicalRecord.all

    return "No medical records found".to_json if @tests.empty?

    jbuilder :tests
  end

  post "/import" do
    file = params["csv_file"]["tempfile"]
    csv = CSVHandler.read_file(file)

    begin
      csv.each do | row |
        MedicalRecord.new(row).create
      end
      201
    rescue
      422
    end
  end

end
