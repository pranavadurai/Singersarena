class OnlinesChannel < ApplicationCable::Channel
  def subscribed
    redis.set("user_#{auth_user.id}_online", "1")
    stream_from("onlines_channel")
    ActionCable.server.broadcast "onlines_channel",
                                 user_id: auth_user.id,
                                 online: true
  end

  def unsubscribed
    redis.del("user_#{auth_user.id}_online")
    ActionCable.server.broadcast "onlines_channel",
                                 user_id: auth_user.id,
                                 online: false
  end

  private

  def redis
    Redis.new
  end
end
