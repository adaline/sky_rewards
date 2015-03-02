require File.expand_path '../../spec_helper.rb', __FILE__

describe RewardsModel do
  it "returns correct rewards for a given subscription" do
    expect(RewardsModel.find_reward('SPORTS')).to eq('CHAMPIONS_LEAGUE_FINAL_TICKET')
    expect(RewardsModel.find_reward('KIDS')).to eq(nil)
    expect(RewardsModel.find_reward('MUSIC')).to eq('KARAOKE_PRO_MICROPHONE')
    expect(RewardsModel.find_reward('NEWS')).to eq(nil)
    expect(RewardsModel.find_reward('MOVIES')).to eq('PIRATES_OF_THE_CARIBBEAN_COLLECTION')
  end
end
