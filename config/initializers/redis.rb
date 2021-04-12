# For local development environment
# $redis = Redis::Namespace.new("redis_with_rails", :redis => Redis.new)

# For production enviroment
$redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
