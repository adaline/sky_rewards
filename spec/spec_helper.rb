ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'

require File.expand_path '../../app.rb', __FILE__


module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }
