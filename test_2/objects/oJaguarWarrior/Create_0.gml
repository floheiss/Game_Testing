event_inherited();

#region varStuff

tempo = 165;

//healthstuffs
maxHealth = 105; 
currentHealth = maxHealth;

reRollDoge = -1;
reRollAcc = -1;

//dmgRedStuff
dmgRedMelee = 0.15;
dmgRedRange = 0.18;
dmgRedMagic = 0.1;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.1; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 1.8;

#region spriteVars
icon = SamuraiIcon;

class = classList.jaguarWarrior; 

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

var title = "Cut them down";
var describtion = "Attack 1 enemy with a devestating attack"
attack1Stru = new attacksDesribtion(self, 0.95, 70, 15, dmgType.melee, 0.3, 0.1,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
}


title = "Sweep";
describtion = "Make a big sweeping attack that hits 2 enemies ";
attack2Stru = new attacksDesribtion(self, 0.8, 40, 8, dmgType.melee, 0.15, 0.1,
title, describtion, 2, 250); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack1);
}


title = "DUEL !!!";
describtion = "Pick an enemy and fight him to DEATH";
attack3Stru = new attacksDesribtion(self, 0.6, 30, 9, dmgType.melee, 0.18, 0.2,
title, describtion, 1, 100, 2, checkOnlyOneEnemy); 
function attack3(_list){
	//select 1 target you hit it with your 1 till you or it dies 
	//you get a +1 accReRoll buff while attacking 
		//the lower the enemy the more dmg you do
		//and can only be used when 1 enemy 
		//might heal you if you eat some part of the killed enemy (not sure)
	
}

#endregion


