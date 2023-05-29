event_inherited();

chancesOfAttacks = [70,30];

var title = "Upper-Cut";
var describtion = "Try to attack someone at the throat"
attack1Stru = new attacksDesribtion(self, 0.65, 15, 6, dmgType.melee, 0.1, 0.02,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
}

var title = "Stab";
var describtion = "Stab someone in the ribs"
attack1Stru = new attacksDesribtion(self, 0.75, 17, 5, dmgType.melee, 0.15, 0.08,
title, describtion, 1, 250); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack1);
}

basicAttackStruct = attack1Stru;