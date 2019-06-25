require "rubygems"
require "bunny"

STDOUT.sync = true

conn = Bunny.new
conn.start

ch = conn.create_channel
q  = ch.queue("bunny.examples.hello_world_2", :auto_delete => false)
x  = ch.fanout("aus.eng")

q.subscribe do |delivery_info, metadata, payload|
  puts "Received #{payload}"
end

x.publish("Hello bang!", :routing_key => q.name)

sleep 1.0
conn.close