event_inherited();

event =  events.good; //rework to save the event it self in the question not if good or bad
//should be easy but later 

//is used when the note is clicked on the Map
function useMapNote(){
	mapEventImage = 0;
	mapOptionsArray = [];
	
	//generate the event 
		//set the menu in the mDisplayManager
		//will set mapEventImage as the background
		//will set currentEvent to this event
		//will set the option for mapEventOptions
			//will give them a function what will happen if clicked 
				//returns any information need to proceed (true, [flase, "force"])
				//uses this in the next stage of the event to make decicions
				//all funtions will be found in the mapDisplayItem
			//will give them text to display 
			//will give them a condition if false they will lock 
				//condition must allways return true or false
	//more notes/same notes in the mMapDisplayManager
	
	//this is what will be left after reworking to save only event in questionmark
	switch(event){
		#region fallenGoods
	
		case events.fallenGood:
			discribtionText = "your party comes across a chest, that seams to have fallen of a wagon";
			mapEventImage = mapEventFallenGoods;//have to make main Image
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
	mMapDisplayManager.currentEvent = events.fallenGood;
	mMapDisplayManager.currentStageOfEvent = 0;
	mMapDisplayManager.mapEventImage = mapEventImage;
	mMapDisplayManager.discribtionText = discribtionText;
	for(i = 0; i < array_length(mapOptionsArray); i ++){
		mMapDisplayManager.mapEventOptions[i] = mapOptionsArray[i];
	}
	
	
	//is used to activate the menu display 
	displayMapEvent();
}

function updateEvent(_result){
	
	switch(mMapDisplayManager.currentEvent){
		case events.fallenGood: 
			if(stage == 1){
				if(_result){
					#region succsses 
					//generates loot from the chest
					//will give same loot for any methode
					//have to look at how to handle loot here
					mMapDisplayManager.currentMenu = menus.lootDisplay;
					#endregion
				}else {
					#region failed
					mapOptionsArray = [];
					mapOptionsArray[0] = mapOption("the chest was unfaced by your action",
					closeTheEvent,true);
					for(i = 0; i < array_length(mapOptionsArray); i ++){
						mMapDisplayManager.mapEventOptions[i] = mapOptionsArray[i];
					}
					#endregion
				}
			}
			
		break;
	}
}

function mapOption(_text, _onClick, _condition) constructor{
	textForDisplay = _text;
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