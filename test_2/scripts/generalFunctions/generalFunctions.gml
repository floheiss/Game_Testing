//sorts a given list 
// might rework later --> for diffrent sort function
 function bubble_sort(_list){
    var list_size = array_length(_list);
    for (var i = 0; i < list_size; i++) {
        for (var j = 0; j < list_size - i - 1; j++) {
            if (_list[j].tempo < _list[j+1].tempo) {
                var swapped = _list[j];
                _list[j] = _list[j+1];
                _list[j+1] = swapped;
            }
        }
    }
}

#region mCombat move later

//removes units in the selection phase of the combat
function checkIfUnitAlreadySelectedAndDelete(unit){
	if(ds_list_find_index(mCombat.selectedTargets, unit)  != -1 ){
			ds_list_delete(mCombat.selectedTargets, ds_list_find_index(mCombat.selectedTargets, unit));
		}

}

#endregion

//NEW FORM LINUX
//returns a value form 0 - 99 used for chances 
//can be given rerolls --> + OR - 
	//- makes worse  rolls 
	//+ makes better rolls 
//--> rework systems to use this 
function chanceFrom100(_rerolls = 0){
	randomize();
	var number = round(random_range(0,99));
	//rerolls
	//note should (????) be usefull anywhere as small amouts are always better
	if(_rerolls != 0){
		if(_rerolls < 0){
			for(var i = 0; i < (_rerolls * -1); i++){
				number = max(number, random_range(0,99));
			}
		}
		if(_rerolls > 0){
			for(i = 0; i < _rerolls; i++){
				number = min(number, random_range(0,99));
			}
		}
	}
	return number;
}

//checks for any given value returns a true if value was hit
//can be given any value --> 0-1 OR 0-100
function checkAgainstRandom100(_valueToCheck, _rerolls = 0){
	var value = _valueToCheck;
	if(value <= 1){
		value = value * 100;
	}
	
	var number = chanceFrom100(_rerolls);
	
	if(number < value){
		return true;
	} else {
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
	var number = chanceFrom100(_rerolls);
	var procentChances = [];
	

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

//returns a random item in an given array 
function findRandomItemInArray(_arrayToFindIn){
	//have to check math :) 
	if(!is_array(_arrayToFindIn)){
		var listWork = _arrayToFindIn;
		for(var i = 0; i < array_length(listWork); i ++){
			_arrayToFindIn[i] = listWork[i];
		}
	}
	var lengthResult = array_length(_arrayToFindIn);
	var resultNumer = chanceFrom100(); 
	var amountPerPosition = round(100/lengthResult);
	var position =  floor(resultNumer /amountPerPosition);
	
	#region special cases (so far only 1 error found)
		if(resultNumer == 99 && amountPerPosition == 33 && position == 3){
			position = 2; 
		}
	#endregion
	
	return _arrayToFindIn[position];
}

#endregion


#region autoLineBreaker

function autoLineBreaker(_string,_maxLength,_maxWordLength){
	var insert = 0;
	var go = 0;
	var prev = 0;
	var text = argument0;
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