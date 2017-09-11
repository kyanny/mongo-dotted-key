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

# -[3870]% be ruby main.rb
# D, [2017-09-12T02:25:35.828107 #23338] DEBUG -- : MONGODB (1.0ms) testing['$cmd'].find({:insert=>"books", :documents=>[{"meta"=>{"ok.google"=>"hey.siri"}, :_id=>BSON::ObjectId('59b6c70f6200b05b2a000001')}], :writeConcern=>{:w=>1}, :ordered=>true}).limit(-1)
# D, [2017-09-12T02:25:35.828186 #23338] DEBUG -- : MONGODB (1.2ms) testing['books'].insert({"meta"=>{"ok.google"=>"hey.siri"}, :_id=>BSON::ObjectId('59b6c70f6200b05b2a000001')})
# D, [2017-09-12T02:25:35.828739 #23338] DEBUG -- : MONGODB (0.4ms) testing['$cmd'].find({:update=>"books", :updates=>[{:q=>{"_id"=>BSON::ObjectId('59b6c70f6200b05b2a000001')}, :u=>{"meta"=>{"hey.siri"=>"ok.google"}}, :multi=>false}], :writeConcern=>{:w=>1}, :ordered=>true}).limit(-1)
# /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/db.rb:630:in `command': Database command 'update' failed: (ok: '1'; nModified: '0'; n: '0'; writeErrors: '[{"index"=>0, "code"=>57, "errmsg"=>"The dotted field 'hey.siri' in 'meta.hey.siri' is not valid for storage."}]'). (Mongo::OperationFailure)
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection_writer.rb:314:in `block in send_write_command'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/functional/logging.rb:55:in `block in instrument'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/functional/logging.rb:20:in `instrument'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/functional/logging.rb:54:in `instrument'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection_writer.rb:313:in `send_write_command'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection.rb:1104:in `send_write'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection.rb:497:in `update'
# 	from main.rb:17:in `<main>'
