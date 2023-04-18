#region findActiveBuffs and deBuffs on Target
//findes activ buffs for given target 
//used for displays mostly
function findActivBuffs(_target){
	activBuffs = 0;
	if(target.buffDmgRed != false){
		activBuffs ++;
	}
	if(target.buffDoge != false){
		activBuffs ++;
	}
	if(target.buffHealth != false){
		activBuffs ++;
	}
	if(target.buffBlood != false){
		activBuffs ++;
	}
	if(target.buffTempo != false){
		activBuffs ++;
	}
	return activBuffs;
}

//findes activ deBuffs for given target 
//used for displays mostly
function findActivDeBuffs(_target){
	activBuffs = 0;
	if(target.deBuffDmgRed!= false){
		activBuffs ++;
	}
	if(target.deBuffDoge != false){
		activBuffs ++;
	}
	if(target.deBuffHealth != false){
		activBuffs ++;
	}
	if(target.deBuffBlood != false){
		activBuffs ++;
	}
	if(target.deBuffTempo != false){
		activBuffs ++;
	}
	return activBuffs;
}

#endregion

//checks for hits returns a miss text if not
//might get reworked to account for acc Buffs
//can be given any value --> 0-1 OR 0-100
function checkAgainstRandom100(_valueToCheck, _rerolls = 0){
	value = _valueToCheck
	if(value <= 1){
		value = _valueToCheck * 10 // 0.8 *10 = 80%
	}
	
	
	number = chanceFrom100(_rerolls);
	
	if(number < value){
		return true;
	} else {
		show_debug_message("number was not hit");
		return false;
	}
}

#region note 
// new values for chars --> 
// --> reroll doge 
// --> reroll acc 
// --> reroll crit

//disgust --> clas based max can be improved 
//disgustMultiplayer --> some classes are not disguasted (battleharded)

// add buffs for (also debuffs)
// --> reroll doge / acc / crit
// --> acc / crit 
// --> dmg --> used in general dmg calulas 

// remove buffs for 
// --> health 
// --> blood


// new mechanich --> disguast 
// is used like stress --> dd 
// works a bit diffrent 

#endregion