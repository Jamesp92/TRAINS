require 'rspec'
require 'pg'
require 'city'
# require 'train'
require 'pry'
require'spec_helper'

DB = PG.connect({dbname: 'train_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM stops *;")
  end
end