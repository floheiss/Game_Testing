if(useSubImage){
	if(btnState == buttonState.active){
		image_index = 0;
		if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
			image_index = 1;
			if(mouse_check_button(mb_left)){
				image_index = 2;
			}
		}
	}else if(btnState == buttonState.disabled){
		//might rework later to display a Image over it 
		image_index = 3;
	}
	
}

if(HoverFunction != noone && 
position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id) &&
buttonState != buttonState.disabled){
	script_execute(HoverFunction);
}
