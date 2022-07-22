# frozen_string_literal: true

require './config/dbconnection'

def setup_test_database!
  conn = DBConnection.new

  conn.sql_write('TRUNCATE medical_records')
end
