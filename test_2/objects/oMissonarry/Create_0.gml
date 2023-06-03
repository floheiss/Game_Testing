event_inherited();

#region varStuff

tempo = 165;

//healthstuffs
maxHealth = 65; 
currentHealth = maxHealth;

//dmgRedStuff
dmgRedMelee = 0.08;
dmgRedRange = 0.1;
dmgRedMagic = 0.25;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.04; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 2.3;

#region spriteVars
icon = Missonarry_Icon;

class = classList.missonarry; 

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



var title = "Call for a merical of sloth";
var describtion = "Call on GOD to break the will of an enemie";
attack1Stru = new attacksDesribtion(self, 0.6, 20, 10, dmgType.magic, 0.1, 0.15,
title, describtion, 1, 250, 0, undefined, checkMericals); 
function attack1(_list){
	
	checkAgainstRandom100(attack1Stru.acc){
			var deBuffAcc = 1;
			var deBuffDmgRed = 0.09;
			var deBuffTempo = 80;
			if(checkAgainstRandom100(attack1Stru.critChance, reRollCrit)){
				deBuffAcc = 2;
				deBuffDmgRed = 0.2;
				deBuffTempo = 100;
			}
			var target = _list[i];
			
			var deBuff = new buffDeBuff(3,deBuffAcc,buffTypes.reRollAcc,target,false);
			target.checkIfDeBuffBetterAndUse(deBuff);
			
			deBuff = new buffDeBuff(3,deBuffDmgRed,buffTypes.dmgRed,target,false);
			target.checkIfDeBuffBetterAndUse(deBuff);
			
			deBuff = new buffDeBuff(3, deBuffTempo,buffTypes.tempo,target,false);
			target.checkIfDeBuffBetterAndUse(deBuff);
		}
	
	if(checkAgainstRandom100(attack1Stru.pen)){
		//if you hit the 10% nEC --> you take 75% of currentHP dmg
		self.damageUnit(currentHealth * 0.75, dmgType.magic, 2);
	}
	

	ds_list_destroy(_list);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;	
	mericalsLeft --;
}


title = "Call for a merical of glottony";
describtion = "Call on GOD to heal you and your team in this time of need";
attack2Stru = new attacksDesribtion(self, 0.7, 20, 10, dmgType.ranged, 0.1, 0.3,
title, describtion, 10, 300, 0, possibleTargets.allies, checkMericals); 
function attack2(_list){
	var attackStru = attack2Stru;
	var accuracy = attackStru.acc;
	var heal = attackStru.dmg; 
	var nEC = attackStru.pen; //negativeEffectChance
	var critC = attackStru.critChance;
	
	
	var deBuff = new buffDeBuff(3,0.05,buffTypes.doge,self,false);
	
	checkIfDeBuffBetterAndUse(deBuff);
	healUnit(attack2Stru.dmg);
	
	for (var i = 0;	i < array_length(_list); i++) {
		checkAgainstRandom100(attack2Stru.acc, reRollAcc){
			var target = attackList[i];
			target.healUnit(attack2Stru.dmg);
			deBuff.target = target;
			target.checkIfDeBuffBetterAndUse(deBuff);
		}
	
	}
	
	
	if(checkAgainstRandom100(attack2Stru.pen)){
		//if you hit the 10% nEC --> you take 75% of currentHP dmg
		self.damageUnit(currentHealth * 0.75, dmgType.magic, 2);
	}
	

	ds_list_destroy(_list);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;	
	mericalsLeft --;
}


title = "Call for a merical of warth";
describtion = "Call on GOD to have 2 enemies fight";
attack3Stru = new attacksDesribtion(self, 0.7, 15, 7, dmgType.melee, 0.1, 0.08,
title, describtion, 2, 100, 0, possibleTargets.enemies, checkMericalsAND2Enemies); 
function attack3(_list){
	
	//targets 2 enemies that fight each other once 
	//not sure how it will work have to look at 
	
	mericalsLeft --;
}

#endregion

#region regain mericals 

mericalsMAX = 3;
mericalsLeft = mericalsMAX; 
 
//will be reset / filled with skill 


#endregion
