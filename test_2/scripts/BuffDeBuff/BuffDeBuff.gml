#region BuffDebuff

function buffDeBuff(_duration, _amout, _type, _target, _goodEffect, _removeEffecAtion = false) constructor {
	applied = false;

	target = _target;	
	duration = _duration;
	amount = _amout;
	typeOfBuff = _type;
	goodEffect = _goodEffect;
	removeEffecAtion = _removeEffecAtion;
	
	function effect(){
		if(!applied){
			switch(typeOfBuff){
				case buffTypes.tempo:
					if(goodEffect){
						target.empo += amount;
					}else{
						target.tempo-= amount;
					}
				break;
				case buffTypes.doge:
					if(goodEffect){
						target.doge += amount;
					}else{
						target.doge -= amount;
					}
				break;
				case buffTypes.dmgRed:
					if(goodEffect){
						target.dmgRedMagic += amount;
						target.dmgRedRange += amount;
						target.dmgRedMelee += amount;
					}else{
						target.dmgRedMagic -= amount;
						target.dmgRedRange -= amount;
						target.dmgRedMelee -= amount;
					}
				break;
				case buffTypes.reRollAcc:
					if(goodEffect){
						target.reRollAcc += amount;
					}else{
						target.reRollAcc -= amount;
					}
				break;
				case buffTypes.reRollCrit:
					if(goodEffect){
						target.reRollCrit += amount;
					}else{
						target.reRollCrit -= amount;
					}
				break;
				case buffTypes.reRollDoge:
					if(goodEffect){
						target.reRollDoge += amount;
					}else{
						target.reRollDoge -= amount;
					}
				break;
			}
			applied = true;
		}
	}

	function removeEffect(){
		if(applied){
			switch(typeOfBuff){
				case buffTypes.tempo:
					if(goodEffect){
						target.tempo -= amount;
						target.buffTempo = false;
					}else{
						target.tempo += amount;
						target.deBuffTempo= false;
					}
				break;
				case buffTypes.doge:
					if(goodEffect){
						target.doge -= amount;
						target.buffTempo = false;
					}else{
						target.doge += amount;
						target.deBuffDoge = false;
					}
				break;
				case buffTypes.dmgRed:
					if(goodEffect){
						target.dmgRedMagic -= amount;
						target.dmgRedRange -= amount;
						target.dmgRedMelee -= amount;
						target.buffDmgRed = false;
					}else{
						target.dmgRedMagic += amount;
						target.dmgRedRange += amount;
						target.dmgRedMelee += amount;
						target.deBuffDmgRed = false;
					}
				break;
				case buffTypes.reRollAcc:
					if(goodEffect){
						target.reRollAcc -= amount;
						target.buffReRollAcc = false;
					}else{
						target.reRollAcc += amount;
						target.deBuffReRollAcc = false;
					}
				break;
				case buffTypes.reRollCrit:
					if(goodEffect){
						target.reRollCrit -= amount;
						target.buffReRollCrit = false;
					}else{
						target.reRollCrit += amount;
						target.deBuffReRollCrit = false;
					}
				break;
				case buffTypes.reRollDoge:
					if(goodEffect){
						target.reRollDoge -= amount;
						target.buffReRollDoge = false;
					}else{
						target.reRollDoge+= amount;
						target.deBuffReRollDoge = false;
					}
				break;
			}
			if(removeEffecAtion != false){
				script_execute(removeEffecAtion, target);
			}
		}
	}
}

#endregion

#region findActiveBuffs and deBuffs on Target


#endregion

#region removeEffecAtion


function removeDefensiveStance(_target){
	_target.defensiveStance = false;
}


#endregion

