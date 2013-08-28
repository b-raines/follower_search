class TrendsController < ApplicationController
  def index

    base_filter = %w[i if you do he she they them it us we and my mine your yours him 
             her his hers know how use dont do not the theirs their there for 
             our is as a the of in on around at to this and are where from more
             no one some out every that with arent got off rt be have about will
             what just its all day so but can go or were see when without youre
             here than into much over cant should pass]

    screen = []
    base_filter.each do |x|
      screen << x
      screen << x.capitalize
      screen << x.upcase
    end

    topics = []

    current_user.tweets.each do |tweet|
      content = tweet.content.gsub(/[^0-9A-Za-z@# ]/, '')
      topics << content.split.delete_if {|x| x.size < 4 }
    end
    topics = topics.flatten.delete_if {|x| x.include? "http" } - screen
    topics.each { |topic| topic.downcase! }

    counts = Hash.new(0)
    topics.each { |topic| counts[topic] += 1 }
    trends = counts.sort_by {|k,v| v}.reverse
    @trending = trends[0..49]
  end
end
