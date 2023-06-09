#region var stuff

#region general stuff
team = 0;
position  = 0; //has to be set in class 
class = 0;//has to be set in class 

state = states.IDLE;
unitSequence = 0; //has to be set in class 
sequenceExists = false;

actionsInTurn = 0; 
selected = false;

drawTarget = false;

//For Exmaple not needed later
hpBarWidth = sprite_get_width(uiHPBar);
hpBarHeight = sprite_get_height(uiHPBar);
bloodFlaskWidth = sprite_get_width(uiBloodFlask);
bloodFlaskHeight = sprite_get_height(uiBloodFlask);

spriteHeight = 128;
spriteWidth = 128;
#endregion

#region spritestuff
icon = 0;//has to be set in class 
campFireSprite = 0; //has to be set in class 
sequenceName = 0;

//spriteStuff
idleStart = 0;
idleEnd = 5;


attack1Start = 6;
attack1End = 10;

attack2Start = 11;
attack2End = 15;

attack3Start = 16;
attack3End = 20;

hurtStart = 56;
hurtEnd = 65;

deathStart = 66;
deathEnd = 80;


#endregion

maxActionsInTurn = 1; //most classes should only have 1 attack per turn 

critMultiplier = 2.0;
buffCritMultiplier = false; // have to add in buff list and below
deBuffCritMultiplier = false;

reRollCrit = 0;
buffReRollCrit = false;
deBuffReRollCrit = false;

reRollDoge = 0;
buffReRollDoge = false;
deBuffReRollDoge = false;

reRollAcc = 0;
buffReRollAcc = false;
deBuffReRollAcc = false;

maxHealth = 0;
currentHealth = maxHealth;

bloodMeter = 0;
currentBloodLvL = bloodMeter;

dmgRedMelee = 0; //les then 1 
dmgRedRange = 0; //les then 1 
dmgRedMagic = 0; //les then 1 
buffDmgRed = false;
deBuffDmgRed = false;


bleedDot = false;
poisonDot = false;

stuned = false;
stunResist = [0,0];

doge = 0.0; //les then 1 
buffDoge = false;
deBuffDoge = false;

tempo = 200;
buffTempo = false;
deBuffTempo = false;


lvl = 1; // insert statsbonus from this 
expToNextLvl = 100; //later calculae after lvl up 

#endregion

#region dmg and heal

function damageUnit(_dmgNumber, _dmgType, _armorPen){
	var result = true;
	if(doge > 0.95){
		var dogeCal = 0.95;
	}else{
		dogeCal = doge;
	}
 	if(checkAgainstRandom100(dogeCal, reRollDoge)){
		show_debug_message("Doged");
		show_debug_message("Doged");
		result = false;
	} else {
		var dmgRedction = 0;
		switch(_dmgType){
			case dmgType.melee: 
				dmgRedction = dmgRedMelee;
			break;
			case dmgType.ranged: 
				dmgRedction = dmgRedRange;
			break;
			case dmgType.magic: 
				dmgRedction = dmgRedMagic;
			break;
		}
		dmgRedction -= _armorPen;
		
		if(dmgRedction < 0){
			dmgRedction = 0;
		}
		if(dmgRedction > 0.9){
			dmgRedction = 0.9;
		}
		
		// - for even more dmg ??? 
		var amountDamaged = _dmgNumber - (_dmgNumber*dmgRedction);
		amountDamaged = ceil(amountDamaged);
		currentHealth -=  amountDamaged;
		show_debug_message("hit for: " + string(amountDamaged));
		 
		
	}	
	checkDeath();
	return result; 
}

function healUnit(_heal){ 
	if(currentHealth + _heal < maxHealth){
		currentHealth += _heal;
	} else {
		currentHealth = maxHealth;
	}
	show_debug_message("i have " + string(currentHealth) );
	show_debug_message("i heal for " + string(_heal));
	show_debug_message("i have " + string(currentHealth) );
}

function checkDeath(){
		var arrayToUse = (team == 0) ? mCombat.team0 : mCombat.team1;
		var _pre = function(_vaule){
			return _vaule == id;
		}
		var posTeam = array_find_index(arrayToUse, _pre);
		var posUnit = array_find_index(mCombat.units, _pre);
		if(currentHealth <= 0){
			show_debug_message("i am dead");
			array_delete(arrayToUse, posTeam, 1);
			array_delete(mCombat.units, posUnit, 1);
		layer_sequence_headpos(unitSequence, deathStart);
		state = states.DEATH;
		instance_destroy(self);
	}
}

