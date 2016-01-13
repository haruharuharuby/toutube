module VideosHelper
  BTN = "btn btn-default"

  def channel_link_to(video)
    link_to video.channel do
      content_tag :span, video.channel.name, class:"glyphicon glyphicon-film"
    end
  end

  def subscription_button_to(video)
    unless current_user
      return (button_to login_path, method: :get, class: BTN do
        content_tag :span, "チャンネル登録", class: "add-channel glyphicon glyphicon-play"
      end)
    end

    subscription = current_user.subscriptions.where(channel: video.channel)
    if subscription && subscription.any?
      button_to subscription.first, method: :delete, class: BTN, data:{ confirm: "本当に解除しますか?" } do
        content_tag :span, "チャンネル登録を解除する", class: "cancel-add-channel glyphicon glyphicon-play"
      end
    else
      button_to subscriptions_path(current_user, channel: video.channel), class: BTN do
        content_tag :span, "チャンネル登録", class: "add-channel glyphicon glyphicon-play"
      end
    end
  end

  def playlist_add_toggle_button_to
    button_tag class: "playlist-add-toggle " + BTN do
      content_tag :span, "追加", class: "glyphicon glyphicon-plus"
    end
  end

  def playlist_share_button_to
    link_to user_playlists_path, remote: true, query: @video, class: BTN do
      content_tag :span, "共有", class: "glyphicon glyphicon-share"
    end
  end

  def playlist_other_button_to
    link_to user_playlists_path, remote: true, class: BTN do
      content_tag :span, "その他", class: "glyphicon glyphicon-option-horizontal"
    end
  end

  def playlist_button_to(video, playlist_type, caption="")
    unless current_user
      return (button_to caption, login_path, method: :get, class: BTN)
    end

    playlist = current_user.playlists.get playlist_type
    playlist_video = playlist.build_relation video
    capture do
      form_for playlist_video do |f|
        concat f.hidden_field :playlist_id
        concat f.hidden_field :video_id
        concat f.submit caption, class: BTN
      end
    end
  end

  def playlist_dislike_button_to(video)
    unless current_user
      return (button_to login_path, method: :get, class: BTN  do
        content_tag :span, video.count_dislikes, class: "glyphicon glyphicon-thumbs-down"
      end)
    end

    if video.dislike?(current_user)
      playlist_video = current_user.playlists.dislike.video_relation video
      button_to playlist_video, method: :delete, class: BTN do
        content_tag :span, video.count_dislikes, class: "cancel glyphicon glyphicon-thumbs-down"
      end
    else
      playlist = current_user.playlists.dislike
      playlist_video = current_user.playlists.dislike.build_relation video
      button_to playlist_video, params: playlist_video.to_h_form_for, class: BTN  do
        content_tag :span, video.count_dislikes, class: "glyphicon glyphicon-thumbs-down"
      end
    end
  end

  def playlist_like_button_to(video)
    unless current_user
      return (button_to login_path, method: :get, class: BTN  do
        content_tag :span, video.count_likes, class: "glyphicon glyphicon-thumbs-up"
      end)
    end

    if video.like?(current_user)
      playlist_video = current_user.playlists.like.video_relation video
      button_to playlist_video, method: :delete, class: BTN  do
        content_tag :span, video.count_likes, class: "cancel glyphicon glyphicon-thumbs-up"
      end
    else
      playlist = current_user.playlists.like
      playlist_video = current_user.playlists.like.build_relation video
      button_to playlist_video, params: playlist_video.to_h_form_for, class: BTN do
        content_tag :span, video.count_likes, class: "glyphicon glyphicon-thumbs-up"
      end
    end
  end

  def playlist_action_buttons_to(video)
    unless current_user
      return (button_to "再生リストを操作するにはログインします", login_path, method: :get)
    end

    playlists = current_user.playlists.operatable_lists
    playlists_html = capture do
      content_tag_for :li, playlists, class: "btn-default" do |playlist|
        unless playlist.videos.exists?(video)
          playlist_video = playlist.build_relation video
          form_for playlist_video, html: {class: "playlist-action-item" } do |f|
            concat f.hidden_field :playlist_id
            concat f.hidden_field :video_id
            concat check_box_tag playlist.name
            concat label_tag playlist.name
          end
        else
          playlist_video = playlist.video_relation video
          form_for playlist_video, method: :delete, html: { class: "playlist-action-item" } do |f|
            concat check_box_tag playlist.name, "checked", true
            concat label_tag playlist.name
          end
        end
      end
    end
    content_tag :ul, playlists_html
  end

  def new_playlist_form_for(video)
    unless current_user
      return
    end

    new_playlist = current_user.playlists.build(playlist_type: Playlist.types[:other])
    new_playlist.build_relation(video)

    capture do
      form_for [current_user, new_playlist] do |f|
        concat f.hidden_field :user_id
        concat f.hidden_field :playlist_type
        concat f.text_field :name, id: "new_playlist_name"
        concat f.submit "作成", class: BTN, id: "new_playlist_submit"
      end
    end
  end

  def new_comment_form_for(video)
    unless current_user
      return( button_to "コメントするにはログインします", login_path, method: :get)
    end

    capture do
      new_comment = video.comments.build
      new_comment.user = current_user
      form_for [video, new_comment] do |f|
        text_area = f.text_area :body, placeholder:"公開コメントを追加"
        cancel = button_tag "キャンセル", type: "button", id: "comment_cancel", class: BTN + " pull-left"
        submit = f.submit "コメントする", class: BTN
        action = cancel + submit

        concat f.hidden_field :user_id
        concat f.hidden_field :video_id
        concat content_tag :div, text_area, class: "field"
        concat content_tag :div, action, class: "comment-action pull-right"
      end
    end
  end

  def comment_video_links_to(video)
    sorted_comments = video.comments.order("id desc")
    div_for sorted_comments do |c|
      concat link_to c.user.name, c.user
      concat content_tag :div, c.body, class: "body"
      concat content_tag :div, time_ago_in_words(c.created_at.localtime).to_s + "前", class: "commented_at"
      concat button_to "削除", [video, c], method: :delete, class: BTN, data: { :confirm => 'Are you sure?' } if c.user === current_user
    end
  end
end
