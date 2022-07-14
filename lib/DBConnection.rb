require 'pg'
require 'yaml'

class DBConnection
   attr_accessor :database, :host, :port, :password, :user

   @@connection=""
   def initialize()
      data_config = YAML.load_file('config/database.yml').transform_keys(&:to_sym)

      @database = data_config[:database]
      @host = data_config[:host]
      @port = data_config[:port]
      @password = data_config[:password]
      @user = data_config[:username]

      plug if @@connection == ""
   end

   def plug
      @@connection = PG::Connection.new(host: @host, user: @user, password: @password, port: @port, dbname: @databse)
      p "Successfully created connection to DB"
   end

   def unplug
      @@connection.finish if @@connection != ""
      p "Successfully closed the connection of DB"
   end

   def sql_write_and_close_connection(string_input)
      plug
      value = @@connection.exec(string_input)
      unplug
      value.to_a
   end

   def sql_write(string_input)
      value = @@connection.exec(string_input)
      value.to_a
   end
end
