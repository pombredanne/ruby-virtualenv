require File.dirname(__FILE__) + "/../../lib/sandbox"

begin
  require 'cucumber'
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'cucumber'
  require 'spec'
end