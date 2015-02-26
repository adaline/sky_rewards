require 'sinatra'
require 'json'


class RewardService < Sinatra::Base

  set :show_exceptions, false

  before do
    content_type 'application/json'
  end

  not_found do
    { status: 'Account number invalid' }.to_json
  end

  error do
    { status: 'Server error' }.to_json
  end

  post '/' do
    begin
			{ status: 'OK', rewards: [] }.to_json
		rescue Exception => e
      puts e.message
      error
    end
  end
end
