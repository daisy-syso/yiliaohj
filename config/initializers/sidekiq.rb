# frozen_string_literal: true
redis_sidekiq_params = {
  host: Settings.redis.host,
  port: Settings.redis.port,
  db: Settings.redis.sidekiq_db,
  password: Settings.redis.password
}

Sidekiq.configure_server do |config|
  config.redis = redis_sidekiq_params
end

Sidekiq.configure_client do |config|
  config.redis = redis_sidekiq_params
end
