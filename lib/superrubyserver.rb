require "superrubyserver/version"

module Superrubyserver
#!/usr/bin/env ruby
require 'socket'

server = TCPServer.new 1337

  loop do
    client = server.accept
     puts request = client.gets

     verb, path, protocol = request.split(" ") # ["GET", "/", "HTTP/1.1"]
     path = "." + path

     if File.file?(path)
      body = File.open(path, "r") {|file| file.read}
      status = "200 OK"
    else
      body = "File not found\n"
      status = "404 Not Found"
    end

     response = "HTTP/1.1 200 OK\n"
     response += "Content-Type: text/html\n"
     response += "Content-Length: #{body.length}\n "
     response += "Conecction: close\n\n"
     response += body

     client.puts response
    client.close
  end

end
