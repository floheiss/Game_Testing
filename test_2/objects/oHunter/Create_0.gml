event_inherited();

#region varStuff

tempo = 220;

//healthstuffs
baseHealth = 65; 
currentHealth = baseHealth;

reRollCrit = 1;
reRollAcc = 1;

//dmgRedStuff
dmgRedMelee = 0.25;
dmgRedRange = 0.28;
dmgRedMagic = 0.15;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.35; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 3.0;

#region spriteVars
icon = SamuraiIcon;

class = classList.hunter; 

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

aimTaken = false;

var title = "Sharp throw";
var describtion = "Hit an enemy wil a well aimed javelin"
attack1Stru = new attacksDesribtion(0.65, 23, 7, dmgType.melee, 0.08, 0.1,
title, describtion, 1, 250); 
function attack1(_list){
	if(aimTaken){
		with(attack1Stru){
			acc += 0.3;
			pen += 0.05;
			dmg += 15;
			critChance += 0.05; 
		}
	}
	basicDmgAttack(_list, attack1Stru, actions.attack1);
}


title = "Aim for the shoulder";
describtion = "Try to hit an enemy in the shoudler to stop them attacking";
attack2Stru = new attacksDesribtion(0.45, 10, 3, dmgType.ranged, 0.11, 0.08,
title, describtion, 1, 350); 
function attack2(_list){
	if(aimTaken){
		with(attack2Stru){
			acc += 0.3;
			pen += 0.04;
			dmg += 5;
			critChance += 0.07; 
		}
	}
	var result = basicDmgAttack(_list, attack2Stru, actions.attack2);
	if(result){
		var dotDmg = aimTaken ? 2 : 3;
		var bleed = new damageOverTime(2, dotDmg, dotTypes.bleed, undefined);
		applieDotsToTargets(_list, bleed);
	
	}
}


title = "Javelin rain";
describtion = "Fill the sky with javelins that rain on enemies";
attack3Stru = new attacksDesribtion(0.35, 5, 2, dmgType.ranged, 0.05, 0.06,
title, describtion, 10, 150); 
function attack3(_list){
	if(aimTaken){
		with(attack3Stru){
			pen += 0.05;
			dmg += 10;
		}
	}
	basicDmgAttack(_list, attack3Stru, actions.attack3);
	
}

#endregion

#region aimTaken 
aimTaken = false;

//aimTaken --> will be set with a skill
//like in the missonary the mericals and conquistador gun

#endregion

