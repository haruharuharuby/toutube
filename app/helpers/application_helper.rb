module ApplicationHelper
  def side_bar_toggle_button_to
    button_tag class: "toggle-side-menu btn navbar-btn btn-default" do
      content_tag :span, "", class: "glyphicon glyphicon-align-justify"
    end
  end

  def search_form_for
    capture do
      text_field = text_field_tag "key", "", class: "form-control"
      form_tag search_videos_path, method: :get, class: "pull-left" do
        concat (content_tag :div, text_field, class: "form-group pull-left")
        concat (button_tag class: "search-button btn btn-default" do
          content_tag :span, "", class:" glyphicon glyphicon-search "
        end)
      end
    end
  end

  def user_information_links_to
    email = content_tag :div, current_user.email, class: "email"
    image = image_tag current_user.gravatar_url, size: "50x50"
    channel_lists = content_tag_for :li, current_user.channels do |channel|
      concat link_to display_channel_name(channel), user_channel_path(channel)
    end
    channels = content_tag :ul, channel_lists
    logout = link_to "ログアウト", logout_path, method: :delete

    content_tag :div, email + image + channels + logout, class: "user-description"
  end

  def display_channel_name(channel)
    if channel.current?
      return "*" + channel.name if channel
    else
      return channel.name if channel
    end
  end
end
