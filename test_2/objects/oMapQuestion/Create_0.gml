event_inherited();

event =  events.good; //rework to save the event it self in the question not if good or bad
//should be easy but later 

//is used when the note is clicked on the Map
function useMapNote(){
	//generate the event 
		//set the menu in the mDisplayManager
		//will set the mapEventImage as the background
		//sets the option for mapEventOptions
		//will give them a function what will happen if clicked
		//all funtions will be found in the mapDisplayItem
		//will give them text to display 
		//will give them a condition if false they will lock 
			//condition must allways return true or false
	//more notes/same notes in the mMapDisplayManager
	
	//this is what will be left after reworking to save only event in questionmark
	backgroundImage = 0;
	mapOptionsArray = [];
	switch(event){
		#region fallenGoods
		
		case events.fallenGood:
			//use a lockpick to open chest
			mapOptionsArray[0] = mapOption("Use a Lockpick to open", 
			openChestWithLockpick,checkIfLockPickInInventory);
			//use force to open chest 
			mapOptionsArray[1] = mapOption("Use your strong arms",
			openChestWithForce, true);
			//leave the chest alone 
			mapOptionsArray[2] = mapOption("Leave the chest by the wayside",
			closeTheEvent, true);		
		break;
		
		#endregion
		
		#region infection Working on
		
		#endregion
	}
	
	mMapDisplayManager.mapEventImage = backgroundImage;
	for(i = 0; i < array_length(mapOptionsArray); i ++){
		mMapDisplayManager.mapEventOptions[i] = mapOptionsArray[i];
	}
	
	
	//is used to activate the menu display 
	displayMapEvent();
}

function mapOption(_text, _onClick, _condition) constructor{
	text = _text;
	onClick = _onClick
	condition = _condition;
	locked = false; 
	
	function updateCondition(){
		if(condition){
			locked = true;
		}
	}
	updateCondition();
}