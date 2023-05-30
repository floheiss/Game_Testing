if(global.room == roomList.battle && mCombat.drawRdy){
	
	if(!sequenceExists ){
		unitSequence = layer_sequence_create("Squences", x, y, sequenceName);
		sequenceExists = true;
	}
	switch(state){
		case states.IDLE: 
			if(layer_sequence_get_headpos(unitSequence) > idleEnd){
				layer_sequence_headpos(unitSequence, idleStart);
			}
		break;
	
		case states.ATTACK1: 
			if(layer_sequence_get_headpos(unitSequence) > attack1End){
				layer_sequence_headpos(unitSequence, attack1Start);
				state = states.IDLE;
			}
		break;
	
		case states.ATTACK2: 
			if(layer_sequence_get_headpos(unitSequence) > attack2End){
				layer_sequence_headpos(unitSequence, attack2Start);
				state = states.IDLE;
			}
		break;
	
		case states.ATTACK3: 
			if(layer_sequence_get_headpos(unitSequence) > attack3End){
				layer_sequence_headpos(unitSequence, attack3Start);
				state = states.IDLE;
			}
		break;
	
		case states.HURT: 
			if(layer_sequence_get_headpos(unitSequence) > hurtEnd){
				layer_sequence_headpos(unitSequence, hurtStart);
				state = states.IDLE;
			}
		break;
	
		case states.DEATH: 
			if(layer_sequence_get_headpos(unitSequence) > deathEnd){
				instance_destroy();
			}
		break;
	
		case states.PROTECT: 
			if(layer_sequence_get_headpos(unitSequence) > protectEnd){
				layer_sequence_headpos(unitSequence, protectStart);
				state = states.IDLE;
			}
		break;
	}

	if((mCombat.targeting) && mCombat.selectedUnit != id){
		if(position_meeting(mouse_x, mouse_y, id)){
			drawTarget = true;
		} else {
			drawTarget = false;
		}
	}
}


if(global.room !=  roomList.battle){
	if(ds_exists(unitSequence, asset_sequence)){
		sequence_destroy(unitSequence);
	}
}


