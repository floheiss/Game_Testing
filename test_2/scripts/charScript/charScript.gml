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

//now works on both Linux and windows
#endregion