ruleset see_songs {

	rule songs is active {
	  select when echo message msg_type re/song/ input "(.*)" setting(m) 
	  send_directive("sing") with
		song = m;
	}

}
