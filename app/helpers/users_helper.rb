module UsersHelper
  THUMB_SIZE = "128x72"

  def custom_playlists_links_to(playlists)
    html = capture do
      content_tag_for :div, playlists, class: "pull-left" do |playlist|
        if playlist.videos.any?
          concat (content_tag :div, class: "image-link" do
            concat link_to image_tag(playlist.videos.first.uri_url(:thumb), size: THUMB_SIZE), [playlist.user, playlist]
          end)
          concat (content_tag :div, class: "name-link" do
            concat link_to playlist.name, [playlist.user, playlist]
          end)
        else
          no_video_link_to playlist.name
        end
      end
    end
  end

  def videos_link_to(videos)
    html = capture do
      if videos.any?
        content_tag_for :div, videos, class: "pull-left" do |video|
          concat (content_tag :div, class: "image-link" do
            concat link_to image_tag(video.uri_url(:thumb), size: THUMB_SIZE), video
          end)
          concat (content_tag :div, class: "name-link" do
            concat link_to video.title, video
          end)
        end
      else
        no_video_link_to
      end
    end
  end

  def no_video_link_to(name = "")
    html = capture do
      concat content_tag :div, "動画はありません。", class: "image-link"
      concat content_tag :div, name, class: "name-link"
    end
  end
end
