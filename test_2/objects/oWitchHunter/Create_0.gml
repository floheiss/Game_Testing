event_inherited();

#region varStuff

tempo = 195;

//healthstuffs
baseHealth = 95; 
currentHealth = baseHealth;

maxActionsInTurn = 2;

//dmgRedStuff
dmgRedMelee = 0.15;
dmgRedRange = 0.18;
dmgRedMagic = 0.3;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.12; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 2.5;

#region spriteVars
icon = SamuraiIcon;

class = classList.witchhunter; 

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
attack1Stru = new attacksDesribtion(0.55, 30, 10, dmgType.melee, 0.25, 0.3,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
	var bleed = new damageOverTime(3, 4, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
}

reloaded = true;
title = "Silver bolt";
describtion = "Use your arbalest to smite the inpure";
attack2Stru = new attacksDesribtion(0.95, 35, 12, dmgType.ranged, 0.15, 0.09,
title, describtion, 1, 300, 1, checkReloded); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack2);
	reloaded = false;
}


title = "";
describtion = ""
attack3Stru = new attacksDesribtion(0.75, 15, 7, dmgType.melee, 0.15, 0.2,
title, describtion, 1, 100); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack2);
	var bleed = new damageOverTime(5, 2, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
	
}

#endregion

#region spellShield

spellShield = false;
//gives a 1 time spellshield that protects from magic dmg
	//will negate the dmg 

#endregion

