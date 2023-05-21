event_inherited();

#region varStuff

tempo = 180;

//healthstuffs
baseHealth = 70; 
currentHealth = baseHealth;



//dmgRedStuff
dmgRedMelee = 0.3;
dmgRedRange = 0.25;
dmgRedMagic = 0.08;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.35; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 2.25;

#region spriteVars
icon = SamuraiIcon;

class = classList.footsoldiar; 

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

var title = "Lunge";
var describtion = "Lung at someone with your spear"
attack1Stru = new attacksDesribtion(0.55, 25, 8, dmgType.melee, 0.4, 0.45,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
}

defensiveStance = false;
title = "Take defensive stance";
describtion = "Take a more defence position";
//have to look how thing work when no target needed ???
//if self / all full team 
attack2Stru = new attacksDesribtion(0.9, 20, 10, dmgType.melee, 0.45, 0.15,
title, describtion, 10, 500, 0, checkDefensiveStance); 
function attack2(_list){
	var buff = buffDeBuff(3,0.2,buffTypes.dmgRed,self,true, checkDefensiveStance);
	checkIfBuffBetterAndUse(buff);
	
	defensiveStance = true;
}


title = "Round Sweep";
describtion = "Sweep all Enemies with your spear";
attack3Stru = new attacksDesribtion(0.55, 20, 8, dmgType.melee, 0.2, 0.3,
title, describtion, 10, 250); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack3);
}

#endregion


