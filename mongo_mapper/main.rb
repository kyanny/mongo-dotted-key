require 'active_model'
require 'mongo_mapper'
require 'pp'

# Setup
MongoMapper.setup(
  {
    'development' => {
      'host' => '127.0.0.1',
      'port' => 27017,
      'database' => 'testing',
    },
  }, # config
  'development', # env
  logger: Logger.new(STDOUT, level: 1) # options
)

class Book
  include MongoMapper::Document
  key :meta, Hash
end

# Cleanup
Book.destroy_all

# Start logging
MongoMapper.connection.logger.level = 0

# Create
book = Book.create!('meta' => {'ok.google' => 'hey.siri'})

# Dump
pp Book.all

# Update
book.meta = {}
book.save!
book.meta = {'ok.google' => 'hey.siri'}
book.save!
