if(oGame.allowInput){
	if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
		if(MainFunction != noone && btnState == buttonState.active){
			script_execute(MainFunction);
		}
	}
}

