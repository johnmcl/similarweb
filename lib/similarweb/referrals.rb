module Similarweb
  module Referrals
    def referrals(domain)
      response = self.http_client.get "#{domain}/v2/leadingreferringsites?Format=JSON&UserKey=#{self.api_key}"
      JSON(response.body)
    end
  end
end