module VideosHelper
  def channel_subscribe_action_param(video, user)
    if(video.channel.already_registered?(current_user))
      actions = {value: 0, text: 'チャンネル登録を解除'}
    else
      actions = {value: 1, text: 'チャンネル登録'}
    end
  end
end
