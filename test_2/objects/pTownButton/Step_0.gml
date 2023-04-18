if(btnState == buttonState.active){
	if(HoverFunction != noone && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
		script_execute(HoverFunction);
	}
	if(MainFunction != 0 && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id) ){
		
		if(subImageBtnIndicUse){
			image_index = 1;
		}
		if(mouse_check_button(mb_left) && subImageBtnIndicUse){
			image_index = 2;
		}
		if(oTown.allowInputs && mouse_check_button_released(mb_left)){
			script_execute(MainFunction);
		}
	} else if(subImageBtnIndicUse){
		image_index = 0;
	}
}else if(btnState == buttonState.disabled && subImageBtnIndicUse){
	image_index = 3;
}