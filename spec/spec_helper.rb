$:.unshift( File.dirname( __FILE__ ) + '/../lib' )

require 'rubygems'
require 'mocha'
require 'rspec'
require 'stringio'
require 'ostruct'
require 'tempfile'

require 'sandbox'

RSpec.configure do |config|
  config.mock_with :mocha

  def capture
    results = OpenStruct.new

    begin
      $stdout = StringIO.new
      $stderr = StringIO.new
      yield
      results.stdout = $stdout.string
      results.stderr = $stderr.string
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end

    results
  end

  alias silence capture
end

# Thanks to Jay Fields for http://blog.jayfields.com/2007/11/ruby-testing-private-methods.html
class Class
  def publicize_methods
    saved_private_instance_methods = self.private_instance_methods
    begin
      self.class_eval { public *saved_private_instance_methods }
      yield
    ensure
      self.class_eval { private *saved_private_instance_methods }
    end
  end
end
