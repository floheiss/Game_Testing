event_inherited();

#region varStuff

tempo = 200;

//healthstuffs
baseHealth = 75; 
currentHealth = baseHealth;

reRollCrit = 1;
reRollCrit = 1;
reRollAcc = 1;

//dmgRedStuff
dmgRedMelee = 0.2;
dmgRedRange = 0.15;
dmgRedMagic = 0.1;

//doge is used for all kindes of doge (dots, stuns, dots)
doge = 0.1; 

//has bad crit mulit as fokus on raw dmg 
critMultiplier = 2.2;

#region spriteVars
icon = SamuraiIcon;

class = classList.nobal; 

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
attack1Stru = new attacksDesribtion(self, 0.55, 30, 10, dmgType.melee, 0.25, 0.3,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
	var bleed = new damageOverTime(3, 4, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
}


title = "";
describtion = "";
attack2Stru = new attacksDesribtion(self, 0.5, 50, 20, dmgType.ranged, 0.45, 0.15,
title, describtion, 1, 500, -1, checkReloded); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack2);
	var dotDmg = floor(_list[|0].baseHealth * 0.1);
	var bleed = new damageOverTime(2, dotDmg, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
	reloaded = false;
}


title = "";
describtion = ""
attack3Stru = new attacksDesribtion(self, 0.75, 15, 7, dmgType.melee, 0.15, 0.2,
title, describtion, 1, 100); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack2);
	var bleed = new damageOverTime(5, 2, dotTypes.bleed, undefined);
	applieDotsToTargets(_list, bleed);
	
}

#endregion

#region reposting and adjusted damageUnit 
reposting = false; 

function damageUnit(_dmgNumber, _dmgType, _armorPen){
	if(doge > 0.95){
		var dogeCal = 0.95;
	}else{
		dogeCal = doge;
	}
 	if(checkAgainstRandom100(dogeCal, reRollDoge)){
		show_debug_message("Doged");
	} else {
		var dmgRedction = 0;
		switch(_dmgType){
			case dmgType.melee: 
				dmgRedction = dmgRedMelee;
			break;
			case dmgType.ranged: 
				dmgRedction = dmgRedRange;
			break;
			case dmgType.magic: 
				dmgRedction = dmgRedMagic;
			break;
		}
		dmgRedction -= _armorPen;
		
		if(dmgRedction < 0){
			dmgRedction = 0;
		}
		if(dmgRedction > 0.9){
			dmgRedction = 0.9;
		}
		
		// - for even more dmg ??? 
		var amountDamaged = _dmgNumber - (_dmgNumber*dmgRedction);
		amountDamaged = ceil(amountDamaged);
		currentHealth -=  amountDamaged;
		if(reposting && _dmgType == dmgType.melee){
			var target = ds_list_create();
			ds_list_add(target,mCombat.selectedUnit);
			var repostAttack = new attacksDesribtion(0.5,15,5,dmgType.melee,0.2,0.08,"","",1);
			basicDmgAttack(target,repostAttack , actions.attack1);
			
		}
		
		show_debug_message("i have " + string(currentHealth));
		show_debug_message("i take " + string(amountDamaged) + " dmg");
		show_debug_message("i have " + string(currentHealth));
	}	
	checkDeath();
}

#endregion

