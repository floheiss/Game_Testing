event_inherited();

changeSprite(x,y,sprite_index,true);

MainFunction = function(){
	with(mCombat){
		var unit = selectedUnit;
		targeting = true;
		unit.updateTargetNumbers();
		actionTaken = other.actionOfButton;
		
		#region find targetNumber / can Target
		
		var numberTargets = 0;
		var posTargets  = 0;
		switch(other.actionOfButton){
			case actions.attack1:
				numberTargets = unit.attack1Stru.targetNumber;
				posTargets = unit.attack1Stru.canTarget;
			break;
			case actions.attack2:
				numberTargets = unit.attack2Stru.targetNumber;
				posTargets = unit.attack2Stru.canTarget;
			break;
			case actions.attack3:
				numberTargets = unit.attack3Stru.targetNumber;
				posTargets = unit.attack3Stru.canTarget;
			break;
			case actions.skill1:
				numberTargets = unit.skill1Stru.targetNumber;
				posTargets = unit.skill1Stru.canTarget;
			break;
			case actions.skill2:
				numberTargets = unit.skill2Stru.targetNumber;
				posTargets = unit.skill2Stru.canTarget;
			break;
			case actions.skill3:
				numberTargets = unit.skill3Stru.targetNumber;
				posTargets = unit.skill3Stru.canTarget;
			break;
			case actions.skill4:
				numberTargets = unit.skill4Stru.targetNumber;
				posTargets = unit.skill4Stru.canTarget;
			break;
		}
		
		#endregion
		attackTargets = posTargets;
		maxNumberTargets = numberTargets;
		
		for(var i = 0; i < array_length(units); i ++){
		var _inst = units[i];
			if(_inst != selectedUnit){
				targets[i] = _inst;
			}
		}
		with(oGame){
			event_user(0);
		}
		
		event_user(1);
		event_user(2);
		
		with(oGame){
			event_user(0);
		}
	}
}

