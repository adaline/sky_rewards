# Mock for EligibilityService

class EligibilityService
  def check(account_number)
    # Return override from ENV if present
    if ENV.has_key? 'eligibility'
      ENV['eligibility']
    else
      if account_number == 999
        'CUSTOMER_ELIGIBLE'
      else
        'CUSTOMER_INELIGIBLE'
      end
    end
  end
end
