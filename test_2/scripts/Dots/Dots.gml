//90% finished needs Testing 
function damageOverTime(_duration, _amout, _type, _target, _removeEffecAtion = false) constructor {
	applied = false;

	target = _target;	
	duration = _duration;
	amount = _amout;
	typeOfDot = _type;
	removeEffecAtion = _removeEffecAtion;
	
	function effect(){
		if(!applied){
			switch(typeOfDot){
				case dotTypes.poison:
					target.currentHealth -= amount;
					target.checkDeath();
				break;
				case dotTypes.bleed:
					target.currentHealth -= amount;
					target.checkDeath();
				break;
			}
			applied = true;
		}		
	}

	function removeEffect(){
		if(applied){
			switch(typeOfDot){
				case dotTypes.poison:
					target.poisonDot = false;
				break;
				case dotTypes.bleed:
					target.bleedDot = false;
				break;
			}
			if(removeEffecAtion != false){
				script_execute(removeEffecAtion, target);
			}
		}
	}

}


