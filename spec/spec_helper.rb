require 'rubygems'
require 'rspec'

$:.unshift(File.dirname(File.expand_path(__FILE__)))

require File.join(File.dirname(File.expand_path(__FILE__)), "..", "lib", "mongo_utils")

require 'active_support'
require 'mongoid'

Mongoid.database = Mongo::Connection.new.db('mongo_utils_test')
Dir['spec/models/*'].each { |f| require File.expand_path(f) }

RSpec.configure do |c|
end
