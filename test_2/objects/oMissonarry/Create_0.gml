event_inherited();

#region varStuff

tempo = 210;

//healthstuffs
baseHealth = 50; 
currentHealth = baseHealth;

//dmgRedStuff
dmgRedMelee = 0.05;
dmgRedRange = 0.15;
dmgRedMagic = 0.25;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.08; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 2.3;

mericalsLeft = 3; 

#region spriteVars
icon = SamuraiIcon;

class = classList.missonarry; 

//spriteStuff
idleStart = 0;
idleEnd = 11;


attack1Start = 12;
attack1End = 24;

attack2Start = 26;
attack2End = 42;

attack3Start = 43;
attack3End = 54;

hurtStart = 56;
hurtEnd = 65;

deathStart = 66;
deathEnd = 80;
#endregion

#endregion


#region attacks 

/*
note maybe needed later for duals (all need some basic melee attack)
var title = "Meager Fists";
var describtion = "Hit someone with your fists";
attack3Stru = new attacksDesribtion(0.25, 10, 5, dmgType.melee, 0.0, 0.1,
title, describtion, 1, 100); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack3);
}
*/


var title = "Call for a merical of sloth";
var describtion = "Call on GOD to break the will of an enemie";
attack1Stru = new attacksDesribtion(0.6, 20, 10, dmgType.magic, 0.1, 0.15,
title, describtion, 1, 250, 0, undefined, checkMericals); 
function attack1(_list){
	var attackStru = attack1Stru;
	var accuracy = attackStru.acc;
	var nEC = attackStru.pen; //negativeEffectChance
	var critC = attackStru.critChance;
	
	var attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(_list);i ++){
		ds_list_add(attackList, _list[| i]);
		//show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	for (i = 0;	i < ds_list_size(attackList); i++) {
		checkAgainstRandom100(accuracy){
			var deBuffAcc = 1;
			var deBuffDmgRed = 0.15;
			var deBuffDoge = 1;
			if(checkAgainstRandom100(critC, reRollCrit)){
				deBuffAcc = 2;
				deBuffDmgRed = 0.45;
				deBuffDoge = 2;
			}
			var target = attackList[|i];
			
			var deBuff = new buffDeBuff(3,deBuffAcc,buffTypes.reRollAcc,target,false);
			target.checkIfDeBuffBetterAndUse(deBuff);
			
			deBuff = new buffDeBuff(3,deBuffDmgRed,buffTypes.dmgRed,target,false);
			target.checkIfDeBuffBetterAndUse(deBuff);
			
			deBuff = new buffDeBuff(3, deBuffDoge,buffTypes.reRollDoge,target,false);
			target.checkIfDeBuffBetterAndUse(deBuff);
		}
	
	}
	
	if(checkAgainstRandom100(nEC)){
		//if you hit the 10% nEC --> you take 75% of currentHP dmg
		self.damageUnit(currentHealth * 0.75, dmgType.magic, 2);
	}
	

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;	
	mericalsLeft --;
}


title = "Call for a merical of charity";
describtion = "Call on GOD to heal you and your team in this time of need";
attack2Stru = new attacksDesribtion(0.7, 20, 10, dmgType.ranged, 0.1, 0.3,
title, describtion, 10, 300, 0, possibleTargets.allies, checkMericals); 
function attack2(_list){
	var attackStru = attack2Stru;
	var accuracy = attackStru.acc;
	var heal = attackStru.dmg; 
	var nEC = attackStru.pen; //negativeEffectChance
	var critC = attackStru.critChance;
	
	var attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(_list);i ++){
		ds_list_add(attackList, _list[| i]);
		//show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	for (i = 0;	i < ds_list_size(attackList); i++) {
		checkAgainstRandom100(accuracy){
			var target = attackList[|i];
			target.healUnit(heal);
		}
	
	}
	healUnit(heal);
	
	if(checkAgainstRandom100(nEC)){
		//if you hit the 10% nEC --> you take 75% of currentHP dmg
		self.damageUnit(currentHealth * 0.75, dmgType.magic, 2);
	}
	

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;	
	mericalsLeft --;
}


title = "Call for a merical of warth";
describtion = "Cut into one enemy from the outside to the inside"
attack3Stru = new attacksDesribtion(0.75, 15, 7, dmgType.melee, 0.15, 0.2,
title, describtion, 2, 100, 0, possibleTargets.enemies, checkMericalsAND2Enemies); 
function attack3(_list){
	
	//targets 2 enemies that fight each other once 
	//not sure how it will work have to look at 
	
	mericalsLeft --;
}

#endregion


