# Similarweb

Ruby client for [SimilarWeb API](https://developer.similarweb.com/)

## Installation

Add this line to your application's Gemfile:

    gem 'similarweb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install similarweb

## Usage

``` ruby
client = Similarweb::Client.new(api_key: key)
traffic = client.traffic('disney.com')
```

### Also Visited

Returns a list of websites frequently visited by users of the given domain.

``` ruby
client = Similarweb::Client.new(api_key: key)
also_visited = client.also_visited('disney.com')
```

### Category

Will return a domain’s category and its global rank within its given category.

``` ruby
client = Similarweb::Client.new(api_key: key)
category = client.category('disney.com')
```

### Category Rank

Will return a domain’s category and its global rank within its given category.

``` ruby
client = Similarweb::Client.new(api_key: key)
category_rank = client.category_rank('disney.com')
```

### Destinations

Returns the 10 leading sites that receive direct clicks from the given domain.

``` ruby
client = Similarweb::Client.new(api_key: key)
destinations = client.destinations('disney.com')
```

### Engagement

Provides three web engagement metrics: average page views, average time on site and bounce rate.

``` ruby
client = Similarweb::Client.new(api_key: key)
engagement = client.engagement('disney.com')
```

### Estimated Visits

Returns the estimated number of visitors per domain.

``` ruby
client = Similarweb::Client.new(api_key: key)
visits = client.estimated_visits('disney.com')
```

### Keywords

Access three search metrics: paid/organic search distribution, 10 paid keywords, and 10 organic keywords.

``` ruby
client = Similarweb::Client.new(api_key: key)
keywords = client.keywords('disney.com')
```

### Referrals

Returns the 10 leading sites that direct clicks to the given domain.

``` ruby
client = Similarweb::Client.new(api_key: key)
referrals = client.referrals('disney.com')
```

### Similar Sites

Input a domain and receive an output of 20 similar websites and their similarity score.
``` ruby
client = Similarweb::Client.new(api_key: key)
similar = client.similar_sites('disney.com')
```

### Social Referrals

Access the five leading social networks sending traffic to the given domain.

``` ruby
client = Similarweb::Client.new(api_key: key)
social = client.social_referrals('disney.com')
```

### Tags

Returns 10 tags per domain based on semantic analysis, meta-data, anchor text and more.

``` ruby
client = Similarweb::Client.new(api_key: key)
tags = client.tags('disney.com')
```

### Traffic

Will return four web traffic metrics: global rank, country rank/traffic geography, traffic reach and traffic sources distribution.

``` ruby
client = Similarweb::Client.new(api_key: key)
traffic = client.traffic('disney.com')
```

## Author
[John McLaughlin](mailto:j@yar.com) & [Steven Lai](mailto:lai.steven@gmail.com)

## Contributing

1. Fork it ( http://github.com/johnmcl/similarweb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright
Copyright (c) 2014 [John McLaughlin](mailto:j@yar.com), [Steven Lai](mailto:lai.steven@gmail.com).
See [LICENSE][license] for details.

[license]:   LICENSE.md
