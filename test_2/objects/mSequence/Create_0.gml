function playBattleAnimations(attackAnimation, leftChar, rightChar){
	switch(attackAnimation){
		case actions.attack1:
			
			with(leftChar){
				state = states.ATTACK1;
				layer_sequence_headpos(unitSequence, attack1Start);
			}
			playHurt(rightChar);	

		break;
		
		case actions.attack2: 
			with(leftChar){
				state = states.ATTACK2;
				layer_sequence_headpos(unitSequence, attack2Start);
			}
			playHurt(rightChar);
			
			
			
		break;
		
		case actions.attack3: 
			with(leftChar){
				state = states.ATTACK3;
				layer_sequence_headpos(unitSequence, attack3Start);
			}
			playHurt(rightChar);
			
		break;
		
		case actions.skill1: 
		
		break;
		
		case actions.skill2: 
		
		break;
		
		case actions.skill3: 
		
		break;
		
		case actions.useBandage: 
		
		break;
	}
}

/*


*/


function playHurt(list){
	for(i = 0; i < ds_list_size(list); i++){
		with(list[|i]){
			state = states.HURT;
			layer_sequence_headpos(unitSequence, hurtStart);
		}
	}
}