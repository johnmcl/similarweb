module SimilarWeb
  module EstimatedVisits
    # API reference: https://developer.similarweb.com/estimated_visits_api
    # This is for old API
    def estimated_visits(domain, params = {})
      params[:start] ||= Date.today.prev_month.prev_month(3).strftime("%m-%Y")
      params[:end] ||= Date.today.prev_month(2).strftime("%m-%Y")

      request_old("#{domain}/v1/visits", params)
    end
  end
end