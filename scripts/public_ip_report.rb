#!/usr/local/bin/ruby

require 'mail'
require 'json'
require 'open-uri'

#Reading the config file:
CONFIG = File.read('/opt/dukkonbot/etc/gmail.json')
options = JSON.parse(CONFIG)

#if the last ip file doesn't exist then create it:
if !File.exist?('/opt/dukkonbot/etc/lastip.json')
  F = File.new("/opt/dukkonbot/etc/lastip.json","w")
  F.puts("{")
  F.puts("\"public_ip\"\ \:\ \"\"")
  F.puts("}")
  F.close	
end

#Open the lastip file and assign the content to the value of lastip:
LASTIP = File.read("/opt/dukkonbot/etc/lastip.json")
lastip = JSON.parse(LASTIP)

#What is my current ip address and compare it with the content of the lastip file:
ip = open('http://checkip.amazonaws.com').read
ip = ip.chomp.strip
if ip.to_s != lastip["public_ip"].to_s
  lastip["public_ip"] = ip.to_s
  puts "New public_ip for dukkon is #{lastip["public_ip"]}"
  File.open("/opt/dukkonbot/etc/lastip.json", "w") do |f|
    f.write(lastip.to_json)
    f.close
  end
  Mail.defaults do 
    delivery_method :smtp, options
  end
  Mail.deliver do
    to 'mhashemi@live.ca'
    from 'dukkonbot@gmail.com'
    subject 'The public ip of dukkon has chnaged!'
    body "#{lastip["public_ip"]}"
  end
end