#endregion

function stunUnit(_acc, _accReroll,_stunResistAfter){
	if(!checkAgainstRandom100(doge, reRollDoge)){
		var accCal = max(_acc - stunResist[0], 0.1);
		if(checkAgainstRandom100(accCal, _accReroll)){
			var newResist = stunResist[0] + _stunResistAfter;
			stunResist = [newResist, 3];
			stuned = true;
			return true;
		}
	}
	return false;
}

#region Dots

function applyDot(_dot){
	if(doge > 0.95){
		var dogeCal = 0.95;
	}else{
		var dogeCal = doge;
	}
	if(checkAgainstRandom100(dogeCal, reRollDoge)){
		show_debug_message("i doged the dot (i am the funny :) )");
	}else{
		switch(_dot.typeOfDot){
			case dotTypes.poison: 
				if(poisonDot != false ){
					if(poisonDot.amount < _dot.amount){
						poisonDot = _dot;
						poisonDot.effect();
					}else if(poisonDot.amount > _dot.amount){
						poisonDot.duration ++;
					}else{
						poisonDot = dot;
						poisonDot.effect();
					}
				}
			break;
		case dotTypes.bleed:		
			if(bleedDot != false ){
				if(bleedDot.amount < _dot.amount){
					bleedDot = _dot;
					bleedDot.effect();
				}else if(bleedDot.amount > _dot.amount){
					bleedDot.duration ++;
				}else{
					bleedDot = _dot;
					bleedDot.effect();
				}
			}	
		}
	}
	
}

function applieDotsToTargets(_targets, _dot){
	for(var i = 0; i < array_length(_targets); i ++){
		var target = _targets[i];
		_dot.target = target;
		target.applyDot(_dot);
	}
}

#endregion

#region attack Stuff

var title = "deafault Attack";
var describtion = "someone fucked up I guess";
attack1Stru= new attacksDesribtion(self, 0.55,15, 10,dmgType.melee, 0.2,0.3,
title, describtion,1, 100);
function attack1(_list){}

attack2Stru = new attacksDesribtion(self, 0.55,15, 10,dmgType.melee, 0.2,0.3,
title, describtion,1, 100);
function attack2(_list){}

attack3Stru = new attacksDesribtion(self, 0.55,15, 10,dmgType.melee, 0.2,0.3,
title, describtion,1, 100);
function attack3(_list){}

function basicDmgAttack(_targets, _attackStruc, _actionTaken){
	show_debug_message("i was used by: " + string(id));
	var attackStru = _attackStruc;
	var accuracy = attackStru.acc;
	var dmg = attackStru.dmg; 
	var type = attackStru.dmgTypeAttack;
	var pen = attackStru.pen;
	var critC = attackStru.critChance;
	var result = false;

	
	for (var i = 0;	i < array_length(_targets); i++) {
	    if(checkAgainstRandom100(accuracy, (attackStru.owner.reRollAcc + attackStru.rerolls))){
			var target = _targets[i];
			
			if(checkAgainstRandom100(critC, attackStru.owner.reRollCrit)){
				dmg = dmg * attackStru.owner.critMultiplier;
			}
			
			result = target.damageUnit(dmg, type, pen);
		} else{
			show_debug_message("miss");
			result = false;
		}
	}
	
	//have to add animations :) 

	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
	return result;
	
}

function updateTargetNumbers(){
	attack1Stru.updateTargetNumbers();
	attack2Stru.updateTargetNumbers();
	attack3Stru.updateTargetNumbers();
}

//the basicAttackStruct is used when asked for a attack 
//example: DUEL / wrath (current form :) )
basicAttackStruct = new attacksDesribtion(self, 0.55,15, 10,dmgType.melee, 0.2,0.3,
title, describtion,1, 100);

#endregion

#region checkIfBuffDeBuffBetter

