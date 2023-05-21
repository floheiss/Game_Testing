#region skill

function prepareEquipment(){
	//have to look at --> move mBuff and mDot into General
	//+ make 1 global.mBuff in game so you have instace 24/7 
	//same for inventory/ make persitent
	
	//have to rename a lot of things :) 
	support = oCampfire.selecedSupport;
	buff = new mBuff.mBuffCreate(20,0.10,buffTypes.dmg,support.id,true);
	support.checkIfBuffBetterAndUse(buff);
	buff = new mBuff.mBuffCreate(20,0.08,buffTypes.dmgRed,support.id,true);
	support.checkIfBuffBetterAndUse(buff);
	
}

#endregion

#region conditions

function checkReloded(_unit){
	if(_unit.relod){
		return true;
	}else{
		return false;
	}
}

function checkMericals(_unit){
	if(_unit.mericalsLeft < 1){
		return true;
	}else{
		return false;
	}
}

function checkMericalsAND2Enemies(_unit){
	if(ds_list_size(mCombat.team1) < 2){
		return false; 
	}else {
		return checkMericals(_unit);
	}
	
	
}

function checkDefensiveStance(_unit){
	if(_unit.defensiveStance){
		return false;
	}else{
		return true;
	}
}

#endregion

#region attackStrukt

//maybe _owner dosnt work --> self ref to scribt 
function attacksDesribtion( _acc, _dmgBase, _dmgLvl, _dmgType, _pen, _critChance,  
_title, _describtion, _targetNumber, _pointValue,
_rerolls = 0, _canTarget = possibleTargets.enemies, _condition = true, _bloodCost = 0, _owner = self) constructor{
	
	acc = _acc;
	dmgTypeAttack = _dmgType;
	pen = _pen;
	critChance = _critChance;
	
	condition = _condition
	locked = false;
	
	title = _title;
	describtion = _describtion;
	
	targetNumberBase = _targetNumber;
	targetNumber = targetNumberBase;
	canTarget = _canTarget;
	
	rerolls = _rerolls;
	bloodCost = _bloodCost;
	pointValue = _pointValue;
	owner = _owner
	
	function updateCondition(){
		
		if(is_bool(condition)){
			if(!condition){
				locked = true;
			}
		}else{
			if(!script_execute(condition, owner)){
				locked = true;
			}
		}
	}
	
	function calDmg(){
		//any gear is added here
		var dmgCal = round(_dmgBase + _dmgLvl * owner.lvl)
		return dmgCal;
	}
	
	function updateTargetNumbers(){
		if(canTarget == possibleTargets.enemies){
			switch(owner.team){
				case 0:
					if(ds_list_size(mCombat.team1) < targetNumberBase){
						targetNumber = ds_list_size(mCombat.team1) ;
					}
				break;
				case 1:
					if(ds_list_size(mCombat.team0) < targetNumberBase){
						targetNumber = ds_list_size(mCombat.team0) ;
					}
				break;
			}
		}
		if(canTarget == possibleTargets.allies){
			switch(owner.team){
				case 0:
					if(ds_list_size(mCombat.team0) < targetNumberBase){
						targetNumber = ds_list_size(mCombat.team0) ;
					}
				break;
				case 1:
					if(ds_list_size(mCombat.team1) < targetNumberBase){
						targetNumber = ds_list_size(mCombat.team1) ;
					}
				break;
			}
		}
	}
	
	updateCondition();
	dmg = calDmg();
}

#endregion


#region note 
// new values for chars --> 

//disgust --> clas based max can be improved 
//disgustMultiplayer --> some classes are not disguasted (battleharded)

// add buffs for (also debuffs)

// remove buffs for 

// new mechanich --> disguast 
// is used like stress --> dd 
// works a bit diffrent 


#endregion