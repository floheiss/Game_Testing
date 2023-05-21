event_inherited();

#region varStuff

tempo = 210;

//healthstuffs
baseHealth = 100; 
currentHealth = baseHealth;



//dmgRedStuff
dmgRedMelee = 0.2;
dmgRedRange = 0.35;
dmgRedMagic = 0.08;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.2; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 1.5;

#region spriteVars
icon = SamuraiIcon;

class = classList.conquistador; 

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

var title = "Thrust ";
var describtion = "Thrust at an enemies weak point to hit him"
attack1Stru = new attacksDesribtion(0.55, 30, 10, dmgType.melee, 0.25, 0.3,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
	var bleed = new damageOverTime(3, 4, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
}

reloaded = true;
title = "Gun !";
describtion = "Shoot somebody (Note you have to reload)";
attack2Stru = new attacksDesribtion(0.5, 50, 20, dmgType.ranged, 0.45, 0.15,
title, describtion, 1, 500, -1, checkReloded); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack2);
	var dotDmg = floor(_list[|0].baseHealth * 0.1);
	var bleed = new damageOverTime(2, dotDmg, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
	reloaded = false;
}


title = "Cut Mandritto";
describtion = "Cut into one enemy from the outside to the inside"
attack3Stru = new attacksDesribtion(0.75, 15, 7, dmgType.melee, 0.15, 0.2,
title, describtion, 1, 100); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack2);
	var bleed = new damageOverTime(5, 2, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
	
}



#endregion


