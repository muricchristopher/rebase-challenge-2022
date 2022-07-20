require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require './lib/medical_record'
require './utils/csv_handler'
require 'bundler'
require 'sidekiq'
require './workers/csv_worker'

Bundler.require

Sidekiq.configure_server do |config|
  config.redis = {
    host: 'redis',
    port: ENV['REDIS_PORT']
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    host: 'redis',
    port: ENV['REDIS_PORT']
  }
end
class Server < Sinatra::Base
  set :server, 'puma'
  set :bind, '0.0.0.0'
  set :port, 3000

  get '/tests' do
    @tests = MedicalRecord.all

    return "No medical records found".to_json if @tests.empty?

    jbuilder :tests
  end

  get '/tests/:token' do
    content_type :json
    token = params["token"]

    @tests = MedicalRecord.find_test_by_token(token)

    return [404, { :error => "Could not find a medical record with token -> #{token}" }.to_json] if @tests.empty?

    jbuilder :tests_by_token
  end

  post "/import_sync" do
    file = params["csv_file"]["tempfile"]
    csv = CSVHandler.read_file(file)

    begin
      csv.each do | row |
        MedicalRecord.new(row).create
      end
      [201, { message: 'File successfully imported to DB' }.to_json]
    rescue
      422
    end
  end

  post "/import" do
    csv_text = File.read(params["csv_file"]["tempfile"])

    begin
      CSVJob.perform_async(csv_text)
      [201, { message: 'File successfully queued to be imported' }.to_json]
    rescue
      422
    end
  end
end
