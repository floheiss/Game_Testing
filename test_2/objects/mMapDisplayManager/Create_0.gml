currentMenu = -1
menusUI = layer_get_id("menusUI");

mapEventImage = -1;
discribtionText = ""; // have to reset after every event !!!!
mapEventOptions = []; // have to reset after every event !!!!
currentEvent = -1; // have to reset after every event !!!!
currentStageOfEvent = 1; // have to reset after every event !!!!

function displayMenu(){
	objects = findDisplayObjects();

	for(i = 0; i < ds_list_size(objects); i ++){
		//resets all the objects so there is no leagcy for other menus
		objects[|i].resetButton();	
		objects[|i].savedObject = -1;
	}
	
	//maybe add a general buttion to hide the event and see the map again ???	
	//draw as 1st element (problem with object list)!!
	
	switch(currentMenu){
		case menus.inventory:
			#region inventory
			
			inventory = global.inventory;
			mapEventImage = Menu_Background_Inventory; //mapInventoryBG; have to make 
			
			for(i = 0; i < 30; i ++){
				
				#region calculate x/y
				xCord = 0;
				yCord = 0;
				
				if(i < 10){
					xCord = x + 25 + 4 * i + 85*i;
					yCord = y + 35;
				}else if(i < 20){
					xCord = x + 25 + 10 * (i-10) + 85 * (i-10) ;
					yCord = y + 35 + 25 + 85;
				}else{
					xCord = x + 25 + 10* (i-20) + 85 * (i-20) ;
					yCord = y + 35 + 25 * 2 + 85 * 2;
				}
				
				#endregion
				
				if(i < global.maxInventorySize){
					item = global.inventory[i];
					with(objects[|i + 1]){
						show_debug_message("the item will be: " + string(other.item));
						index = other.item != -1 ?  other.item.displaySpriteSubImage : 0;
						changeSprite(other.xCord,other.yCord,ItemSprite, false, index);
					}
				}else{
					with(objects[|i]){
						//not sure about cal :) 
						useLockedOverlay(other.xCord,other.yCord,ItemSprite);
					}
				}
				
			}
			
		#endregion
	
		break;
		
		case menus.campfire:
			#region campfire
		
			mapEventImage = Menu_Background_Campfire; //have to make
		
			//have to look at player ground --> set all of them around the campfire 
			//have to make one default seleced --> have to save in var 
			// have to make the others selecable 
			//have to make a menu to use there skills
		
			//one of the harded ones : ) 
			//will make at the end
		
			#endregion
	
		break;
		
		case menus.mapEvent:
			#region mapEvent
			//any other event is handel here 
			//the event will set mapEventOptions --> 
				//in them is save what text the options will display 
				//what happens when clicked (saves a function in scribt)
				//when are options locked (condion if they are false --> lock option)
				//(maybe add a hover that gives more info)
			//all of this will be set when the map icon is clicked 
			//is the discribtionText --> gives text feedback ! 
			
			with(objects[|i + 1]){
				//note mapOptionSprite will have origen in der topcenter
			
				//bottom to menu + padding + mapOptionSprite(height) * (mapEventOptions ) + i
				xCord = 350 + 10 + sprite_get_height(mapOptionSprite) * (array_length(mapEventOptions) + 1);
				yCord = 360; 
				displayedText = discribtionText;
				changeSprite(xCord, yCord,mapOptionSprite, false, 0);		
			}
			for(i = 0; i < array_length(mapEventOptions); i ++){
				with(objects[|i + 2]){
					xCord = 350 + 10 + sprite_get_height(mapOptionSprite) * (array_length(mapEventOptions) - i );
					yCord = 360; 
					savedObject = mapEventOptions[other.i];
					//should work as there is (if i think correctly) to chance the locked state while in event
					//have to look at not sure if somethin diffrent is need when closing ???
					MainFunction = function triggerEvent(){
						//when an event is used the stage advances 
						//then the updateEvent (with the info what happend if needed)
						//the updateEvent then updates the BG and options based on this
						//repeat
						oMapQuestion.stage ++;
						oMapQuestion.updateEvent(savedObject.onClick);
					}
					
					displayedText = savedObject.textForDisplay;
					if(!savedObject.locked){ 
						changeSprite(xCord, yCord,mapOptionSprite, false, 0); //have to make mapOptionSprite
					}else {
						useLockedOverlay(xCord, yCord,mapOptionSprite);
					}
				
				}
			}
			#endregion

		break;
	}
	
	
}


function findMapDisplayItem(){
	list = ds_list_create();
	for(i = 0; i < instance_number(oMapDisplayItem);i ++){
		instance = instance_find(oMapDisplayItem, i);
		ds_list_add(list, instance);
	}
	return list;

}