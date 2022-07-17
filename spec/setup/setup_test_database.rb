require './config/dbconnection'

def setup_test_database!
   conn = DBConnection.new

   conn.sql_write("TRUNCATE medical_records")
end
