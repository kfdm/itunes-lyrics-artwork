

on find_playlist(playlistName)
	tell application "iTunes"
		if (not (exists playlist playlistName)) then
			set new_playlist to make new playlist with properties {name:playlistName}
		else
			set new_playlist to playlist playlistName
		end if
		return new_playlist
	end tell
end find_playlist

tell application "iTunes"
	set the_playlist to playlist "Anime"
	set playlist_artwork to my find_playlist("Artwork")
	set playlist_no_artwork to my find_playlist("No Artwork")
	set playlist_lyrics to my find_playlist("Lyrics")
	set playlist_no_lyrics to my find_playlist("No Lyrics")
	
	delete tracks in playlist_artwork
	delete tracks in playlist_no_artwork
	delete tracks in playlist_lyrics
	delete tracks in playlist_no_lyrics
	
	repeat with this_track in (every track of the_playlist)
		with timeout of 300 seconds
			if class of this_track is file track then
				tell this_track
					try
						if (lyrics is not "") then
							duplicate this_track to playlist_lyrics
						else
							duplicate this_track to playlist_no_lyrics
						end if
						
						if (exists artworks) then
							duplicate this_track to playlist_artwork
						else
							duplicate this_track to playlist_no_artwork
						end if
						
					end try
				end tell
			end if
		end timeout
	end repeat
	try
		display dialog "Done" buttons {"Thanks"} default button 1 giving up after 15
	end try
end tell