#!/usr/bin/env ruby

require "sinatra"
require "openssl"
require "base64"

configure do
  enable :inline_templates
end

helpers do
  include ERB::Util
end

set :environment, :production

KEY = ["16407536f308030051d3e6e5da3ee148"].pack("H*")

def encrypt(plaintext)
  cipher = OpenSSL::Cipher.new("aes-128-cbc")
  cipher.encrypt
  cipher.key = KEY
  iv = cipher.random_iv
  cipher.iv = iv
  ciphertext = cipher.update(plaintext)
  ciphertext << cipher.final
  return (iv + ciphertext).unpack('H*')[0]
end

def decrypt(hex_ciphertext)
  ciphertext = [hex_ciphertext].pack('H*')
  cipher = OpenSSL::Cipher.new("aes-128-cbc")
  cipher.decrypt
  cipher.key = KEY
  cipher.iv = ciphertext.slice!(0..15)
  plaintext = cipher.update(ciphertext) << cipher.final
  return plaintext
end

def encrypted_filename_url(filename)
  "/get_file?encrypted_filename=#{encrypt(filename)}"
end

get "/" do
  @title = "Gloria Foster and Mary Alice Fan Club"
  erb :index
end

get "/get_file" do
  filename = decrypt(params["encrypted_filename"].to_s)
  puts "filename: #{filename}"
  send_file(filename)
end


__END__

@@ layout
<!doctype html>
<html>
 <head>
  <title><%= h @title %></title>
  <link rel="stylesheet" href="<%= encrypted_filename_url("fansite_files/stylesheets/test.css") %>" />
 </head>
 <body>
  <h1><%= h @title %></h1>
<%= yield %>
 </body>
</html>

@@ index
<h2>Gloria Foster Facts</h2>
<ul>
 <li>Born November 15, 1933</li>
 <li>University of Illinois</li>
 <li>Won an Obie Award for her performance in the play "In White America"</li>
 <li>She married Clarence Williams III</li>
</ul>
<h2>Mary Alice Facts</h2>
<ul>
 <li>Born December 3, 1941</li>
 <li>Her full name is Mary Alice Smith</li>
 <li>Made her screen debut in The Education of Sonny Carson</li>
 <li>She moved to New York in the 1960s.li>
</ul>
