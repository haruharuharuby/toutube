module PlaylistsHelper
  def render_playlist_link(title, playlist)
    html = ""
    html << title
    html << tag(:br)
    if playlist.any?
      playlist.each do |s|
        html << s.name
        html << tag(:br)
        html << "#{link_to image_tag(s.video.uri_url(:thumb)), playlist_path(s)}"
      end
    else
      html << "Nothing"
    end
    return html
  end

  def render_reputation_link(title, reputation)
    html = ""
    html << title
    html << tag(:br)
    if reputation.any?
      reputation.each do |r|
        html << "#{link_to image_tag(r.video.uri_url(:thumb)), reputation_path(r)}"
      end
    else
      html << "Nothing"
    end
    return html
  end
end
