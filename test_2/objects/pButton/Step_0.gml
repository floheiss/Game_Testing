if(btnState == buttonState.active){
	if(MainFunction != noone && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
			image_index = 1;
		if(HoverFunction != noone){
			script_execute(HoverFunction);
		}
		if(mouse_check_button(mb_left)){
			image_index = 2;
		}
		if(mCombat.allowInput && mouse_check_button_released(mb_left)){
			script_execute(MainFunction);
		}


	} else{
		image_index = 0;
	}
}else if(btnState == buttonState.disabled){
	image_index = 3;
}

if(typeof(mCombat.selectedUnit) == oSamurai){
	switch(Label){
		case Attack1:
			if(selectedUnit.costBloodAttack1 > selectedUnit.currentBloodLvL){
				btnState = buttonState.disabled;
			}
		break;
		case Attack2:
			if(selectedUnit.costBloodAttack2 > selectedUnit.currentBloodLvL){
				btnState = buttonState.disabled;
			}
		break;
		case Attack3:
			if(selectedUnit.costBloodAttack3 > selectedUnit.currentBloodLvL){
				btnState = buttonState.disabled;
			}
		break;
	}		
} 