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
	target = 50;
	
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

function triggerMapNote(){
	self.mapNoteFunction();
}

function triggerEvent(){
	//when an event is used the stage advances 
	//then the updateEvent (with the info what happend if needed)
	//the updateEvent then updates the BG and options based on this
	//repeat
	note = mMapDisplayManager.activeNote;
	if(self.savedObject.endEvent == true){
		mMapDisplayManager.debug = true;
		mMapDisplayManager.mapOptions = [];//reset options 
		mMapDisplayManager.activeNote = -1;//manager loss note that is used
		mMapDisplayManager.currentMenu = -1;//manager resetes Menu 
		mMapDisplayManager.currentEvent = -1;//restet event
		mMapDisplayManager.mapEventImage = -1;//reset bg	
		note.active = false; //note get deactive
		pMapItem.displayMapEvent();//closes the view
	}else{
		note.stage ++;
		note.updateEvent(self.savedObject.onClick);	
	}
	
}

function triggerCampfireSkill(){
	self.savedObject.onClick();
}

function changeSelecedSupportMapOption(){
	oMapCampfire.updateSelecedSupport(self);	
}