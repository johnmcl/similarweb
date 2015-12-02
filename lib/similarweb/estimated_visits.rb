module SimilarWeb
    module EstimatedVisits
        # API reference: https://developer.similarweb.com/estimated_visits_api
        def estimated_visits(domain)
            prev_date = Date.today.prev_month.prev_month(3).strftime("%m-%Y")
            curr_date = Date.today.prev_month(2).strftime("%m-%Y")
            response = self.http_client.get "#{domain}/v1/visits?start=#{prev_date}&end=#{curr_date}&Format=JSON&UserKey=#{self.api_key}"
            JSON(response.body)
        end
    end
end
