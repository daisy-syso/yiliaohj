# frozen_string_literal: true
redis_basic = {
  host: Settings.redis.host,
  port: Settings.redis.port
}

require 'connection_pool'
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new redis_basic.merge(db: Settings.redis.position) }

$redis_position = Redis.new redis_basic.merge(db: Settings.redis.position)

$redis_sms = Redis.new redis_basic.merge(db: Settings.redis.sms)

$redis_symptoms = Redis.new redis_basic.merge(db: Settings.redis.symptoms)
