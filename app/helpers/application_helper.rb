module ApplicationHelper
  def display_channel_name(channel)
    if channel.current?
      return "*" + channel.name if channel
    else
      return channel.name if channel
    end
  end
end
