ENV["REDIS_URL"] ||= "redis://redistogo:5ae058fed5631bb09ccb893264cd9514@beardfish.redistogo.com:9004/"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq' }
end

unless Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq'  }
  end
end