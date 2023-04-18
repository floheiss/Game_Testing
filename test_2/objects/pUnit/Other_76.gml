if(event_data[? "event_type"] == "sequence event"){
	switch event_data[? "message"]{
		//way Later
		case "bmUsed":
			if(!selectedUnit.attackWillHit){
				show_debug_message("HERATICS WILL BURN");
			}
		break;
		
		case "unitHurt":
			if(!mCombat.selectedTargets){
				show_debug_message("i was hit " + string(id));
			}
		break;
	}
}

