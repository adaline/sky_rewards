require File.expand_path '../../spec_helper.rb', __FILE__

# Perhaps this spec is surplus given the construction, as the overall API spec confirms this works
# Personally I would not build this test in this perticular case as its duplicates checks
# and makes the test suit too rigid which makes future work a hassle
# Saying that some people love high test coverage no matter the cost!

describe RewardCheck do
  subject (:so) { RewardCheck.new }

  context "if customer is eligible" do
    before(:each) do
      ENV['eligibility'] = 'CUSTOMER_ELIGIBLE'
    end

    it "returns correct rewards" do
      expect(so.call(999, ['SPORTS'])).to eq(['CHAMPIONS_LEAGUE_FINAL_TICKET'])
      expect(so.call(999, ['KIDS'])).to eq([])
      expect(so.call(999, ['MUSIC'])).to eq(['KARAOKE_PRO_MICROPHONE'])
      expect(so.call(999, ['NEWS'])).to eq([])
      expect(so.call(999, ['MOVIES'])).to eq(['PIRATES_OF_THE_CARIBBEAN_COLLECTION'])
    end
  end

  context "if customer is ineligble" do
    before(:each) do
      ENV['eligibility'] = 'CUSTOMER_INELIGIBLE'
    end

    it "returns no rewards" do
      expect(so.call(999, ['SPORTS'])).to eq([])
      expect(so.call(999, ['KIDS'])).to eq([])
      expect(so.call(999, ['MUSIC'])).to eq([])
      expect(so.call(999, ['NEWS'])).to eq([])
      expect(so.call(999, ['MOVIES'])).to eq([])
    end
  end

  context "if eligibility service is down" do
    before(:each) do
      ENV['eligibility'] = 'FAIL'
    end

    it "returns no rewards" do
      expect(so.call(999, ['SPORTS'])).to eq([])
      expect(so.call(999, ['KIDS'])).to eq([])
      expect(so.call(999, ['MUSIC'])).to eq([])
      expect(so.call(999, ['NEWS'])).to eq([])
      expect(so.call(999, ['MOVIES'])).to eq([])
    end
  end

  context "if a customer id is invalid" do
    before(:each) do
      ENV['eligibility'] = '404'
    end

    it "throws an error" do
      expect {so.call(999, ['SPORTS'])}.to raise_error("INVALID_CLIENT_ID")
    end
  end
end
