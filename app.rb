require 'bundler/setup'
require 'sinatra'
require 'json'
require './lib/reward_check'


class RewardService < Sinatra::Base

  # set :show_exceptions, false

  before do
    content_type 'application/json'
  end

  not_found do
    { status: 'Account number invalid', rewards: [] }.to_json
  end

  error do
    { status: 'Server error', rewards: [] }.to_json
  end

  post '/' do
    begin
      payload = JSON.parse(request.body.read)
      client_id = payload['client_id']
      portfolio = payload['portfolio']

      reward_check = RewardCheck.new
      rewards = reward_check.call(client_id, portfolio)

			{ status: 'OK', rewards: rewards }.to_json
    rescue RuntimeError => e
      not_found
		rescue Exception => e
      puts e.message
      error
    end
  end
end
