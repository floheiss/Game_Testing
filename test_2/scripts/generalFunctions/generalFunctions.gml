//sorts a given list 
// might rework later --> for diffrent sort function
 function bubble_sort(list){
    list_size = ds_list_size(list);
    for (var i = 0; i < list_size; i++) {
        for (var j = 0; j < list_size - i - 1; j++) {
            if (list[|j].currentTempo < list[|j+1].currentTempo) {
                var swapped = list[|j];
                list[|j] = list[|j+1];
                list[|j+1] = swapped;
            }
        }
    }
}



#region mCombat move later

//plays userevents in mCombat --> need to delete later 
function playUserEvent0120(){
	with(mCombat){
		event_user(0);
		event_user(1);
		event_user(2);
		event_user(0);
	}
}

function unitAttackUnit(attacker, target, attack){
	switch(attack){
		case actions.attack1: 
			with(attacker){
				attacker.attack1(target);
				ds_list_clear(mCombat.selectedTargets);
			}
		break;
		case actions.attack2: 
			with(attacker){
				attacker.attack2(target);
				ds_list_clear(mCombat.selectedTargets);
			}
		break;
		case actions.attack3: 
			with(attacker){
				attacker.attack3(target);
				ds_list_clear(mCombat.selectedTargets);
			}		
	}
}


//removes units in the selection phase of the combat
function checkIfUnitAlreadySelectedAndDelete(unit){
	if(ds_list_find_index(mCombat.selectedTargets, unit)  != -1 ){
			ds_list_delete(mCombat.selectedTargets, ds_list_find_index(mCombat.selectedTargets, unit));
		}

}


//finds the position in the display for given array 
//is used for teams in mCombat
function findPosition(sizeOfTeam, team){
	var positionsX = [];
	var positionsY = [];
	
	if(team == 0){
		switch(sizeOfTeam){
			case 1: 
				positionsX[0] = 224; 
				positionsY[0] = 224;
			break;
			case 2: 
				positionsX[0] = 224; 
				positionsY[0] = 96;
				positionsX[1] = 224; 
				positionsY[1] = 320;
			break;
			case 3: 
				positionsX[0] = 128; 
				positionsY[0] = 224;
				positionsX[1] = 352; 
				positionsY[1] = 96;
				positionsX[2] = 352; 
				positionsY[2] = 320;
			break;
			case 4: 
				positionsX[0] = 96; 
				positionsY[0] = 96;
				positionsX[1] = 352; 
				positionsY[1] = 96;
				positionsX[2] = 96;
				positionsY[2] = 320;
				positionsX[3] = 352;
				positionsY[3] = 320;
			break;
		}
	}else if(team == 1){
		switch(sizeOfTeam){
			case 1: 
				positionsX[0] = 928; 
				positionsY[0] = 224;
			break;
			case 2: 
				positionsX[0] = 928; 
				positionsY[0] = 96;
				positionsX[1] = 928; 
				positionsY[1] = 320;
			break;
			case 3: 
				positionsX[0] = 1024; 
				positionsY[0] = 224;
				positionsX[1] = 800; 
				positionsY[1] = 96;
				positionsX[2] = 800; 
				positionsY[2] = 320;
			break;
			case 4: 
				positionsX[0] = 1024; 
				positionsY[0] = 96;
				positionsX[1] = 800; 
				positionsY[1] = 96;
				positionsX[2] = 800;
				positionsY[2] = 320;
				positionsX[3] = 1024;
				positionsY[3] = 320;
			break;
			case 5: 
				positionsX[0] = 1024; 
				positionsY[0] = 32;
				positionsX[1] = 800; 
				positionsY[1] = 96;
				positionsX[2] = 800;
				positionsY[2] = 320;
				positionsX[3] = 1024;
				positionsY[3] = 192;
				positionsX[4] = 1024;
				positionsY[4] = 352;
			break;
		}
		
	}
	var positonXY = [positionsX, positionsY];
	return positonXY;
}

#endregion

