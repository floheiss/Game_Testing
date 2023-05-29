event_inherited();

#region varStuff

tempo = 180;

//healthstuffs
baseHealth = 95; 
currentHealth = baseHealth;



//dmgRedStuff
dmgRedMelee = 0.15;
dmgRedRange = 0.25;
dmgRedMagic = 0.04;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.07; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 1.7;

#region spriteVars
icon = BloodMage_Icon;

class = classList.bloodMage; 

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

var title = "Thrust";
var describtion = "Thrust at an enemies weak point to hit him"
attack1Stru = new attacksDesribtion(self, 0.75, 25, 7, dmgType.melee, 0.15, 0.08,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
	var bleed = new damageOverTime(3, 4, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
}

reloaded = true;
title = "Gun !";
describtion = "Shoot somebody";
attack2Stru = new attacksDesribtion(self, 0.6, 55, 20, dmgType.ranged, 0.45, 0.07,
title, describtion, 1, 500, -1, checkReloded); 
function attack2(_list){
	var result = basicDmgAttack(_list, attack2Stru, actions.attack2);
	if(result){
		var dotDmg = 6;
		var bleed = new damageOverTime(2, dotDmg, dotTypes.bleed, undefined);
		applieDotsToTargets(_list, bleed);
	
	}
	reloaded = false;
}

title = "Let him bleed";
describtion = "slice into an enemy resulting in a bleed"
attack3Stru = new attacksDesribtion(self, 0.8, 15, 7, dmgType.melee, 0.08, 0.06,
title, describtion, 1, 100); 
function attack3(_list){
	var result = basicDmgAttack(_list, attack3Stru, actions.attack2);
	if(result){
		var bleed = new damageOverTime(5, 2, dotTypes.bleed, undefined);
		applieDotsToTargets(_list, bleed);
	}
}



#endregion

#region campfireSkills

campfireSkills = [];

var title = "Prepare equipment";
var describtion = "Sit by the campfire and prepare your weapon and armor for the next combat";
var effectCampFire = prepareEquipment;
var condition = true;

campfireSkills[0] = new campfireSkill(title, describtion, effectCampFire, true);

#endregion
