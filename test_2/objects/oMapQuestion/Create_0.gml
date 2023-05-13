event_inherited();
stage = 0;
event = events.fallenGood; //rework to save the event it self in the question not if good or bad
//should be easy but later 

//is used when the note is clicked on the Map
function mapNoteFunction(){
	mapEventImage = 0;
	mapOptionsArray = [];
	displayText = "";
	
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
			displayText = "your party comes across a chest, that seams to have fallen of a wagon";
			mapEventImage = mapEventFallenGoods; //have to make main Image
			//leave the chest alone 
			mapOptionsArray[0] = new mapOption("Leave the chest by the wayside",
			closeTheEvent, true, true);		
			//use force to open chest 
			mapOptionsArray[1] = new mapOption("Use your strong arms OwO >~<",
			openChestWithForce, true);		
			//use a lockpick to open chest
			mapOptionsArray[2] = new mapOption("Use a Lockpick to open", 
			openChestWithLockpick,checkIfLockPickInInventory);
			
		break;
		
		#endregion
		
		#region infection Working on
			
		#endregion
	}
	mMapDisplayManager.activeNote = self;
	mMapDisplayManager.currentMenu = menus.mapEvent;
	mMapDisplayManager.currentEvent = events.fallenGood;
	mMapDisplayManager.mapEventImage = mapEventImage;
	mMapDisplayManager.discribtionText = displayText;
	
	for(i = 0; i < array_length(mapOptionsArray); i ++){
		mMapDisplayManager.mapEventOptions[i] = mapOptionsArray[i];
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
					closeTheEvent,true, true);
					show_debug_message("--------------> fail");
					mMapDisplayManager.mapEventOptions = [];
					for(i = 0; i < array_length(mapOptionsArray); i ++){
						mMapDisplayManager.mapEventOptions[i] = mapOptionsArray[i];
					}
					#endregion
				}
			}
			
		break;
		
		#endregion	
		
	}
	mMapDisplayManager.displayEvent();
}

function mapOption(_text, _onClick, _condition, _endEvent = false) constructor{
	textForDisplay = _text;
	onClick = _onClick
	condition = _condition;
	locked = true; 
	endEvent = _endEvent;
	
	function updateCondition(){
		
		if(is_bool(condition)){
			if(!condition){
				locked = false;
			}
		}else{
			if(!script_execute(condition)){
				locked = false;
			}
		}
	}
	
	updateCondition();
	
}

