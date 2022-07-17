require 'dotenv/load'
require_relative 'server'

Server.run! if app_file == $0
