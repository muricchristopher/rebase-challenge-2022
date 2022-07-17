require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require './lib/medical_record'
require 'bundler'
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
end
