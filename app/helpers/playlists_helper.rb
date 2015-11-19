module PlaylistsHelper
  def render_playlist_link(title, playlist)
    content_tag(:div, class: 'playlist-content') do
      result = content_tag(:div, title)
      result << if playlist.any?
        link_to image_tag(playlist.first.video.uri_url(:thumb)), playlist_path(playlist.first)
      else
        '登録されていません'
      end
    end
  end

  def render_reputation_link(title, r)
    html = ""
    html << title
    html << tag(:br)
    if r.any?
      html << tag(:br)
      html << "#{link_to image_tag(r.first.video.uri_url(:thumb)), reputation_path(r)}"
    else
      html << "登録されていません"
    end
    return html.html_safe
  end
end
