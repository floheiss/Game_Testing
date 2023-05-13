if(oGame.allowInput){
	if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id) or position_meeting(mouse_x,mouse_y, id)){
		if(MainFunction != noone && btnState == buttonState.active){
			script_execute(MainFunction);
		}
	}
}

