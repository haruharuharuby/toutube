class PlaylistVideoRelation < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :video

  after_create :delete_inverse_reputation
  def delete_inverse_reputation
    if self.playlist
      user = self.playlist.user
      video = self.video
      if self.playlist.playlist_type == Playlist.types[:like]
        inverse_playlist = user.playlists.dislike
      elsif self.playlist.playlist_type == Playlist.types[:dislike]
        inverse_playlist = user.playlists.like
      end

      target_to_remove = PlaylistVideoRelation.where(playlist: inverse_playlist, video: video).first
      target_to_remove.destroy if target_to_remove
    end
  end

  def to_h_form_for
    {"playlist_video_relation[video_id]" => self.video_id.to_s, "playlist_video_relation[playlist_id]" => self.playlist_id.to_s}
  end
end
