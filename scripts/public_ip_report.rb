#!/usr/local/bin/ruby

require 'mail'
require 'json'
#		:port		=> 587,
#		:domain		=> 'dukkon.rodvin.ca',
#		:user_name	=> "dukkonbot@gmail.com",
#		:password	=> "\:YnLG\]i-I\{kDM\}i5C\'qmIC\=\^",
#		:authentication	=> 'plain',
#		:enable_starttls_auto => true }
#
config = File.read('/opt/dukkonbot/etc/gmail.json')
options = JSON.parse(config)
puts options

