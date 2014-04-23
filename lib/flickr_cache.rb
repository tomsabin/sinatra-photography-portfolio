require 'redis'

module FlickrCache
  def self.get(key)
    self.redis_connection.get(key)
  end

  def self.set(key, value)
    self.redis_connection.set(key, value)
  end

  private
  def self.redis_connection
    redis ||= Redis.new(:url => ENV['REDISTOGO_URL'])
  end
end
