#!/usr/bin/env ruby
$: << File.join(File.dirname(__FILE__), "lib")
require "kawana"
k = Kawana::Client.new('localhost')
k.whitelist(IPAddr.new('127.0.0.1'))
