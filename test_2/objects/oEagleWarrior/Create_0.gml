event_inherited();

#region varStuff

tempo = 190;

//healthstuffs
baseHealth = 85; 
currentHealth = baseHealth;



//dmgRedStuff
dmgRedMelee = 0.15;
dmgRedRange = 0.2;
dmgRedMagic = 0.1;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.09; 

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

var title = "Swing";
var describtion = "Swing your weapon at an enemy"
attack1Stru = new attacksDesribtion(0.75, 30, 10, dmgType.melee, 0.15, 0.11,
title, describtion, 1, 100); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
}

title = "Hit the head";
describtion = "Aim for the head to make the target unconscious";
attack2Stru = new attacksDesribtion(0.8, 10, 5, dmgType.melee, 0.08, 0.08,
title, describtion, 1, 300, 1); 
function attack2(_list){
	var result = basicDmgAttack(_list, attack2Stru, actions.attack2);
	if(result){
		var target =_list[|0];
		var stunResult = target.stunUnit(attack2Stru.acc, reRollAcc, 0.45);
		if(stunResult){
			var deBuff = new buffDeBuff(2, 0.05, buffTypes.doge,target, false);
			target.checkIfDeBuffBetterAndUse(deBuff);
		}
	}
}


title = "Bola throw";
describtion = "Throw a bolas at 2 enemies";
attack3Stru = new attacksDesribtion(0.8, 5, 2, dmgType.ranged, 0.0, 0.07,
title, describtion, 2, 300); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack3);
	for(i = 0; i < ds_list_size(_list); i ++){
		var target = _list[|i];
		var _stun = target.stunUnit(0.8, reRollAcc + 1, 0.3);
		if(_stun){
			var deBuff = new buffDeBuff(3, 0.09, buffTypes.doge, target, false);
			target.checkIfDeBuffBetterAndUse(deBuff);
		}	
	}
}

#endregion


