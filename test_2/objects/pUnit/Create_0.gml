#region var stuff

#region general stuff
team = 0;
position  = 0; //has to be set in class 
class = 0;//has to be set in class 

state = states.IDLE;
unitSequence = 0; //has to be set in class 
//REWORK HOW VISUALS WORK FOR BETTER TRANSPORT
icon = 0;//has to be set in class 


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

maxActionsInTurn = 1;

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
deBuffReRollDoge = false;

baseHealth = 0;
currentHealth = baseHealth;

bloodMeter = 0;
currentBloodLvL = bloodMeter;

dmgRedMelee = 0; //les then 1 
dmgRedRange = 0; //les then 1 
dmgRedMagic = 0; //les then 1 
buffDmgRed= false;
deBuffDmgRed = false;

//Strukt that saves the Bleeds and Posion 
bleedDot = false;
poisonDot = false;
//not sure ends 

doge = 0.0; //les then 1 
buffDoge = false;
deBuffDoge = false;

tempo = 200;
buffTempo = false;
deBuffTempo = false;


lvl = 1; // insert statsbonus from this 
expToNextLvl = 100; //later calculae after lvl up 

#endregion

#region attackStrukt

function createAttacks(_targetNumber, _acc, _dmg, _dmgType, _pen,_pointValue, _title,_describtion, _bloodCost = 0) constructor{
	numberTarget = _targetNumber;
	acc = _acc;
	dmg = _dmg;
	dmgTypeAttack = _dmgType;
	pen = _pen;
	title = _title;
	describtion = _describtion;
	bloodCost = _bloodCost;
	pointValue = _pointValue;
}

#endregion

