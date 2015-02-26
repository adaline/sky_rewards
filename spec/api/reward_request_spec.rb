require File.expand_path '../../spec_helper.rb', __FILE__

describe RewardService do

  # Helper to parse response JSON into a hash
  def response_hash
    JSON.parse(last_response.body.to_s)
  end

  def json_post_helper(url, data)
    post url, data.to_json, {'Content-Type' => 'application/json'}
  end

  context "if the customer is eligible" do

    def test_reward(client_id, portfolio, rewards)
      json_post_helper('/', {client_id: client_id, portfolio: portfolio})
      expect(response_hash).to eq({'status' => 'OK', 'rewards' => rewards})
    end

    before(:each) do
      ENV['eligibility'] = 'CUSTOMER_ELIGIBLE'
    end

    it "return relevant rewards for each subscription" do
      test_reward(999, ['SPORTS'], ['CHAMPIONS_LEAGUE_FINAL_TICKET'])
      test_reward(999, ['KIDS'], [])
      test_reward(999, ['MUSIC'], ['KARAOKE_PRO_MICROPHONE'])
      test_reward(999, ['NEWS'], [])
      test_reward(999, ['MOVIES'], ['PIRATES_OF_THE_CARIBBEAN_COLLECTION'])
    end

    it "returns relevant rewards for a number of subscriptions" do
      test_reward(999, ['SPORTS','KIDS','MUSIC'], ['CHAMPIONS_LEAGUE_FINAL_TICKET','KARAOKE_PRO_MICROPHONE'])
    end
  end
  context "if the customer is not eligible" do
    before(:each) do
      ENV['eligibility'] = 'CUSTOMER_INELIGIBLE'
    end

    it "returns no rewards" do
      json_post_helper('/', {clinet_id: 999, portfolio: ['SPORTS','KIDS','MUSIC']})
      expect(response_hash).to eq({'status' => 'OK', 'rewards' => []})
    end
  end

  context "if there is a technical falire with eligibility" do
    before(:each) do
      ENV['eligibility'] = 'FAIL'
    end

    it "returns no rewards" do
      json_post_helper('/', {clinet_id: 999, portfolio: ['SPORTS','KIDS','MUSIC']})
      expect(response_hash).to eq({'status' => 'OK', 'rewards' => []})
    end
  end

  context "if the customer number is invalid" do
    before(:each) do
      ENV['eligibility'] = '404'
    end

    it "returns no rewards" do
      json_post_helper('/', {clinet_id: 999, portfolio: ['SPORTS','KIDS','MUSIC']})
      expect(response_hash['rewards']).to eq([])
    end

    it "notifies client the account number is invalid" do
      json_post_helper('/', {clinet_id: 999, portfolio: ['SPORTS','KIDS','MUSIC']})
      expect(response_hash['status']).to eq('Account number invalid')
    end
  end
end
