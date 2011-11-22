$:.unshift(File.dirname(File.expand_path(__FILE__)))

module MongoUtils
  autoload :Aggregation, 'mongo_utils/aggregation'
end
