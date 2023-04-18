function Attack1Button(){
	mCombat.targeting = true;
	mCombat.selectedUnit.updateTargetNumbers();
	mCombat.actionTaken = actions.attack1;
	mCombat.attackTargets = mCombat.selectedUnit.canTargetAttack1;
	mCombat.maxNumberTargets = mCombat.selectedUnit.numberTargetAttack1;
	
	for(var i = 0; i < ds_list_size(mCombat.units); i ++){
		var _inst = mCombat.units[|i];
		if(_inst != mCombat.selectedUnit){
			ds_list_add(mCombat.targets, _inst);
		}
	}
	playUserEvent0120();
}

//rework to look like attack1 --> also rework in mCombat
function Attack2Button(){
	mCombat.targeting = true;
	mCombat.selectedUnit.updateTargetNumbers();
	mCombat.actionTaken = actions.attack2;
	mCombat.attackTargets = mCombat.selectedUnit.canTargetAttack2;
	mCombat.maxNumberTargets = mCombat.selectedUnit.numberTargetAttack2;
	
	for(var i = 0; i < ds_list_size(mCombat.units); i ++){
		var _inst = mCombat.units[|i];
		if(_inst != mCombat.selectedUnit){
			ds_list_add(mCombat.targets, _inst);
		}
	}
	playUserEvent0120();

}

function Attack3Button(){
	mCombat.targeting = true;
	mCombat.selectedUnit.updateTargetNumbers();
	mCombat.actionTaken = actions.attack3;
	mCombat.attackTargets = mCombat.selectedUnit.canTargetAttack3;
	mCombat.maxNumberTargets = mCombat.selectedUnit.numberTargetAttack3;
	
	for(var i = 0; i < ds_list_size(mCombat.units); i ++){
		var _inst = mCombat.units[|i];
		if(_inst != mCombat.selectedUnit){
			ds_list_add(mCombat.targets, _inst);
		}
	}
	playUserEvent0120();
}

function HoverAttack1(){
	oBattlePanel.hoverdAttack = actions.attack1;
}

function HoverAttack2(){
	oBattlePanel.hoverdAttack = actions.attack2;
}

function HoverAttack3(){
	oBattlePanel.hoverdAttack = actions.attack3;
}

function InventoryButton(){

}

function CancelButton(){
	mCombat.targeting = false;
	ds_list_clear(mCombat.targets);
	ds_list_clear(mCombat.selectedTargets);
	with(mCombat){
		event_user(1);
		if(layer_get_visible(targetUI)){
			event_user(2);
		}
	}
}

function newRun(){
	room_goto(rBattleScreen);
}





