require 'pg'
require 'yaml'

class DBConnection
   attr_accessor :database, :host, :port, :password, :user

   @@connection=""
   def initialize()
      data_config = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)), 'database.yml')).transform_keys(&:to_sym)

      @database = data_config[:database]
      @host = data_config[:host]
      @port = data_config[:port]
      @password = data_config[:password]
      @user = data_config[:username]

      plug if @@connection == ""
   end

   def plug
      @@connection = PG::Connection.new(host: @host, user: @user, password: @password, port: @port, dbname: @databse)
   end

   def unplug
      @@connection.finish if @@connection != ""
   end

   def sql_write(string_input, params = nil)
      value = @@connection.exec_params(string_input, params)
      value.to_a
   end
end
