if(drawCondition != -1){
	if(is_bool(drawCondition)){
		getsDraw = condition;
	}else if(is_method(drawCondition)){
		getsDraw = drawCondition();
	}else{
		getsDraw = script_execute(drawCondition);
	}
}

if(drawCondition){
	
	if(lockCondition != -1){
		if(is_bool(lockCondition)){
			locked = lockCondition;
		}else if(is_method(lockCondition)){
			locked = lockCondition(lockConditionParamArray);
		}else{
			locked = script_execute(lockCondition, lockConditionParamArray);
		}
	}
	btnState = (locked) ? buttonState.disabled :  buttonState.active;

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
		btnState != buttonState.disabled){
			if(is_method(HoverFunction)){
				HoverFunction();
			}else{
				script_execute(HoverFunction);
			}
	}



}

