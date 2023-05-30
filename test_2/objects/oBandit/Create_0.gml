event_inherited();

#region varStuff

tempo = 195;

maxHealth = 50; 
currentHealth = maxHealth;

dmgRedMelee = 0.05;
dmgRedRange = 0.10;
dmgRedMagic = 0.02;

doge = 0.09; 

critMultiplier = 1.9;

class = classList.bandit; 

sequenceName = sBandit;

icon = Bandite_Icon;

#endregion

chancesOfAttacks = [60,30];

var title = "Upper-Cut";
var describtion = "Try to attack someone at the throat"// 0.65
attack1Stru = new attacksDesribtion(self, 0.65, 15, 6, dmgType.melee, 0.1, 0.02,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
}

var title = "Stab";
var describtion = "Stab someone in the ribs"// 0.75
attack1Stru = new attacksDesribtion(self, 0.75, 17, 5, dmgType.melee, 0.15, 0.08,
title, describtion, 1, 250); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack1);
}

basicAttackStruct = attack1Stru;