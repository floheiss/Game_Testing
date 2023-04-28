event_inherited();
baseTempo = 200 + irandom_range(1,10);



//healthstuffs
baseHealth = 60; 
currentHealth = baseHealth;

class = classList.bloodMage; //NEED TO CHANGE LATER
//dmgRedStuff
dmgRedMelee = 0.3;
dmgRedRange = 0.35;
dmgRedMagic = 0.1;

//doge is used for all kindes of doge (dots, stuns)
doge = 0.2; // 0.2

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


// overhead attack 
// acc --> 0.55 high dmg high pen
// missing sequence to play
// targets --> 1
title = "Overhead swing";
describtion = "An overhead swing with low penetration and accuracy but devestating gamage if it hits"
attack1 = new createAttacks(1,0.55,(30 + 10 * lvl),dmgType.melee, 0.2,100,title, describtion); 

costBloodAttack1 = 10;
canTargetAttack1 = possibleTargets.enemies;
function attack1(list){
	accuracy = 0.55;
	dmg = 300 + 10 * lvl; // + any Gear (not yet)
	type = dmgType.ranged;
	pen = 0.1;
	currentBloodLvL -= 10;
	
	attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(list);i ++){
		ds_list_add(attackList, list[| i]);
		show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	for (var i = 0;	i < ds_list_size(attackList); i++) {
	    if(checkForHit(accuracy)){
			var target = attackList[|i];
			target.damageUnit(dmg, type, pen);
			show_debug_message("hit for: " + string(dmg));
		} else{
			show_debug_message("miss" );
		}
	}
	
	for (var i = 0;	i < ds_list_size(attackList); i++) {
	   with(attackList[|i]){
		   if(state == states.DEATH){
			   
		   }else{
			   mSequence.playBattleAnimations(actions.attack1, mCombat.selectedUnit, list);	
		   }
	   }
	}

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
}

// precision strike 
// acc --> 0.95 low dmg high pen 
// missing sequence to play
// targets --> 1
title = "precision strike";
describtion = "A precision strike with low penetration but high accuracy and medium damage"
attack2 = new createAttacks(1,0.95,(15 + 7.5 * lvl),dmgType.melee, 0.9,80, title, describtion); 


costBloodAttack2 = 55;
canTargetAttack2 = possibleTargets.enemies;
function attack2(list){
	accuracy = 0.95;
	dmg = 15 + 7.5 * lvl; // + any Gear (not yet)
	type = dmgType.melee;
	pen = 0.9;
	currentBloodLvL -= 55;
	
	attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(list);i ++){
		ds_list_add(attackList, list[| i]);
		show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	for (var i = 0;	i < ds_list_size(attackList); i++) {
	    if(checkForHit(accuracy)){
			var target = attackList[|i];
			target.damageUnit(dmg, type, pen);
			show_debug_message("hit for: " + string(dmg));
		} else{
			show_debug_message("miss" );
		}
	}

	state = states.ATTACK2;
	layer_sequence_headpos(unitSequence, attack2Start);

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
}

// aoe cleave attack all enemies 
// acc --> 0.70 mid dmg mid pen
// missing sequence to play
// targets --> 2
title = "broad cleave";
describtion = "A broad cleave that targets multiple enemies with low accuracy, medium penetration and medium damage"
attack3 = new createAttacks(2,0.7,(20 + 5 * lvl),dmgType.melee, 0.45, 70,title, describtion); 


costBloodAttack3 = 5;
canTargetAttack3 = possibleTargets.enemies;
function attack3(list){
	accuracy = 0.70;
	dmg = 20 + 5 * lvl; // + any Gear (not yet)
	type = dmgType.melee;
	pen = 0.45;
	currentBloodLvL -= 5;
	
	attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(list);i ++){
		ds_list_add(attackList, list[| i]);
		show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	for (var i = 0;	i < ds_list_size(attackList); i++) {
	    if(checkForHit(accuracy)){
			var target = attackList[|i];
			target.damageUnit(dmg, type, pen);
			show_debug_message("hit for: " + string(dmg));
		} else{
			show_debug_message("miss" );
		}
	}

	state = states.ATTACK2;
	layer_sequence_headpos(unitSequence, attack2Start);

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
}

function updateTargetNumbers(){
	numberTargetAttack1 = 1; 
	numberTargetAttack2 = 1; 
	switch(team){
		case 0:
			if(ds_list_size(mCombat.team1) < 2){
				numberTargetAttack3 = 1
			}else{
				numberTargetAttack3 = 2;
			}
		break;
		case 1:
			if(ds_list_size(mCombat.team0) < 2){
				numberTargetAttack3 = 1
			}else{
				numberTargetAttack3 = 2;
			}
		break;
	}
	
}