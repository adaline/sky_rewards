require File.expand_path '../eligibility_service.rb', __FILE__
require File.expand_path '../rewards_model.rb', __FILE__

# Service object for fetching rewards based on subscriptions
class RewardCheck
  def call(client_id, subscriptions)
    # Check client is eligible
    eligible_service = EligibilityService.new
    eligible_result = eligible_service.check client_id
    case eligible_result
      when 'CUSTOMER_ELIGIBLE'
        find_rewards(subscriptions).compact
      when 'CUSTOMER_INELIGIBLE'
        []
      when 'FAIL'
        []
      when '404'
        raise 'INVALID_CLIENT_ID'
    end
  end

  def find_rewards(subscriptions)
    subscriptions.map{ |subscription|  RewardsModel.find_reward(subscription) }
  end
end
