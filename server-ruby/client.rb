# Created by Huynh Quang Thao on 04/11/2017
this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'message_services_pb'

HOST = '10.247.227.63'
PORT = '50051'

def main
  stub = Sphinyx::ChatService::Stub.new(HOST + ":" + PORT, :this_channel_is_insecure)
  message = stub.connect(Sphinyx::ChatRequest.new(id: rand(20).to_s, client: 'Ruby')).message
  puts "Greeting: #{message}"
end

main
