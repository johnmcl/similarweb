module SimilarWeb
  module EstimatedVisits
    # API reference: https://developer.similarweb.com/estimated_visits_api
    def estimated_visits(domain, params = {})
      params[:start] ||= Date.today.prev_month.prev_month(3).strftime("%m-%Y")
      params[:end] ||= Date.today.prev_month(2).strftime("%m-%Y")

      request("#{domain}/v1/visits", params)
    end
  end
end
