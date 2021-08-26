#classes
require_relative './classes/text_interface/text_interface'
#modules


ti = TextInterface.new

ti.ask('Test message') ? puts('true') : puts('false')