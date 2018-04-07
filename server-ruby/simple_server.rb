# Created by Huynh Quang Thao on 04/11/2017

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'message_services_pb'

# Override all methods in proto file here
class GrpcChatServer < Sphinyx::ChatService::Service
  @clients = []

  def connect(hello_req, _unused_call)
    puts "Hello Client:#{hello_req.client} with id=#{hello_req.id}"
    new_id = "#{hello_req.client}-#{hello_req.id}"
    Sphinyx::ChatResponse.new(id: new_id, message: "Hello #{new_id}")
  end

  def send_message(request, unused_call)
    Sphinyx::ChatResponse.new(message: "Hello. I'm from server. Hehe")
  end
end

def main
  puts 'Create GRPC Server'
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(GrpcChatServer)
  s.run_till_terminated
end

main

