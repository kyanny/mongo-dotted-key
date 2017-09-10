require 'mongo'
require 'logger'
require 'pp'

# Setup
Mongo::Logger.logger = Logger.new(STDOUT, level: 1)
client = Mongo::Client.new('mongodb://127.0.0.1:27017/testing')
coll = client['books']

# Start logging
Mongo::Logger.logger.level = 0

# Insert
id = coll.insert_one({'meta' => {'ok.google' => 'hey.siri'}})

# Update
coll.update_one({"_id" => id}, {'$set' => {'meta' => {'hey.siri' => 'ok.google'}}})
