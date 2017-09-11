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

# -[3872]% be ruby main.rb
# D, [2017-09-12T02:26:04.206602 #23455] DEBUG -- : MONGODB | 127.0.0.1:27017 | testing.insert | STARTED | {"insert"=>"books", "documents"=>[{"meta"=>{"ok.google"=>"hey.siri"}, :_id=>BSON::ObjectId('59b6c72c6200b05b9fcb9ea6')}], "ordered"=>true}
# D, [2017-09-12T02:26:04.206807 #23455] DEBUG -- : MONGODB | 127.0.0.1:27017 | testing.insert | FAILED | 'ok.google' is an illegal key in MongoDB. Keys may not start with '$' or contain a '.'. | 6.2e-05s
# /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/string.rb:69:in `to_bson_key': 'ok.google' is an illegal key in MongoDB. Keys may not start with '$' or contain a '.'. (BSON::String::IllegalKey)
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:45:in `block in to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:43:in `each'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:43:in `to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:46:in `block in to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:43:in `each'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:43:in `to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/array.rb:49:in `block in to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/array.rb:46:in `each'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/array.rb:46:in `each_with_index'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/array.rb:46:in `to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:46:in `block in to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:43:in `each'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/bson-4.2.2/lib/bson/hash.rb:43:in `to_bson'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/protocol/serializers.rb:163:in `serialize'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/protocol/message.rb:213:in `block in serialize_fields'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/protocol/message.rb:201:in `each'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/protocol/message.rb:201:in `serialize_fields'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/protocol/message.rb:104:in `serialize'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server/connection.rb:207:in `block in write'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server/connection.rb:206:in `each'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server/connection.rb:206:in `write'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server/connection.rb:176:in `deliver'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server/connection.rb:108:in `block in dispatch'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/monitoring/publishable.rb:47:in `publish_command'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server/connection.rb:107:in `dispatch'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/operation/write/command/writable.rb:39:in `block in execute'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server/connection_pool.rb:107:in `with_connection'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/server.rb:247:in `with_connection'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/operation/write/command/writable.rb:38:in `execute'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/operation/write/insert.rb:55:in `execute_write_command'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/operation/write/write_command_enabled.rb:41:in `execute'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/collection.rb:362:in `block in insert_one'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/retryable.rb:104:in `write_with_retry'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-2.4.3/lib/mongo/collection.rb:353:in `insert_one'
# 	from main.rb:14:in `<main>'
