# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

tweets = client.user_timeline("realdonaldtrump", {
  count:       200,
  include_rts: false
})

tweets.each do |tweet|
  puts Tweet.create({
    twitter_id:         tweet.id,
    twitter_created_at: tweet.created_at,
    text:               tweet.text,
    pos_tagged_text:    EngTagger.new.get_readable(tweet.text)
  }).inspect
end
