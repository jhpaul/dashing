require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
Twitter.configure do |config|
  config.consumer_key = 'hiUKtVADnMIBOqJMJ0AAg'
  config.consumer_secret = 'EfdcdMEnBIWIiiXmRgEPgHGWSY2FpvihVBe1LRS2SNM'
  config.oauth_token = '2155458012-CoJnVrU74dcH0weff1dHHexMxDj5TgBkxHVw8kw'
  config.oauth_token_secret = 'jum4WNV2pWi87yqzNIGShh8O36A9UHTeDXZFRu5VfVPpS'
end

search_term = URI::encode('@riphil')

SCHEDULER.every '5s', :first_in => 0 do |job|
  begin
    # tweets = Twitter.search("#{search_term}").results
    tweets = Twitter.user_timeline("riphilharmonic",:count => 2)
    # puts tweets
    if tweets
      tweets.map! do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }

      end
      # puts tweets[0]
      one = tweets[0]
      two = tweets[1]
      send_event('twitter_mentions-0', tweet: one)
      send_event('twitter_mentions-1', tweet: two)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end