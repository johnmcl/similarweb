module SimilarWeb
  module EstimatedVisits
    # API reference: https://developer.similarweb.com/estimated_visits_api
    def estimated_visits(domain, params = {})
      params[:start_date]       ||= Date.today.prev_month.strftime("%m-%Y")
      params[:end_date]         ||= params[:start]
      params[:granularity]      ||= 'daily'
      params[:main_domain_only] ||= false

      request_new("#{domain}/total-traffic-and-engagement/visits", params)
    end
  end
end
