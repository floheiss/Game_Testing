//all the funtion used in the events of the map 
//example fallen goods option when any are pressed;


#region onClickEvents 

//used for fallenGodds stage 1
function openChestWithForce(){
	target = 30; 
	
	//add that better is some classes are in the party 
	//like jaguar warrior 
	target = min(target, 75);
	return checkAgainstRandom100(target);
}

//used for fallenGodds stage 1
function openChestWithLockpick(){
	target = 60;
	
	//add that better is some classes are in the party 
	//like any form of graverobber
	mInventory.removeFirstGivenItem(itemList.lockPickSet);
	
	return checkAgainstRandom100(target);
}

//like an accappt button 
//used to simple advance the stage
function returnTrue(){
	return true;
}

//is used the end the event with out chancing anything
function closeTheEvent(){
	pMapItem.displayMapEvent();
}

#endregion

#region conditions



function checkIfLockPickInInventory(){
	if(mInventory.findItemInInventory(itemList.lockPickSet) != false){
		return true;
	}else {
		return false;
	}
}

#endregion 