event_inherited();

#region Var Stuff

unitSequence = layer_sequence_create("Squences", x, y, sSamuraiCommander);

baseTempo = 250;

currentTempo = baseTempo + bonusTempo;

//healthstuffs
maxHealth = 200;//55
maxHealth = maxHealth + bonusHealth;
currentHealth = maxHealth;

//dmgRedStuff
dmgRedMelee = 0.34;
dmgRedRange = 0.33;
dmgRedMagic = 0.2;

doge = 0.15;

#region spriteStuff
//spriteStuff
idleStart = 0;
idleEnd = 9;

attack1Start = 10;
attack1End = 21;

attack2Start = 22;
attack2End = 31;

attack3Start = 32;
attack3End = 41;

hurtStart = 42;
hurtEnd = 51;

deathStart = 52;
deathEnd = 63;

protectStart = 64;
protectEnd =73;

#endregion

#endregion
//same as samurai at moment

// overhead attack 
// acc --> 0.55 high dmg high pen
// targets --> 1
canTargetAttack1 = possibleTargets.enemies;
function attack1(list){
	accuracy = 1.55;
	dmg = 300 + 10 * lvl; // + any Gear (not yet)
	type = dmgType.melee;
	pen = 0.1;
	
	attackList = [];
	for(var i = 0; i <  array_length(list);i ++){
		ds_list_add(attackList, list[ i]);
		show_debug_message("i attacked: " + string(attackList[i]));
	}
	
	for (var i = 0;	i < array_length(attackList); i++) {
	    if(checkForHit(accuracy)){
			var target = attackList[i];
			target.damageUnit(dmg, type, pen);
			show_debug_message("hit for: " + string(dmg));
		} else{
			show_debug_message("miss" );
		}
	}
	
	for (var i = 0;	i < array_length(attackList); i++) {
	   with(attackList[i]){
		   mSequence.playBattleAnimations(actions.attack1, mCombat.selectedUnit, list);	
	   }
	}

	ds_list_destroy(attackList);
	prozessFinished = true;
	turnFinished = true; 
	actionsInTurn ++;
}

// precision strike 
// acc --> 0.95 low dmg high pen 
// targets --> 1
canTargetAttack2 = possibleTargets.enemies;
function attack2(list){
	accuracy = 0.95;
	dmg = 10 + 5 * lvl; // + any Gear (not yet)
	type = dmgType.melee;
	pen = 0.9;
	
	attackList = [];
	for(var i = 0; i <  array_length(list);i ++){
		ds_list_add(attackList, list[ i]);
		show_debug_message("i attacked: " + string(attackList[i]));
	}
	
	for (var i = 0;	i < array_length(attackList); i++) {
	    if(checkForHit(accuracy)){
			var target = attackList[i];
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

// aoe Buff for team and self heal + 0.2 bonus dmgRed(m,r,m) lastes for 3 turns
// acc --> 0.7
// targets --> 2
canTargetAttack3 = possibleTargets.allies;
function attack3(list){
	accuracy = 1;
	healAmount = 10 + 5* lvl; //+ any Gear (not yet)
	
	attackList = [];
	for(var i = 0; i <  array_length(list);i ++){
		ds_list_add(attackList, list[ i]);
		show_debug_message("i will heal: " + string(attackList[i]));
	}
	
	
	//self 
	if(checkForHit(accuracy)){
		healUnit(healAmount);
		buff = new mBuff.mBuffCreate(3,0.2,buffTypes.dmgRed,id,true);	
		checkIfBuffBetterAndUse(buff);
		
		show_debug_message("i healed myself  for: " + string(healAmount));
	} else{
		show_debug_message("miss myself :(");
	}
	
	//allies
	for (var i = 0;	i < array_length(attackList); i++) {	
		var target = attackList[i];
		target.healAmount = healAmount;
		
	   
	   if(checkForHit(accuracy)){
			
			with(target){
				buff = new mBuff.mBuffCreate(3,0.2,buffTypes.dmgRed,target,true);	
				checkIfBuffBetterAndUse(buff);
				
				healUnit(healAmount);
			}
			show_debug_message(string(target) + "i healed for: " + string(healAmount));
		} else{
			show_debug_message("miss");
		}
		target.healAmount = 0;
	}
	
	
	
	state = states.PROTECT;
	layer_sequence_headpos(unitSequence, protectStart);

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
			numberTargetAttack3 = array_length(mCombat.team0) - 1;
		break;
		case 1:
			numberTargetAttack3 = array_length(mCombat.team1) - 1;
		break;
	}
}