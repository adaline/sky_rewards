require File.expand_path '../../spec_helper.rb', __FILE__

describe EligibilityService do
  # Make sure to reset ENV override before each test
  before(:each) do
    ENV.delete 'eligibility'
  end

  subject(:service) { EligibilityService.new }

  it "approves migration to the dark side" do
    expect(service.check(999)).to eq('CUSTOMER_ELIGIBLE')
  end

  it "disapproves of the unworthy" do
    expect(service.check(101)).to eq('CUSTOMER_INELIGIBLE')
  end

  it "provides override mechanism for testing" do
    ENV['eligibility'] = 'CUSTOMER_TESTING'
    expect(service.check(101)).to eq('CUSTOMER_TESTING')
  end

end
