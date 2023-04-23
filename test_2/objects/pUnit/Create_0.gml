#region var stuff

#region general stuff
team = 0;
position  = 0;
class = 0;

state = states.IDLE;

actionsInTurn = 0; 
maxActionsInTurn = 1;
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

reRollCrit = 0;
reRollDoge = 0;
reRollAcc = 0;

baseHealth = 0;
buffHealth = false;
deBuffHealth = false;
currentHealth = baseHealth;

bloodMeter = 0;
buffBlood = false;
deBuffBlood = false;
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


lvl = 1; // insert statsbonus from this 
expToNextLvl = 100; //later calculae after lvl up 

tempo = 200 + irandom_range(1,10);
buffTempo = false;
deBuffTempo = false;




#endregion






function damageUnit(dmgNumber, dmgType, armorPen){
	dogeVaule = random(1); 
	if(doge > 0.95){
		doge = 0.95;
	}
 	if(dogeVaule < doge){
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
		if(dmgRedction > 0.9){
			dmgRedction = 0.9;
		}
		
		// - for even more dmg ??? 
		amountDamaged = dmgNumber - (dmgNumber*dmgRedction);
		amountDamaged = ceil(amountDamaged);
		currentHealth -=  amountDamaged;
		 
		
		show_debug_message("i take " + string(amountDamaged) + " dmg");
		show_debug_message("i have " + string(currentHealth));
	}	
	checkDeath();
}

function applyDot(dot){
	dogeVaule = random(1); 
	if(doge > 0.95){
		doge = 0.95;
	}
	if(doge > 0.95){
		doge = 0.95;
	}
	switch(dot.typeOfDot){
		case dotTypes.poison: 
			if(dogeVaule < doge){
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
			}else{
				show_debug_message("i doged the poision");
			}
		break;
		case dotTypes.bleed:
			if(dogeVaule < doge){
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
			}else{
				show_debug_message("i doged the bleed");
			}
		break;
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

title = "deafault Attack";
describtion = "someone fucked up I guess";
attack1 = new mAttacks.createAttacks(1,0.55,(30 + 10 * lvl),dmgType.melee, 0.2,100,title, describtion); ;
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
					show_debug_message("i have a better armor Buff");
				}else {
					buffDmgRed.duration ++;
					show_debug_message("i have a longer armor Buff");
				}
			}else{ 
				buffDmgRed = buff;
				buffDmgRed.effect();
				show_debug_message("i have a new armor Buff");
			}
		break;
		
		
		//have to add --> var for it to save
		case buffTypes.reRollAcc:
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
		
		case buffTypes.reRollCrit:
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
		
		case buffTypes.reRollDoge:
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
	}
}

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
					show_debug_message("i have a better armor Buff");
				}else {
					deBuffDmgRed.duration ++;
					show_debug_message("i have a longer armor Buff");
				}
			}else{ 
				deBuffDmgRed = buff;
				deBuffDmgRed.effect();
				show_debug_message("i have a new armor Buff");
			}
		break;
		
		case buffTypes.reRollAcc:
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
		
		case buffTypes.reRollCrit:
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

function checkEndTurn(){
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
	if(deBuffHealth != false){
		if(deBuffHealth.duration <= 0){
			deBuffHealth.removeEffect();
		}else {
			deBuffHealth.duration --;
		}
	}
	if(deBuffBlood != false){
		if(deBuffBlood.duration <= 0){
			deBuffBlood.removeEffect();
		}else {
			deBuffBlood.duration --;
		}
	}
	if(deBuffDmgRed != false){
		if(deBuffDmgRed.duration <= 0){
			deBuffDmgRed.removeEffect();
		}else {
			deBuffDmgRed.duration --;
		}
	}
	
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
	if(buffHealth != false){
		if(buffHealth.duration <= 0){
			buffHealth.removeEffect();
		}else {
			buffHealth.duration --;
		}
	}
	if(buffBlood != false){
		if(buffBlood.duration <= 0){
			buffBlood.removeEffect();
		}else {
			buffBlood.duration --;
		}
	}
	if(buffDmgRed != false){
		if(buffDmgRed.duration <= 0){
			buffDmgRed.removeEffect();
		} else {
			buffDmgRed.duration --;
		}
	}
	
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


















