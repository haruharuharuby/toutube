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

end
