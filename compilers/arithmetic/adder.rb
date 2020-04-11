require_relative 'parser.racc.rb'

file_name = ARGV[0]
parser = AddParser.new
parser.prepare_parser(file_name)
parser.do_parse
