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

# -[3867]% be ruby main.rb
# D, [2017-09-12T02:24:21.725643 #23181] DEBUG -- : MONGODB (0.4ms) testing['$cmd'].find({:insert=>"books", :documents=>[{"_id"=>BSON::ObjectId('59b6c6c56200b05a8d000001'), "meta"=>{"ok.google"=>"hey.siri"}}], :writeConcern=>{:w=>1}, :ordered=>true}).limit(-1)
# D, [2017-09-12T02:24:21.725716 #23181] DEBUG -- : MONGODB (0.5ms) testing['books'].insert({"_id"=>BSON::ObjectId('59b6c6c56200b05a8d000001'), "meta"=>{"ok.google"=>"hey.siri"}})
# D, [2017-09-12T02:24:21.726224 #23181] DEBUG -- : MONGODB (0.3ms) testing['books'].find({})
# [#<Book _id: BSON::ObjectId('59b6c6c56200b05a8d000001'), meta: {"ok.google"=>"hey.siri"}>]
# D, [2017-09-12T02:24:21.727119 #23181] DEBUG -- : MONGODB (0.4ms) testing['$cmd'].find({:update=>"books", :updates=>[{:q=>{:_id=>BSON::ObjectId('59b6c6c56200b05a8d000001')}, :u=>{"_id"=>BSON::ObjectId('59b6c6c56200b05a8d000001'), "meta"=>{}}, :multi=>false, :upsert=>true}], :writeConcern=>{:w=>1}, :ordered=>true, :upsert=>true}).limit(-1)
# D, [2017-09-12T02:24:21.727181 #23181] DEBUG -- : MONGODB (0.5ms) testing['books'].update({:_id=>BSON::ObjectId('59b6c6c56200b05a8d000001')}, {"_id"=>BSON::ObjectId('59b6c6c56200b05a8d000001'), "meta"=>{}})
# D, [2017-09-12T02:24:21.727802 #23181] DEBUG -- : MONGODB (0.3ms) testing['$cmd'].find({:update=>"books", :updates=>[{:q=>{:_id=>BSON::ObjectId('59b6c6c56200b05a8d000001')}, :u=>{"_id"=>BSON::ObjectId('59b6c6c56200b05a8d000001'), "meta"=>{"ok.google"=>"hey.siri"}}, :multi=>false, :upsert=>true}], :writeConcern=>{:w=>1}, :ordered=>true, :upsert=>true}).limit(-1)
# /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/db.rb:630:in `command': Database command 'update' failed: (ok: '1'; nModified: '0'; n: '0'; writeErrors: '[{"index"=>0, "code"=>57, "errmsg"=>"The dotted field 'ok.google' in 'meta.ok.google' is not valid for storage."}]'). (Mongo::OperationFailure)
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection_writer.rb:314:in `block in send_write_command'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/functional/logging.rb:55:in `block in instrument'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/functional/logging.rb:20:in `instrument'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/functional/logging.rb:54:in `instrument'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection_writer.rb:313:in `send_write_command'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection.rb:1104:in `send_write'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection.rb:497:in `update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo-1.12.5/lib/mongo/collection.rb:361:in `save'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/querying.rb:145:in `save_to_collection'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/associations.rb:89:in `save_to_collection'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/safe.rb:27:in `save_to_collection'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/partial_updates.rb:73:in `save_to_collection'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/querying.rb:132:in `update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/callbacks.rb:38:in `block in update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:88:in `__run_callbacks__'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:778:in `_run_update_callbacks'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:81:in `run_callbacks'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/embedded_callbacks.rb:77:in `run_callbacks'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/callbacks.rb:38:in `update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/partial_updates.rb:51:in `update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/querying.rb:123:in `create_or_update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/callbacks.rb:30:in `block in create_or_update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:117:in `call'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:555:in `block (2 levels) in compile'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:505:in `call'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:92:in `__run_callbacks__'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:778:in `_run_save_callbacks'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/activesupport-4.2.9/lib/active_support/callbacks.rb:81:in `run_callbacks'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/embedded_callbacks.rb:77:in `run_callbacks'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/callbacks.rb:30:in `create_or_update'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/querying.rb:104:in `save'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/dirty.rb:17:in `block in save'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/dirty.rb:27:in `clear_changes'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/dirty.rb:17:in `save'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/validations.rb:22:in `save'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/identity_map.rb:87:in `save'
# 	from /Users/kyanny/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/mongo_mapper-0.14.0/lib/mongo_mapper/plugins/querying.rb:109:in `save!'
# 	from main.rb:39:in `<main>'
