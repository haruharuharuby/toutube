module VideosHelper
  def channel_subscribe_action_param(video, user)
    if(video.channel.already_registered?(current_user))
      actions = {value: 0, text: 'unregister channel'}
    else
      actions = {value: 1, text: 'register channel'}
    end
  end
end
