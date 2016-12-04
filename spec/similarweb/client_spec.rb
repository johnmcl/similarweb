require 'spec_helper'

describe SimilarWeb::Client do
  before do
    @client = SimilarWeb::Client.new(api_key: 'test-key')
  end

  describe '.api_key' do
    it 'should return the api key' do
      expect( @client.api_key ).to eq('test-key')
    end
  end

  describe '.referrals' do
    before(:each) do
      body = <<-eos
        {
         "Sites": [
          "bleacherreport.com",
          "spox.com",
          "sportal.com.au",
          "espn.go.com",
          "en.wikipedia.org",
          "nba.co.jp",
          "search.tb.ask.com",
          "gazzetta.it",
          "baloncesto.as.com",
          "forums.realgm.com"
         ],
         "StartDate": "01/2014",
         "EndDate": "03/2014"
        }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v2/leadingreferringsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @referrals = @client.referrals('example.com')
    end

    it 'should return a list of referral sites' do
      expect( @referrals ).to have_key('Sites')
      expect( @referrals['Sites']).to be_a(Array)
    end
  end

  describe '.keywords' do
    before(:each) do
      body = <<-eos
        {
         "OrganicSearchShare": 0.9894885348395134,
         "PaidSearchShare": 0.010511465160486622,
         "TopOrganicTerms": [
          "nba",
          "nba.com",
          "nba standings",
          "nba league pass",
          "miami heat",
          "nba store",
          "lakers",
          "chicago bulls",
          "knicks",
          "houston rockets"
         ],
         "TopPaidTerms": [
          "nba store",
          "nba",
          "nba league pass",
          "nba shop",
          "nba.com",
          "orlando magic",
          "portland trail blazers",
          "miami heat",
          "nba jerseys",
          "celtics"
         ],
         "StartDate": "01/2014",
         "EndDate": "03/2014"
        }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v1/searchintelligence?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @keywords = @client.keywords('example.com')
    end

    it 'should return a ratio of organic search share' do
      expect( @keywords ).to have_key('OrganicSearchShare')
    end

    it 'should return a ratio of paid search share' do
      expect( @keywords ).to have_key('PaidSearchShare')
    end

    it 'should return a list of top organic search terms' do
      expect( @keywords ).to have_key('TopOrganicTerms')
      expect( @keywords['TopOrganicTerms'] ).to be_a(Array)
    end

    it 'should return a list of top paid terms' do
      expect( @keywords ).to have_key('TopPaidTerms')
      expect( @keywords['TopPaidTerms'] ).to be_a(Array)
    end
  end

  describe '.estimated_visits' do
    before(:each) do
      body = <<-eos
        {
         "Visits": 81178601
        }
      eos

      prev_date = Date.today.prev_month.prev_month(3).strftime("%m-%Y")
      curr_date = Date.today.prev_month(2).strftime("%m-%Y")

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v1/visits?Format=JSON&UserKey=test-key&start=#{prev_date}&end=#{curr_date}").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @estimated_visitors = @client.estimated_visits('example.com')
    end

    it 'should have visits' do
      expect( @estimated_visitors ).to have_key('Visits')
    end
  end

  describe '.visits' do
    before(:each) do
      body = <<-eos
        {
          "meta":{
            "request":{
              "granularity":"Monthly",
              "main_domain_only":false,
              "domain":"example.com",
              "start_date":"2016-02-01",
              "end_date":"2016-03-31",
              "country":"world"
            },
            "status":"Success",
            "last_updated":"2016-08-31"
          },
          "visits":[
            {
              "date":"2016-02-01",
              "visits":120678.0
            },
            {
              "date":"2016-03-01",
              "visits":121999.0
            }
          ]
        }
      eos

      prev_date = Date.new(2016, 2, 1).strftime("%Y-%m")
      curr_date = Date.new(2016, 3, 1).strftime("%Y-%m")

      stub_request(:get, "https://api.similarweb.com/v1/website/example.com/total-traffic-and-engagement/visits?api_key=test-key&start_date=#{prev_date}&end_date=#{curr_date}&main_domain_only=false&granularity=monthly").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @visitors = @client.visits('example.com', granularity: 'monthly', start_date: prev_date, end_date: curr_date)
    end

    it 'should have visits' do
      expect( @visitors ).to have_key('visits')
    end
  end

  describe '.bounce_rate' do
    before(:each) do
      body = <<-eos
        {
          "meta":{
            "request":{
              "granularity":"Monthly",
              "main_domain_only":false,
              "domain":"example.com",
              "start_date":"2016-02-01",
              "end_date":"2016-03-31",
              "country":"world"
            },
            "status":"Success",
            "last_updated":"2016-08-31"
          },
          "bounce_rate":[
            {
              "date":"2016-02-01",
              "bounce_rate":0.84267223520442835
            },
            {
              "date":"2016-03-01",
              "bounce_rate":0.84377740801154111
            }
          ]
        }
      eos

      prev_date = Date.new(2016, 2, 1).strftime("%Y-%m")
      curr_date = Date.new(2016, 3, 1).strftime("%Y-%m")

      stub_request(:get, "https://api.similarweb.com/v1/website/example.com/total-traffic-and-engagement/bounce-rate?api_key=test-key&start_date=#{prev_date}&end_date=#{curr_date}&main_domain_only=false&granularity=monthly").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @bounce_rate = @client.bounce_rate('example.com', granularity: 'monthly', start_date: prev_date, end_date: curr_date)
    end

    it 'should have bounce_rate' do
      expect( @bounce_rate ).to have_key('bounce_rate')
    end
  end

  describe '.pages_per_visit' do
    before(:each) do
      body = <<-eos
        {
          "meta":{
            "request":{
              "granularity":"Monthly",
              "main_domain_only":false,
              "domain":"example.com",
              "start_date":"2016-02-01",
              "end_date":"2016-03-31",
              "country":"world"
            },
            "status":"Success",
            "last_updated":"2016-08-31"
          },
          "pages_per_visit":[
            {
              "date":"2016-02-01",
              "pages_per_visit":1.3114237889259022
            },
            {
              "date":"2016-03-01",
              "pages_per_visit":1.2965106271362883
            }
          ]
        }
      eos

      prev_date = Date.new(2016, 2, 1).strftime("%Y-%m")
      curr_date = Date.new(2016, 3, 1).strftime("%Y-%m")

      stub_request(:get, "https://api.similarweb.com/v1/website/example.com/total-traffic-and-engagement/pages-per-visit?api_key=test-key&start_date=#{prev_date}&end_date=#{curr_date}&main_domain_only=false&granularity=monthly").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @pages_per_visit = @client.pages_per_visit('example.com', granularity: 'monthly', start_date: prev_date, end_date: curr_date)
    end

    it 'should have pages_per_visit' do
      expect( @pages_per_visit ).to have_key('pages_per_visit')
    end
  end

  describe '.average_visit_duration' do
    before(:each) do
      body = <<-eos
        {
          "meta":{
            "request":{
              "granularity":"Monthly",
              "main_domain_only":false,
              "domain":"example.com",
              "start_date":"2016-02-01",
              "end_date":"2016-03-31",
              "country":"world"
            },
            "status":"Success",
            "last_updated":"2016-08-31"
          },
          "average_visit_duration":[
            {
              "date":"2016-02-01",
              "average_visit_duration":47.9424750161587
            },
            {
              "date":"2016-03-01",
              "average_visit_duration":46.811064025114959
            }
          ]
        }
      eos

      prev_date = Date.new(2016, 2, 1).strftime("%Y-%m")
      curr_date = Date.new(2016, 3, 1).strftime("%Y-%m")

      stub_request(:get, "https://api.similarweb.com/v1/website/example.com/total-traffic-and-engagement/average-visit-duration?api_key=test-key&start_date=#{prev_date}&end_date=#{curr_date}&main_domain_only=false&granularity=monthly").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @average_visit_duration = @client.average_visit_duration('example.com', granularity: 'monthly', start_date: prev_date, end_date: curr_date)
    end

    it 'should have average_visit_duration' do
      expect( @average_visit_duration ).to have_key('average_visit_duration')
    end
  end

  describe '.global_rank' do
    before(:each) do
      body = <<-eos
        {
          "meta":{
            "request":{
              "domain":"example.com",
              "start_date":"2016-02-01",
              "end_date":"2016-03-31",
              "country":"world"
            },
            "status":"Success",
            "last_updated":"2016-08-31"
          },
          "global_rank":[
            {
              "date":"2016-02",
              "global_rank":618201
            },
            {
              "date":"2016-03",
              "global_rank":547984
            }
          ]
        }
      eos

      prev_date = Date.new(2016, 2, 1).strftime("%Y-%m")
      curr_date = Date.new(2016, 3, 1).strftime("%Y-%m")

      stub_request(:get, "https://api.similarweb.com/v1/website/example.com/global-rank/global-rank?api_key=test-key&start_date=#{prev_date}&end_date=#{curr_date}&main_domain_only=false&granularity=daily").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @global_rank = @client.global_rank('example.com', start_date: prev_date, end_date: curr_date)
    end

    it 'should have global_rank' do
      expect( @global_rank ).to have_key('global_rank')
    end
  end

  describe '.overview' do
    before(:each) do
      body = <<-eos
        {
          "meta":{
            "request":{
              "main_domain_only":false,
              "domain":"example.com",
              "start_date":"2016-02-01",
              "end_date":"2016-03-31",
              "country":"world"
            },
            "status":"Success",
            "last_updated":"2016-08-31"
          },
          "overview":[
            {
              "domain":"Google Search",
              "source_type":"Search / Organic",
              "share":0.41639403396202934
            },
            {
              "domain":"Pinterest",
              "source_type":"Social",
              "share":0.20904855361218369
            },
            {
              "domain":"Direct",
              "source_type":"Direct",
              "share":0.12829460352388516
            },
            {
              "domain":"tots100.co.uk",
              "source_type":"Referral",
              "share":0.029866221929425649
            },
            {
              "domain":"learnplayimagine.com",
              "source_type":"Referral",
              "share":0.02856538785145192
            },
            {
              "domain":"Image Search",
              "source_type":"Search / Organic",
              "share":0.017063678768989714
            },
            {
              "domain":"thehomeschoolscientist.com",
              "source_type":"Referral",
              "share":0.015675471806417891
            },
            {
              "domain":"Facebook",
              "source_type":"Social",
              "share":0.015467820889190303
            },
            {
              "domain":"Yahoo Search",
              "source_type":"Search / Organic",
              "share":0.014995301728721915
            },
            {
              "domain":"mamaot.com",
              "source_type":"Referral",
              "share":0.01481799294889001
            },
            {
              "domain":"handsonaswegrow.com",
              "source_type":"Referral",
              "share":0.014776675139542847
            },
            {
              "domain":"Stumbleupon",
              "source_type":"Social",
              "share":0.011844168664330908
            },
            {
              "domain":"preschoolpowolpackets.blogspot.com",
              "source_type":"Referral",
              "share":0.00855025734895521
            },
            {
              "domain":"Mail",
              "source_type":"Mail",
              "share":0.0076222518241877146
            },
            {
              "domain":"totschooling.net",
              "source_type":"Referral",
              "share":0.0040017129400708572
            },
            {
              "domain":"livingmontessorinow.com",
              "source_type":"Referral",
              "share":0.0032454703688367084
            },
            {
              "domain":"pleasantestthing.com",
              "source_type":"Referral",
              "share":0.0032454703688367084
            },
            {
              "domain":"Bing Search",
              "source_type":"Search / Organic",
              "share":0.0031931284746566104
            },
            {
              "domain":"theeducatorsspinonit.com",
              "source_type":"Referral",
              "share":0.0025722613956609968
            },
            {
              "domain":"redtedart.com",
              "source_type":"Referral",
              "share":0.0024696654914816677
            },
            {
              "domain":"notimeforflashcards.com",
              "source_type":"Referral",
              "share":0.0023572453911484786
            }
          ]
        }
      eos

      prev_date = Date.new(2016, 2, 1).strftime("%Y-%m")
      curr_date = Date.new(2016, 3, 1).strftime("%Y-%m")

      stub_request(:get, "https://api.similarweb.com/v1/website/example.com/traffic-sources/overview?api_key=test-key&start_date=#{prev_date}&end_date=#{curr_date}&main_domain_only=false&granularity=daily").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @overview = @client.overview('example.com', start_date: prev_date, end_date: curr_date)
    end

    it 'should have overview' do
      expect( @overview ).to have_key('overview')
    end
  end

  describe '.overview_share' do
    before(:each) do
      body = <<-eos
        {
          "meta":{
            "request":{
              "main_domain_only":false,
              "domain":"example.com",
              "start_date":"2016-02-01",
              "end_date":"2016-03-31",
              "country":"world"
            },
            "status":"Success",
            "last_updated":"2016-08-31"
          },
          "visits":{
            "example.com":[
              {
                "source_type":"Search",
                "visits":[
                  {
                    "date":"2016-02-01",
                    "organic":10390.544150384667,
                    "paid":0.0
                  },
                  {
                    "date":"2016-03-01",
                    "organic":13725.010450884669,
                    "paid":0.0
                  }
                ]
              },
              {
                "source_type":"Social",
                "visits":[
                  {
                    "date":"2016-02-01",
                    "organic":6066.737915308483,
                    "paid":0.0
                  },
                  {
                    "date":"2016-03-01",
                    "organic":6499.7884894634826,
                    "paid":0.0
                  }
                ]
              },
              {
                "source_type":"Mail",
                "visits":[
                  {
                    "date":"2016-02-01",
                    "organic":0.0,
                    "paid":0.0
                  },
                  {
                    "date":"2016-03-01",
                    "organic":405.25050217592451,
                    "paid":0.0
                  }
                ]
              },
              {
                "source_type":"Display Ads",
                "visits":[
                  {
                    "date":"2016-02-01",
                    "organic":0.0,
                    "paid":0.0
                  },
                  {
                    "date":"2016-03-01",
                    "organic":0.0,
                    "paid":0.0
                  }
                ]
              },
              {
                "source_type":"Direct",
                "visits":[
                  {
                    "date":"2016-02-01",
                    "organic":2621.0541695610132,
                    "paid":0.0
                  },
                  {
                    "date":"2016-03-01",
                    "organic":4199.9553829613751,
                    "paid":0.0
                  }
                ]
              },
              {
                "source_type":"Referrals",
                "visits":[
                  {
                    "date":"2016-02-01",
                    "organic":5713.3347242354976,
                    "paid":0.0
                  },
                  {
                    "date":"2016-03-01",
                    "organic":3545.0932385753604,
                    "paid":0.0
                  }
                ]
              }
            ]
          }
        }
      eos

      prev_date = Date.new(2016, 2, 1).strftime("%Y-%m")
      curr_date = Date.new(2016, 3, 1).strftime("%Y-%m")

      stub_request(:get, "https://api.similarweb.com/v1/website/example.com/traffic-sources/overview-share?api_key=test-key&start_date=#{prev_date}&end_date=#{curr_date}&main_domain_only=false&granularity=daily").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @overview_share = @client.overview_share('example.com', start_date: prev_date, end_date: curr_date)
    end

    it 'should have visits' do
      expect( @overview_share ).to have_key('visits')
    end
  end

  describe '.engagement' do
    before(:each) do
      body = <<-eos
        {
         "AveragePageViews": 4.230206634619614,
         "AverageTimeOnSite": 368.58524742011434,
         "BounceRate": 0.2642082587520108,
         "Date": "03/2014"
        }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v1/engagement?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @engagement = @client.engagement('example.com')
    end

    it 'should have average page views' do
      expect( @engagement ).to have_key('AveragePageViews')
    end

    it 'should have average time on site' do
      expect( @engagement ).to have_key('AverageTimeOnSite')
    end

    it 'should have bounce rate' do
      expect( @engagement ).to have_key('BounceRate')
    end

    it 'should have date' do
      expect( @engagement ).to have_key('Date')
    end
  end

  describe '.destinations' do
    before(:each) do
      body = <<-eos
          {
           "Sites": [
            "test.com",
            "faketest.com"
           ],
           "StartDate": "01/2014",
           "EndDate": "03/2014"
          }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v2/leadingdestinationsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @destinations = @client.destinations('example.com')
    end

    it 'should return a list of sites' do
      expect( @destinations["Sites"] ).to be_a(Array)
    end
  end

  describe '.category' do
    before(:each) do
      body = <<-eos
        {
         "Category": "Sports/Basketball"
        }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v2/category?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @category = @client.category('example.com')
    end

    it 'should return a category' do
      expect( @category ).to have_key('Category')
    end
  end

  describe '.category_rank' do
    before(:each) do
      body = <<-eos
        {
         "Category": "Sports/Basketball",
         "CategoryRank": 1
        }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v2/CategoryRank?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @category_rank = @client.category_rank('example.com')
    end

    it 'should return a category' do
      expect( @category_rank ).to have_key('Category')
    end

    it 'should return a rank' do
      expect( @category_rank ).to have_key('CategoryRank')
    end
  end

  describe '.also_visited' do
    before(:each) do
      body = <<-eos
          {
            "AlsoVisited": [
              {
                "Url": "nfl.com",
                "Score": 0.005021070143807851
              }
            ]
          }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v2/alsovisited?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @also_visited_metrics = @client.also_visited('example.com')
    end

    it 'should return a list of also visited sites' do
      expect(@also_visited_metrics["AlsoVisited"]).to be_a(Array)
    end

    describe 'similar site' do
      it 'should have a url' do
        expect(@also_visited_metrics["AlsoVisited"].first).to have_key('Url')
      end

      it 'should have a score' do
        expect(@also_visited_metrics["AlsoVisited"].first).to have_key('Score')
      end
    end
  end

  describe '.traffic' do
    before(:each) do
      body = <<-eos
          {
           "GlobalRank": 327,
           "CountryCode": 840,
           "CountryRank": 251,
           "TopCountryShares": [
            {
             "CountryCode": 840,
             "TrafficShare": 0.4274051669391115
            }]
           }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/example.com/v1/traffic?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @traffic_metrics = @client.traffic('example.com')
    end

    it 'should return the traffic metrics with global rank' do
      expect( @traffic_metrics ).to have_key('GlobalRank')
    end

    it 'should return the traffic metrics with country code' do
      expect( @traffic_metrics ).to have_key('CountryCode')
    end

    it 'should return the traffic metrics with country rank' do
      expect( @traffic_metrics ).to have_key('CountryRank')
    end

    it 'should return the traffic metrics with top country shares' do
      expect( @traffic_metrics ).to have_key('TopCountryShares')
    end

    it 'should return a list of countries and the traffic share' do
      expect( @traffic_metrics['TopCountryShares'] ).to be_a(Array)
    end
  end

  describe '.similar_sites' do
    before(:each) do
      body = <<-eos
        {
         "SimilarSites": [
          {
           "Url": "pbskids.org",
           "Score": 0.9012942574949001
          },
          {
           "Url": "nick.com",
           "Score": 0.7312487797958783
          },
          {
           "Url": "kids.yahoo.com",
           "Score": 0.6653412685291096
          }
          ]
        }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/disney.com/v2/similarsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @similar_sites = @client.similar_sites('disney.com')
    end

    it 'should return a list of similar sites' do
      expect(@similar_sites["SimilarSites"]).to be_a(Array)
    end

    describe 'site tags' do
      it 'should have a name' do
        expect(@similar_sites["SimilarSites"].first).to have_key('Url')
      end

      it 'should have a score' do
        expect(@similar_sites["SimilarSites"].first).to have_key('Score')
      end
    end
  end


  describe '.social_referrals' do
    before(:each) do
      body = <<-eos
          {
            "SocialSources": [
              {
                "Source": "Youtube",
                "Value": 0.699753626365037
              },
              {
                "Source": "Reddit",
                "Value": 0.06447515408116457
              }
            ]
          }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/disney.com/v1/socialreferringsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @social_referrals = @client.social_referrals('disney.com')
    end

    it 'should return a list of social referrals' do
      expect(@social_referrals["SocialSources"]).to be_a(Array)
    end

    describe 'site tags' do
      it 'should have a name' do
        expect(@social_referrals["SocialSources"].first).to have_key('Source')
      end

      it 'should have a score' do
        expect(@social_referrals["SocialSources"].first).to have_key('Value')
      end
    end
  end

  describe '.tags' do
    before(:each) do
      body = <<-eos
          {
            "Tags": [
              {
                "Name": "disney",
                "Score": 0.4535382529673987
              },
              {
                "Name": "kids",
                "Score": 0.16695504510907133
              }
            ]
          }
      eos

      stub_request(:get, "https://api.similarweb.com/Site/disney.com/v2/tags?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.2'}).
        to_return(:status => 200, :body => body, :headers => {})

      @website_tags = @client.tags('disney.com')
    end

    it 'should return a list of tags' do
      expect(@website_tags["Tags"]).to be_a(Array)
    end

    describe 'site tags' do
      it 'should have a name' do
        expect(@website_tags["Tags"].first).to have_key('Name')
      end

      it 'should have a score' do
        expect(@website_tags["Tags"].first).to have_key('Score')
      end
    end
  end

end
