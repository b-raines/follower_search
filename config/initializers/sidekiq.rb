Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12', namespace: 'mynamespace' }

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end
end