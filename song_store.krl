ruleset song_store {
	meta {
		provides songs, hymns, secular_music
		sharing on
	}
	global {
		songs = function() {
			ent:songs_sung
		}
		hymns = function() {
			ent:hymn_collection
		}
		secular_music = function() {
			ent:songs_sung.filter(function(x){not x.match(re/god/i)})
		}
	}
	rule collect_songs is active {
		select when explicit sung
		pre {
			songs = ent:songs_sung || [];
			new_songs = songs.union(event:attr("song") + "~" + timestamp);
		}
		always {
			set ent:songs_sung new_songs;
		}
	}
	rule collect_hymns is active {
		select when explicit found_hymn
		pre {
			hymns = ent:hymn_collection || [];
			new_hymns = hymns.union(event:attr("song") + "~" + timestamp);
		}
		always {
			set ent:hymn_collection new_hymns;
		}
	}
	rule clear_songs is active {
		select when song reset
		fired {
			clear ent:songs_sung;
			clear ent:hymn_collection;
		}
	}
}
