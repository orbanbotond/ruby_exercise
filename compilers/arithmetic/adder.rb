#!/usr/bin/ruby

require 'rubygems'
require 'pry'
require 'pry-nav'

require_relative 'parser.racc.rb'

file_name = ARGV[0]
parser = AddParser.new
parser.prepare_parser(file_name)
parser.do_parse
