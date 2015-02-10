require 'aws-sdk-core'
require 'uuid'

db = Aws::DynamoDB::Client.new(
  endpoint: 'http://localhost:8000', 
  region: 'us-east-1',
  access_key_id: '...',
  secret_access_key:'...'
)

# create the user table
table = 'users'
begin
  rsp = db.create_table(
    table_name: table,
    key_schema: [
      { attribute_name: "id", key_type: "HASH" }
    ],
    attribute_definitions: [
      { attribute_name: "id", attribute_type: "S" }
    ],
    provisioned_throughput: { read_capacity_units: 1, write_capacity_units: 1 }
  )
  puts 'created table :' + rsp.data.table_description.table_name
rescue Exception => e
  puts e.message + ':' + table
end

# create the device table
table = 'devices'
begin
  rsp = db.create_table(
      table_name: table,
      key_schema: [
          { attribute_name: "id", key_type: "HASH" }
      ],
      attribute_definitions: [
          { attribute_name: "id", attribute_type: "S" }
      ],
      provisioned_throughput: { read_capacity_units: 1, write_capacity_units: 1 }
  )
  puts 'created table :' + rsp.data.table_description.table_name
rescue Exception => e
  puts e.message + ':' + table
end

puts "\n----------"
puts 'table list'
puts '----------'
db.list_tables.data.table_names.each { |table|
  puts table
}

id = UUID.new.generate
user = {id:id, name:'jon byrnes', email:'something', devices:[{id:UUID.new.generate, type:'roku'},{id: UUID.new.generate, type:'xbox' }]}

rsp = db.put_item( table_name:'users', item:user )
rsp = db.get_item( table_name:'users', key:{id:id})
puts rsp.data.item


