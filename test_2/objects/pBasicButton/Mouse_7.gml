show_debug_message(MainFunction);
show_debug_message(oGame.allowInput);
if(oGame.allowInput){
	if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id) or position_meeting(mouse_x,mouse_y, id)){
		if(MainFunction != noone && btnState == buttonState.active){
			script_execute(MainFunction);
		}
	}
}

