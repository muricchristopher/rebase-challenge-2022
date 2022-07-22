# frozen_string_literal: true

require 'dotenv/load'
require_relative 'server'

Server.run! if app_file == $PROGRAM_NAME
