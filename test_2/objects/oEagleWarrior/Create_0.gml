event_inherited();

#region varStuff

tempo = 190;

//healthstuffs
baseHealth = 80; 
currentHealth = baseHealth;



//dmgRedStuff
dmgRedMelee = 0.5;
dmgRedRange = 0.3;
dmgRedMagic = 0.2;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.35; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 2.3;

#region spriteVars
icon = SamuraiIcon;

class = classList.eagleWarrior; 

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

var title = "";
var describtion = ""
attack1Stru = new attacksDesribtion(0.65, 25, 8, dmgType.melee, 0.7, 0.45,
title, describtion, 1, 100); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
}

title = "Hit the head";
describtion = "Aim for the head to make the target unconscious";
//have to look how thing work when no target needed ???
//if self / all full team 
attack2Stru = new attacksDesribtion(0.8, 15, 8, dmgType.melee, 0.35, 0.25,
title, describtion, 1, 300, 1); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack2);
	
	var target =_list[|0];
	var _stun = target.stunUnit(attack2Stru.acc, 1, 0.75);
	if(_stun){
		var deBuff = new buffDeBuff(2, 0.3, buffTypes.doge,target, false);
		target.checkIfDeBuffBetterAndUse(deBuff);
	}	
}


title = "Bola throw";
describtion = "Throw a bola at 2 enemies";
attack3Stru = new attacksDesribtion(0.75, 5, 3, dmgType.ranged, 0.2, 0.3,
title, describtion, 2, 300); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack3);
	for(i = 0; i < ds_list_size(_list); i ++){
		var target = _list[|i];
		var _stun = target.stunUnit(0.75, 0.3);
		if(_stun){
			var deBuff = new buffDeBuff(3, 0.2,buffTypes.doge,target, false);
			target.checkIfDeBuffBetterAndUse(deBuff);
		}	
	}
}

#endregion


