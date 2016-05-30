# frozen_string_literal: true
redis_basic = {
  host: Settings.cloud_redis.host,
  port: Settings.cloud_redis.port
}

require 'connection_pool'
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new redis_basic.merge(db: 0) }

$redis_position = Redis.new redis_basic.merge(db: 0)

$redis_sms = Redis.new redis_basic.merge(db: 0)

$redis_symptoms = Redis.new redis_basic.merge(db: 0)