//checks if the Buff is stronger 
//the replaces / addes (if none was there) / duration ++ (if worse)
function checkIfBuffBetterAndUse(_buff){
	switch(_buff.typeOfBuff){
		case buffTypes.tempo:
			if(buffTempo != false){
				if(buffTempo.amount < _buff.amount){
					buffTempo = _buff;
					buffTempo.effect();
				}else {
					buffTempo.duration ++;
				}
			}else{ 
				buffTempo = _buff;
				buffTempo.effect();
			}
		break;
		
		case buffTypes.doge:
			if(buffDoge!= false){
				if(buffDoge.amount < _buff.amount){
					buffDoge = _buff;
					buffDoge.effect();
				}else {
					buffDoge.duration ++;
				}
			}else{ 
				buffDoge = _buff;
				buffDoge.effect();
			}
		break;
		
		case buffTypes.dmgRed:
			if(buffDmgRed != false){
				if(buffDmgRed.amount < _buff.amount){
					buffDmgRed = _buff;
					buffDmgRed.effect();
				}else {
					buffDmgRed.duration ++;
				}
			}else{ 
				buffDmgRed = _buff;
				buffDmgRed.effect();
			}
		break;
		
		
		//have to add --> var for it to save
		case buffTypes.reRollAcc:
			if(buffReRollAcc!= false){
				if(buffReRollAcc.amount < _buff.amount){
					buffReRollAcc = _buff;
					buffReRollAcc.effect();
				}else {
					buffReRollAcc.duration ++;
				}
			}else{ 
				buffReRollAcc = _buff;
				buffReRollAcc.effect();
			}
		break;
		
		case buffTypes.reRollCrit:
			if(buffReRollCrit!= false){
				if(buffReRollCrit.amount < _buff.amount){
					buffReRollCrit = _buff;
					buffReRollCrit.effect();
				}else {
					buffReRollCrit.duration ++;
				}
			}else{ 
				buffReRollCrit = _buff;
				buffReRollCrit.effect();
			}
		break;
		
		case buffTypes.reRollDoge:
			if(buffReRollDoge != false){
				if(buffReRollDoge.amount < _buff.amount){
					buffReRollDoge = _buff;
					buffReRollDoge.effect();
				}else {
					buffReRollDoge.duration ++;
				}
			}else{ 
				buffReRollDoge = _buff;
				buffReRollDoge.effect();
			}
		break;
	}
}


//checks if the deBuff is stronger 
//the replaces / addes (if none was there) / duration ++ (if worse)
function checkIfDeBuffBetterAndUse(_buff){
	var buff = _buff;
	switch(buff.typeOfBuff){
		case buffTypes.tempo:
			if(deBuffTempo != false){
				if(deBuffTempo.amount < buff.amount){
					deBuffTempo = buff;
					deBuffTempo.effect();
				}else {
					deBuffTempo.duration ++;
				}
			}else{ 
				deBuffTempo = buff;
				deBuffTempo.effect();
			}
		break;
		
		case buffTypes.doge:
			if(deBuffDoge!= false){
				if(deBuffDoge.amount < buff.amount){
					deBuffDoge = buff;
					deBuffDoge.effect();
				}else {
					deBuffDoge.duration ++;
				}
			}else{ 
				deBuffDoge = buff;
				deBuffDoge.effect();
			}
		break;
		
		case buffTypes.dmgRed:
			if(deBuffDmgRed != false){
				if(deBuffDmgRed.amount < buff.amount){
					deBuffDmgRed = buff;
					deBuffDmgRed.effect();
					show_debug_message("i have a better armor deBuff");
				}else {
					deBuffDmgRed.duration ++;
					show_debug_message("i have a longer armor deBuff");
				}
			}else{ 
				deBuffDmgRed = buff;
				deBuffDmgRed.effect();
				show_debug_message("i have a new armor deBuff");
			}
		break;
		
		case buffTypes.reRollAcc:
			if(deBuffReRollAcc != false){
				if(deBuffReRollAcc .amount < buff.amount){
					deBuffReRollAcc = buff;
					deBuffReRollAcc .effect();
				}else {
					deBuffReRollAcc .duration ++;
				}
			}else{ 
				deBuffReRollAcc = buff;
				deBuffReRollAcc .effect();
			}
		break;
		
		case buffTypes.reRollCrit:
			if(deBuffReRollCrit!= false){
				if(deBuffReRollCrit.amount < buff.amount){
					deBuffReRollCrit = buff;
					deBuffReRollCrit.effect();
				}else {
					deBuffReRollCrit.duration ++;
				}
			}else{ 
				deBuffDoge = buff;
				deBuffDoge.effect();
			}
		break;
		
		case buffTypes.reRollDoge:
			if(deBuffDoge!= false){
				if(deBuffDoge.amount < buff.amount){
					deBuffDoge = buff;
					deBuffDoge.effect();
				}else {
					deBuffDoge.duration ++;
				}
			}else{ 
				deBuffDoge = buff;
				deBuffDoge.effect();
			}
		break;
		
	}
}

