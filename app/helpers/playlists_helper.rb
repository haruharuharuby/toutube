module PlaylistsHelper
  def render_playlist_link(title, p)
    html = ""
    html << title
    html << tag(:br)
    if p.any?
      html << tag(:br)
      html << "#{link_to image_tag(p.first.video.uri_url(:thumb)), playlist_path(p.first)}"
    else
      html << "登録されていません"
    end
    return html
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
    return html
  end
end
