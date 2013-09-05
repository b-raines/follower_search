module StaticPagesHelper

  def find_trends
    get_topics_and_names
    sort_topics_and_names
    count_and_sort_trends
  end

  def useless_word_filter
    base_filter = %w[i if you do he she they them it us we and my mine your yours him 
             her his hers know how use dont do not the theirs their there for 
             our is as a of in on around at to this and are where from more
             no one some out every that thats with arent got off rt be have about will
             what just its all day so but can go or were see when without youre
             here than into much over cant should pass has as was get put via let]

    @screen = []

    base_filter.each do |x|
      @screen << x
      @screen << x.capitalize
      @screen << x.upcase
    end
  end

  def get_topics_and_names
    useless_word_filter
    @topics = []
    @names = []
    current_user.tweets.each do |tweet|
      content = tweet.content.gsub(/[^\w\s@#]/, '')
      content = content.split.delete_if {|x| x.include? 'http' } - @screen
      content = content.join(' ')
      content.scan(/[A-Z][a-z]+\s[A-Z][a-z]+\s*[A-Z]?[a-z]*/) do |x|
                   @names << x
      end
      @topics << content.split
    end
  end

  def sort_topics_and_names
    @topics = @topics.flatten - @names.map {|x| x.split }.flatten
    @topics = @topics.map { |topic| topic.downcase }.delete_if {|x| x.size < 4}
    @names.each {|name| @topics << name }
    @topics = @topics.flatten
  end

  def count_and_sort_trends
    counts = Hash.new(0)
    @topics.each { |topic| counts[topic] += 1 }
    trends = counts.sort_by {|k,v| v}.reverse
    @hot_trends = trends[0..4]
    @warm_trends = trends[5..9]
    @cold_trends = trends[10..19]
  end
end
