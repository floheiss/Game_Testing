event_inherited();
stage = 0;
event = events.fallenGood; //rework to save the event it self in the question not if good or bad
//should be easy but later 

//is used when the note is clicked on the Map
function mapNoteFunction(){
	//this saves the chance for later (after battle or if leaving 
	updateMapList();
	//this is for now not sure about 
	locked = true;
	
	var mapEventImage = 0;
	var mapOptionsArray = [];
	var displayText = "";
		
	//this is what will be left after reworking to save only event in questionmark
	switch(event){
		#region fallenGoods
	
		case events.fallenGood:
			displayText = "your party comes across a chest, that seams to have fallen of a wagon";
			mapEventImage = mapEventFallenGoods; 
			//leave the chest alone 
			mapOptionsArray[0] = new mapOption("Leave the chest by the wayside",
			closeTheEvent, false, true);		
			//use force to open chest 
			mapOptionsArray[1] = new mapOption("Use your strong arms OwO >~<",
			openChestWithForce, false);		
			//use a lockpick to open chest
			mapOptionsArray[2] = new mapOption("Use a Lockpick to open", 
			openChestWithLockpick, checkIventroyForLockPick);
			
		break;
		
		#endregion
		
		#region infection WIP
			
		#endregion
	}
	mMapDisplayManager.activeNote = self;
	mMapDisplayManager.currentMenu = menus.mapEvent;
	mMapDisplayManager.currentEvent = events.fallenGood;
	mMapDisplayManager.mapEventImage = mapEventImage;
	mMapDisplayManager.discribtionText = displayText;
	
	for(var i= 0; i < array_length(mapOptionsArray); i ++){
		mMapDisplayManager.mapOptions[i] = mapOptionsArray[i];
	}
	
	mMapDisplayManager.displayEvent();
	
	//is used to activate the menu display
	displayMapEvent();
}

function updateEvent(_result){
	
	switch(mMapDisplayManager.currentEvent){
		#region fallen goods
		
		case events.fallenGood: 
			if(stage == 1){
				if(_result == 5){
					//chance later
					#region succsses 
					//generates loot from the chest
					//will give same loot for any methode
					//have to look at how to handle loot here
					mMapDisplayManager.currentMenu = menus.lootDisplay;
					show_debug_message("--------------> succ");
					
					#endregion
				}else {
					#region failed
					mapOptionsArray = [];
					
					mapOptionsArray[0] = new mapOption("the chest was unfaced by your action",
					closeTheEvent, true, true);
					show_debug_message("--------------> fail");
					mMapDisplayManager.mapOptions = [];
					for(i = 0; i < array_length(mapOptionsArray); i ++){
						mMapDisplayManager.mapOptions[i] = mapOptionsArray[i];
					}
					#endregion
				}
			}
			
		break;
		
		#endregion	
		
	}
	mMapDisplayManager.displayEvent();
}


