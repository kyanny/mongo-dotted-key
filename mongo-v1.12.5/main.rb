require 'mongo'
require 'logger'
require 'pp'

# Setup
client = Mongo::MongoClient.new('localhost', 27017, logger: Logger.new(STDOUT, level: 1))
db = client['testing']
coll = db['books']

# Start logging
client.logger.level = 0

# Insert
id = coll.insert({'meta' => {'ok.google' => 'hey.siri'}})

# Update
coll.update({"_id" => id}, {'meta' => {'hey.siri' => 'ok.google'}})
