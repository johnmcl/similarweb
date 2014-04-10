require 'spec_helper'

describe Similarweb::Client do
  before do
    @client = Similarweb::Client.new(api_key: 'test-key')
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v2/leadingreferringsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v1/searchintelligence?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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
         "EstimatedVisitors": 81178601
        }
      eos

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v1/EstimatedTraffic?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
        to_return(:status => 200, :body => body, :headers => {})

      @estimated_visitors = @client.estimated_visits('example.com')
    end

    it 'should have estimated visitors' do
      expect( @estimated_visitors ).to have_key('EstimatedVisitors')
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v1/engagement?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v2/leadingdestinationsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v2/category?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v2/CategoryRank?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v2/alsovisited?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/example.com/v1/traffic?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/disney.com/v2/similarsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/disney.com/v1/socialreferringsites?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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

      stub_request(:get, "http://api.similarweb.com/Site/disney.com/v2/tags?Format=JSON&UserKey=test-key").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
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
