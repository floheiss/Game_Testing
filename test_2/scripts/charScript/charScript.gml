#region skills (campfire and others) 

function prepareEquipment(){
	//have to look at --> move mBuff and mDot into General
	//+ make 1 global.mBuff in game so you have instace 24/7 
	//same for inventory/ make persitent
	//have to rename a lot of things :) 
	
	support = oMapCampfire.selecedSupport;
	buff = new buffDeBuff(20,0.10,buffTypes.dmg,support.id,true);
	support.checkIfBuffBetterAndUse(buff);
	buff = new buffDeBuff(20,0.08,buffTypes.dmgRed,support.id,true);
	support.checkIfBuffBetterAndUse(buff);
	
}

function reloadGun(){
	
}

#endregion

#region conditions

function checkReloded(){
	show_debug_message("thue check was called");
	var r = owner.reloaded;
	return r;
}

function checkMericals(_unit){
	if(_unit.mericalsLeft < 1){
		return true;
	}else{
		return false;
	}
}

function checkMericalsAND2Enemies(_unit){
	if(array_length(mCombat.team1) < 2){
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

function checkAimTaken(_unit){
	return !_unit.aimTaken;
}

function checkOnlyOneEnemy(_unit){
	return array_length(mCombat.team1) < 1? true: false;
}

#endregion

#region attackStrukt

//maybe _owner dosnt work --> self ref to scribt 
function attacksDesribtion(_owner ,_acc, _dmgBase, _dmgLvl, _dmgType, _pen, _critChance,  
_title, _describtion, _targetNumber, _pointValue,
_rerolls = 0, _canTarget = possibleTargets.enemies, _condition = false, _bloodCost = 0) constructor{
	
	acc = _acc;
	dmgTypeAttack = _dmgType;
	pen = _pen;
	critChance = _critChance;
	dmgBase = _dmgBase;
	dmgLvL= _dmgLvl;
	
	condition = _condition
	
	title = _title;
	describtion = _describtion;
	
	targetNumberBase = _targetNumber;
	targetNumber = targetNumberBase;
	canTarget = _canTarget;
	
	rerolls = _rerolls;
	bloodCost = _bloodCost;
	pointValue = _pointValue;
	owner = _owner;

	function calDmg(){
		//any gear is added here
		var dmgCal = round(dmgBase + dmgLvL * owner.lvl);
		return dmgCal;
	}
	
	function updateTargetNumbers(){
		if(canTarget == possibleTargets.enemies){
			switch(owner.team){
				case 0:
					if(array_length(mCombat.team1) < targetNumberBase){
						targetNumber = array_length(mCombat.team1) ;
					}
				break;
				case 1:
					if(array_length(mCombat.team0) < targetNumberBase){
						targetNumber = array_length(mCombat.team0) ;
					}
				break;
			}
		}
		if(canTarget == possibleTargets.allies){
			switch(owner.team){
				case 0:
					if(array_length(mCombat.team0) < targetNumberBase){
						targetNumber = array_length(mCombat.team0) ;
					}
				break;
				case 1:
					if(array_length(mCombat.team1) < targetNumberBase){
						targetNumber = array_length(mCombat.team1) ;
					}
				break;
			}
		}
	}

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