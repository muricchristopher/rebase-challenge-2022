require 'pg'
require 'yaml'
require 'byebug'
class DBConnection
   attr_accessor :database, :host, :port, :password, :user

   @@connection=""
   def initialize(root: false)
      if root
         @host = "postgres_db"
         @port = 5432
         @password = "password"
         @user = "postgres"
      else
         data_config = YAML.load_file('config/database.yml')[ENV['RACK_ENV']].transform_keys(&:to_sym)
         @database = data_config[:database]
         @host = data_config[:host]
         @port = data_config[:port]
         @password = data_config[:password]
         @user = data_config[:username]
      end

      plug if @@connection == ""
   end

   def plug
      @@connection = PG::Connection.new(host: @host, user: @user, password: @password, port: @port, dbname: @database)
   end

   def unplug
      if @@connection != ""
         @@connection.finish
         @@connection = ""
      end
   end

   def sql_write(string_input, params = nil)
      value = @@connection.exec_params(string_input, params)
      value.to_a
   end

   def setup_database(name:)
      return if name.nil?

      sql_write("DROP DATABASE if exists #{name}")
      sql_write("CREATE DATABASE #{name}")

      unplug

      pp "Sucessfully created #{name} database"
   end
end
