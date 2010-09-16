on notify(msg)
	try
		tell application "GrowlHelperApp"
			register as application Â
				"AppleScript" all notifications ["Message"] Â
				default notifications ["Message"] Â
				icon of application "Terminal"
			notify with name Â
				"Message" title Â
				"Lyrics and Artwork" description msg Â
				application name Â
				"AppleScript" icon of application "iTunes"
		end tell
	on error
		display dialog msg buttons {"Thanks"} default button 1 giving up after 15
	end try
end notify

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
	set the_playlist to playlist "Search"
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
end tell

notify("Finished Processing Tracks")