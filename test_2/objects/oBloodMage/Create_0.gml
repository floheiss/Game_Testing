event_inherited();

#region varStuff

tempo = 500;

maxHealth = 95; 
currentHealth = maxHealth;

dmgRedMelee = 0.15;
dmgRedRange = 0.25;
dmgRedMagic = 0.04;

doge = 0.07; 

critMultiplier = 1.7;

#region spriteVars

sequenceName = sBloodMage;

icon = BloodMage_Icon;

class = classList.bloodMage; 


#endregion

#endregion

#region attacks 

var title = "Thrust";
var describtion = "Thrust at an enemies weak point to hit him"
attack1Stru = new attacksDesribtion(self, 0.75, 15, 7, dmgType.melee, 0.15, 0.08,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
	//var bleed = new damageOverTime(3, 4, dotTypes.bleed, undefined);
	//applieDotsToTargets(_list, bleed);
}


title = "Transfusion";
describtion = "Succ";
attack2Stru = new attacksDesribtion(self, 0.75, 300, 6, dmgType.magic, 1.00, 0.08,
title, describtion, 1, 500); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack2);
	healUnit(300)
}

var reloadCheck = function(){
	show_debug_message("thue check was called");
	var r = owner.reloaded;
	return r;
}

title = "Let him bleed";
describtion = "slice into an enemy resulting in a bleed"
attack3Stru = new attacksDesribtion(self, 0.8, 15, 7, dmgType.melee, 0.08, 0.06,
title, describtion, 1, 100, 0, possibleTargets.enemies, reloadCheck); 
function attack3(_list){
	var result = basicDmgAttack(_list, attack3Stru, actions.attack2);
	reloaded = false;
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