//NEW FORM LINUX
//returns a value form 0 - 99 used for chances 
//can be given rerolls --> + OR - 
	//- makes worse  rolls 
	//+ makes better rolls 
//--> rework systems to use this 
function chanceFrom100(_rerolls){
	randomize();
	number = round(random_range(0,99));
	//rerolls
	//note should (????) be usefull anywhere as small amouts are always better
	if(_rerolls != 0){
		if(_rerolls < 0){
			for(i = 0; i < abs(_rerolls); i++){
				number = max(number, random_range(0,99));
			}
		}
		if(_rerolls > 0){
			for(i = 0; i < abs(_rerolls); i++){
				number = min(number, random_range(0,99));
			}
		}
	}
	return number;
}

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

#region tierList System


//is used to generate random items/things form 1-4 tiers
//is given an array that reflects the chances of tier pics (undefined --> random form tier1)
//ie [10,10,30] -->(tier 4 has 10% | tier 3 has 10% | tier 2 30% | tier 1 50% / the rest)
//ie [-1,30,60] -->(tier 4 has 0%  | tier 3 has 30% | tier 2 60% | tier 1 10% / the rest)
// --> note the chances should not be same --> tier 4 10% and tier 3 10% --> only 4 gets selected
//is given an array for all tiers that shots the results, only needes tiers used in  chances
function generateFormTierList(_tierChances = [-1,-1,-1], _resultsTier4 = [],
_resultsTier3 = [],
_resultsTier2 = [],
_resultsTier1,
_rerolls = 0){
	number = chanceFrom100(_rerolls);
	procentChances = [];
	

	#region change chances to fit better 
	
	if(_tierChances[0] == -1){
		procentChances[0] = -1;
	}else{
		procentChances[0] = _tierChances[0];		
	}
	
	if(_tierChances[1] == -1){
		procentChances[1] = -1;
	}else{
		if(procentChances[0] != -1){
			procentChances[1] = procentChances[0] + _tierChances[1]; 
		}else {
			procentChances[1] = _tierChances[1];
		}
	}

	if(_tierChances[2] == -1){
		procentChances[2] = -1;
	}else{
		if(procentChances[1] != -1){
			procentChances[2] = procentChances[1] + _tierChances[2]; 
		}else {
			procentChances[2] = _tierChances[2];
		}
	}
	#endregion
	
	if(procentChances[0] != -1 and number < procentChances[0]){
		return findRandomItemInArray(_resultsTier4);
		
	}else if(procentChances[1] != -1 and number < procentChances[1]){
		return findRandomItemInArray(_resultsTier3);
		
	}else if(procentChances[2] != -1 and number < procentChances[2]){
		return findRandomItemInArray(_resultsTier2);
		
	}else{
		return findRandomItemInArray(_resultsTier1);
	}
}

//NEW FORM LINUX
//returns a random item in an given array 
function findRandomItemInArray(_arrayToFindIn){
	//have to check math :) 
	lengthResult = array_length(_arrayToFindIn);
	resultNumer = chanceFrom100(); 
	amountPerPosition = round(100/lengthResult);
	position =  floor(resultNumer /amountPerPosition);
	if(resultNumer == 99 && amountPerPosition == 33 && position == 3){
		position = 2; //fixes a very special case : ) 
	}
	return _arrayToFindIn[position];
}

#endregion


#region autoLineBreaker

function autoLineBreaker(_string,_maxLength,_maxWordLength){
	insert = 0;
	go = 0;
	prev = 0;
	text = argument0;
	repeat(string_length(text)) {
	    if insert > argument1 {
	        while(1) {
	            text2 = string_char_at(text,go-prev)
	            if text2 != " " {
	                prev += 1
	            }
	            else {
	                break;
	            }
	            if prev > argument2 {
	                prev = 0
	                break;
	            }
	        }
	        text = string_insert("#",text,go-prev)
	        insert = 0
	    }
	    insert += 1
	    go += 1
	    if string_char_at(text,go) = "#" {
	       insert = 0
	    }
	}
 

    return text;


}

#endregion