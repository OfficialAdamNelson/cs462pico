ruleset see_songs {

	rule songs is active {
	  select when echo message msg_type re/^song$/ input "(.*)" setting(m) 
	  send_directive("sing") with
		song = m;
	  always {
            raise explicit event 'sung' with 
              song = m;
          }
	}
	
	rule find_hymn is active {
	  select when explicit sung
	  pre {
	  	query = event:attr("song");
	  }
	  always {
	      raise explicit event 'found_hymn'
	      if (query.match(#god#i));
	  }
	}

}
