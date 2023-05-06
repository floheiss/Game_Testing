//all the funtion used in the events of the map 
//example fallen goods option when any are pressed;


#region onClickEvents 

function openChestWithForce(){
	target = 30; 
	
	//add that better is some classes are in the party 
	//like jaguar warrior 
	target = min(target, 75);
	return checkAgainstRandom100(target);
}

function openChestWithLockpick(){
	target = 60;
	
	//add that better is some classes are in the party 
	//like any form of graverobber
	mInventory.removeFirstGivenItem(itemList.lockPickSet);
	
	return checkAgainstRandom100(target);
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