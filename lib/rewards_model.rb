# A mock class for a rewards model

class RewardsModel
  def self.find_reward(subscription)
    rewards = {
      'SPORTS' => 'CHAMPIONS_LEAGUE_FINAL_TICKET',
      'MUSIC' => 'KARAOKE_PRO_MICROPHONE',
      'MOVIES' => 'PIRATES_OF_THE_CARIBBEAN_COLLECTION'
    }
    if rewards.has_key? subscription
      rewards[subscription]
    else
      nil
    end
  end
end