function damageUnit(dmgNumber, dmgType, armorPen){
	if(doge > 0.95){
		dogeCal = 0.95;
	}else{
		dogeCal = doge;
	}
 	if(checkAgainstRandom100(dogeCal, reRollDoge)){
		show_debug_message("Doged");
	} else {
		dmgRedction = 0;
		switch(dmgType){
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
		dmgRedction -= armorPen;
		
		if(dmgRedction < 0){
			dmgRedction = 0;
		}
		if(dmgRedction > 0.85){
			dmgRedction = 0.85;
		}
		
		// - for even more dmg ??? 
		amountDamaged = dmgNumber - (dmgNumber*dmgRedction);
		amountDamaged = ceil(amountDamaged);
		currentHealth -=  amountDamaged;
		 
		
		show_debug_message("i have " + string(currentHealth));
		show_debug_message("i take " + string(amountDamaged) + " dmg");
		show_debug_message("i have " + string(currentHealth));
	}	
	checkDeath();
}

function applyDot(dot){
	if(doge > 0.95){
		dogeCal = 0.95;
	}else{
		dogeCal = doge;
	}
	if(checkAgainstRandom100(dogeCal, reRollDoge)){
		show_debug_message("i doged the dot (i am the funny : ) )");
	}else{
		switch(dot.typeOfDot){
			case dotTypes.poison: 
				if(poisonDot != false ){
					if(poisonDot.amount < dot.amount){
						poisonDot = dot;
						poisonDot.effect();
					}else if(poisonDot.amount > dot.amount){
						poisonDot.duration ++;
					}else{
						poisonDot = dot;
						poisonDot.effect();
					}
				}
			break;
		case dotTypes.bleed:		
			if(bleedDot != false ){
				if(bleedDot.amount < dot.amount){
					bleedDot = dot;
					bleedDot.effect();
				}else if(bleedDot.amount > dot.amount){
					bleedDot.duration ++;
				}else{
					bleedDot = dot;
					bleedDot.effect();
				}
			}	
		}
	}
	
}

function healUnit(heal){ 
	if(currentHealth + heal < maxHealth){
		currentHealth += heal;
	} else {
		currentHealth = baseHealth;
	}
	show_debug_message("i have " + string(currentHealth) );
	show_debug_message("i heal for " + string(heal));
	show_debug_message("i have " + string(currentHealth) );
}

function checkDeath(){
		if(currentHealth <= 0){
			show_debug_message("i am dead");
		if(team == 0){
			ds_list_delete(mCombat.team0, ds_list_find_index(mCombat.team0, id));
		} 
		if(team == 1){
			ds_list_delete(mCombat.team1, ds_list_find_index(mCombat.team1, id));
		}
		layer_sequence_headpos(unitSequence, deathStart);
		ds_list_delete(mCombat.units, ds_list_find_index(mCombat.units, id));
		state = states.DEATH;
	}
}

#region attack Stuff

title = "deafault Attack";
describtion = "someone fucked up I guess";
attack1 = new createAttacks(1,0.55,(30 + 10 * lvl),dmgType.melee, 0.2,100,title, describtion); ;
numberTargetAttack1 = 1;
canTargetAttack1 = possibleTargets.enemies;
function attack1(list){}

attack2 = false;
numberTargetAttack2 = 1; 
canTargetAttack2 = possibleTargets.enemies;
function attack2(list){}

attack3 = false;
numberTargetAttack3 = 1; 
canTargetAttack3 = possibleTargets.enemies;
function attack3(list){}

function updateTargetNumbers(){

}

#endregion

//checks if the Buff is stronger 
//the replaces / addes (if none was there) / duration ++ (if worse)
function checkIfBuffBetterAndUse(buff){
	switch(buff.typeOfBuff){
		case buffTypes.tempo:
			if(buffTempo != false){
				if(buffTempo.amount < buff.amount){
					buffTempo = buff;
					buffTempo.effect();
				}else {
					buffTempo.duration ++;
				}
			}else{ 
				buffTempo = buff;
				buffTempo.effect();
			}
		break;
		
		case buffTypes.doge:
			if(buffDoge!= false){
				if(buffDoge.amount < buff.amount){
					buffDoge = buff;
					buffDoge.effect();
				}else {
					buffDoge.duration ++;
				}
			}else{ 
				buffDoge = buff;
				buffDoge.effect();
			}
		break;
		
		case buffTypes.dmgRed:
			if(buffDmgRed != false){
				if(buffDmgRed.amount < buff.amount){
					buffDmgRed = buff;
					buffDmgRed.effect();
				}else {
					buffDmgRed.duration ++;
				}
			}else{ 
				buffDmgRed = buff;
				buffDmgRed.effect();
			}
		break;
		
		
		//have to add --> var for it to save
		case buffTypes.reRollAcc:
			if(buffReRollAcc!= false){
				if(buffReRollAcc.amount < buff.amount){
					buffReRollAcc = buff;
					buffReRollAcc.effect();
				}else {
					buffReRollAcc.duration ++;
				}
			}else{ 
				buffReRollAcc = buff;
				buffReRollAcc.effect();
			}
		break;
		
		case buffTypes.reRollCrit:
			if(buffReRollCrit!= false){
				if(buffReRollCrit.amount < buff.amount){
					buffReRollCrit = buff;
					buffReRollCrit.effect();
				}else {
					buffReRollCrit.duration ++;
				}
			}else{ 
				buffReRollCrit= buff;
				buffReRollCrit.effect();
			}
		break;
		
		case buffTypes.reRollDoge:
			if(buffReRollDoge != false){
				if(buffReRollDoge.amount < buff.amount){
					buffReRollDoge = buff;
					buffReRollDoge.effect();
				}else {
					buffReRollDoge.duration ++;
				}
			}else{ 
				buffReRollDoge = buff;
				buffReRollDoge.effect();
			}
		break;
	}
}

//checks if the deBuff is stronger 
//the replaces / addes (if none was there) / duration ++ (if worse)
function checkIfDeBuffBetterAndUse(buff){
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
	
}

//calcualtes the Points value for the DM
//have to add all the new vars here
//REWORK NOT SURE HOW !!!! :)
function calculatePointsValue(){
	value = 0;
	
	value += baseHealth; //50
	
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

#region campfireSkills
campfireSkills = []

#endregion











