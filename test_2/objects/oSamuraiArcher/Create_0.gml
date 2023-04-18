event_inherited();

unitSequence = layer_sequence_create("Squences", x, y, sSamuraiArcher);
maxActionsInTurn = 1;

baseTempo = 210 + irandom_range(1,10);
bonusTempo = 0;
currentTempo = baseTempo + bonusTempo;

//healthstuffs
baseHealth = 1;//45
bonusHealth = 0;
maxHealth = baseHealth + bonusHealth;
currentHealth = maxHealth;

//bloodStuffs
bloodMeter = 0;
bloodMeterBonus = 0;
maxBlood = bloodMeter + bloodMeterBonus;
currentBloodLvL = maxBlood;

//dmgRedStuff
dmgRedMelee = 0.2;
dmgRedRange = 0.4;
dmgRedMagic = 0.05;

doge = 0.35;
bonusDoge = 0;
currentdoge = doge + bonusDoge;

//spriteStuff
idleStart = 0;
idleEnd = 17;

attack1Start = 18;
attack1End = 46;

attack2Start = 46;
attack2End = 56;

attack3Start = 56;
attack3End = 68;

hurtStart = 69;
hurtEnd = 78;

deathStart = 78;
deathEnd = 88;


// fires Arrow at any target 
// acc -> 95 mid dmg low pen 
// missing sequence to play
// targets --> 1 
canTargetAttack1 = possibleTargets.enemies;
function attack1(list){
	//mSequence.playBattleAnimations(actions.attack1, selectedUnit, list);	
	currentBloodLvL -= 25;
	accuracy = 0.95; //0.95
	dmg = 15 + 5 * lvl; // + any Gear (not yet) 
	type = dmgType.ranged; 
	pen = 0.2; 
	
	attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(list);i ++){
		ds_list_add(attackList, list[| i]);
		show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	if(checkForHit(accuracy)){
		var target = attackList[|0];
		target.damageUnit(dmg, type, pen);
		show_debug_message("hit for: " + string(dmg));
	} else {
		show_debug_message("miss");
	}
	
	for (var i = 0;	i < ds_list_size(attackList); i++) {
	   with(attackList[|i]){
		   if(state == states.DEATH){
			   
		   } else {
			   mSequence.playBattleAnimations(actions.attack1, mCombat.selectedUnit, list);	
		   }
	   }
	}
	
	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
}

// arrow rain on all enemeys 
// acc --> 75 low-mid dmg vlow pen 
// missing sequence to play
// targets --> enemy team  
canTargetAttack2 = possibleTargets.enemies;
function attack2(list){
	mSequence.playBattleAnimations(actions.attack1, selectedUnit, list);	
	accuracy = 0.75;
	dmg = 7 + 3 * lvl; // + any Gear (not yet)
	type = dmgType.ranged;
	pen = 0.1;
	
	attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(list);i ++){
		ds_list_add(attackList, list[| i]);
		show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	for (var i = 0;	i < ds_list_size(attackList); i++) {
	    if(checkForHit(accuracy)){
			var target = attackList[|i];
			dmg = 7 + 3 * lvl; // + any Gear (not yet)
			target.damageUnit(dmg, type, pen);
			show_debug_message("hit for: " + string(dmg));
		} else{
			show_debug_message("miss" );
		}
	}

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
}

// melee attack a front line enemy 
// acc --> 65 mid dmg mid pen
// missing sequence to play
// targets --> 1 
canTargetAttack3 = possibleTargets.enemies;
function attack3(list){
	mSequence.playBattleAnimations(actions.attack3, selectedUnit, list);	
	accuracy = 0.65;
	dmg = 10 + 5 * lvl; // + any Gear (not yet)
	type = dmgType.melee;
	pen = 0.4;
	
	attackList = ds_list_create();
	for(var i = 0; i <  ds_list_size(list);i ++){
		ds_list_add(attackList, list[| i]);
		show_debug_message("i attacked: " + string(attackList[|i]));
	}
	
	if(checkForHit(accuracy)){
		var target = attackList[|0];
		dmg = 10 + 5 * lvl; // + any Gear (not yet)
		target.damageUnit(dmg, type,pen);
		show_debug_message("hit for: " + string(dmg));
	} else {
		show_debug_message("miss");
	}

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
}

function updateTargetNumbers(){
	numberTargetAttack1 = 1; 
	numberTargetAttack3 = 1; 
	switch(team){
		case 0:
			numberTargetAttack2 = ds_list_size(mCombat.team1); 
		break;
		case 1: 
			numberTargetAttack2 = ds_list_size(mCombat.team0); 
		break;
	}
}