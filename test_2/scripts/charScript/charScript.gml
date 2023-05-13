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

#region campfireSkills

function prepareEquipment(){
	//have to look at --> move mBuff and mDot into General
	//+ make 1 global.mBuff in game so you have instace 24/7 
	//same for inventory/ make persitent
	support = oCampfire.selecedSupport;
	buff = new mBuff.mBuffCreate(20,0.10,buffTypes.dmg,support.id,true);
	support.checkIfBuffBetterAndUse(buff);
	buff = new mBuff.mBuffCreate(20,0.08,buffTypes.dmgRed,support.id,true);
	support.checkIfBuffBetterAndUse(buff);
	
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