#endregion

//does all the End of Turn stuff 
//dots, check buffs, ...
function checkEndTurn(){
	
	#region deBuffs 
	
	if(deBuffTempo != false){
		if(deBuffTempo.duration <= 0){
			deBuffTempo.removeEffect();
		}else {
			deBuffTempo.duration --;
		}
	}
	if(deBuffDoge != false){
		if(deBuffDoge.duration <= 0){
			deBuffDoge.removeEffect();
		}else {
			deBuffDoge.duration --;
		}
	}
	if(deBuffDmgRed != false){
		if(deBuffDmgRed.duration <= 0){
			deBuffDmgRed.removeEffect();
		}else {
			deBuffDmgRed.duration --;
		}
	}
	if(deBuffReRollCrit != false){
		if(deBuffReRollCrit.duration <= 0){
			deBuffReRollCrit.removeEffect();
		}else {
			deBuffReRollCrit.duration --;
		}
	}
	if(deBuffReRollAcc != false){
		if(deBuffReRollAcc.duration <= 0){
			deBuffReRollAcc.removeEffect();
		}else {
			deBuffReRollAcc.duration --;
		}
	}
	if(deBuffReRollDoge != false){
		if(deBuffReRollDoge.duration <= 0){
			deBuffReRollDoge.removeEffect();
		}else {
			deBuffReRollDoge.duration --;
		}
	}
	
	#endregion
	
	#region buffs
	
	if(buffTempo != false){
		if(buffTempo.duration <= 0){
			buffTempo.removeEffect();
		}else {
			buffTempo.duration --;
		}
	}
	if(buffDoge != false){
		if(buffDoge.duration <= 0){
			buffDoge.removeEffect();
		}else {
			buffDoge.duration --;
		}
	}
	if(buffReRollAcc != false){
		if(buffReRollAcc.duration <= 0){
			buffReRollAcc.removeEffect();
		} else {
			buffReRollAcc.duration --;
		}
	}
	
	if(buffReRollCrit != false){
		if(buffReRollCrit .duration <= 0){
			buffReRollCrit .removeEffect();
		} else {
			buffReRollCrit .duration --;
		}
	}
	if(buffDmgRed != false){
		if(buffDmgRed.duration <= 0){
			buffDmgRed.removeEffect();
		} else {
			buffDmgRed.duration --;
		}
	}
	
	if(buffReRollDoge != false){
		if(buffReRollDoge.duration <= 0){
			buffReRollDoge.removeEffect();
		} else {
			buffReRollDoge.duration --;
		}
	}
	#endregion
	
	#region DOT
	
	if(poisonDot != false){
		if(poisonDot.duration <= 0){
			poisonDot.removeEffect();
		} else {
			poisonDot.duration --;
		}
	}
	
	if(bleedDot != false){
		if(bleedDot.duration <= 0){
			bleedDot.removeEffect();
		} else {
			bleedDot.duration --;
		}
	}
	
	#endregion
	
	#region stun
	
	if(stuned){
		if(stunResist[1] > 1){
			stunResist[1] --;
		}else{
			stuned = false;
			stunResist = [0,0];
		}
	}
	
	#endregion
	
}


#region lvl Up and points 

//calcualtes the Points value for the DM
//have to add all the new vars here
//REWORK NOT SURE HOW !!!! :)
function calculatePointsValue(){
	var value = 0;
	
	value += maxHealth; //50
	
	value += bloodMeter * 7; //10 //70
	
	value += dmgRedMelee * 10 * 10;//0.5 //50
	value += dmgRedRange * 10 * 20;//0.3 //60
	value += dmgRedMagic * 10 * 30;//0.1 //30

	value += doge * 10 *30; //0.3 //90
	
	value += baseTempo * 0.4; //210 //84
	
	value += attack1.pointValue;
	value += attack2.pointValue;
	value += attack3.pointValue;
	
	return value;
}

//lvl Up based on some Stat ???????
function lvlUp(){

}

#endregion


#region campfireSkills

campfireSkills = [];

//the strukt that is saced for campfireskills
//saves all info needed (maybe needs targeting/number of targets)
function campfireSkill(_title, _description, _effect, _condition, _addInformation = -1) constructor{
	title = _title;
	description= _description;
	onClick = _effect; 
	condition = _condition;
	addInformation = _addInformation;
}

#endregion











