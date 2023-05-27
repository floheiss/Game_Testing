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

var title = "Passata Sotto";
var describtion = "Drop below an enemy and attack him";
attack1Stru = new attacksDesribtion(self, 0.75, 18, 7, dmgType.melee, 0.1, 0.12,
title, describtion, 1, 250); 
function attack1(_list){
	basicDmgAttack(_list, attack1Stru, actions.attack1);
	var buff = new buffDeBuff(2,0.15,buffTypes.doge,self,true);
	checkIfBuffBetterAndUse(buff);
}


title = "Flunge";
describtion = "Jump towards an enemy and attack him ";
attack2Stru = new attacksDesribtion(self, 0.8, 25, 9, dmgType.melee, 0.09, 0.1,
title, describtion, 1, 150); 
function attack2(_list){
	basicDmgAttack(_list, attack2Stru, actions.attack2);
}


title = "Call for a merical of envy";
describtion = "Call on GOD to smite your enmies "
attack3Stru = new attacksDesribtion(self, 0.85, 18, 5, dmgType.magic, 0.0, 0.1,
title, describtion, 1, 100); 
function attack3(_list){
	basicDmgAttack(_list, attack3Stru, actions.attack3);
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

#region regain mericals 

mericalsMAX = 1;
mericalsLeft = mericalsMAX; 
 
//will be reset / filled with skill 
//not sure as some classes have this stuff so ??????
//there will be 7 merical --> 7 sins (i am lost at the mo for ideas)
	//small side note priest will be delayed for the mo as i am lost for ideas :( 


#endregion
