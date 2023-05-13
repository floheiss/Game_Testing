currentMenu = -1
menusUI = layer_get_id("menusUI");

mapEventImage = -1;
discribtionText = ""; // have to reset after every event !!!!
mapOptions = []; // have to reset after every event !!!!
currentEvent = -1; // have to reset after every event !!!!
activeNote = -1;

campfireDisplaySupport = [];

hoveredNote = -1; //for debugging
debug = false; //?????


function displayEvent(){
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
				#region notes 
				//any other event is handel here 
				//the event will set mapOptions --> 
					//in them is save what text the options will display 
					//what happens when clicked (saves a function in scribt)
					//when are options locked (condion if they are false --> lock option)
					//(maybe add a hover that gives more info)
				//all of this will be set when the map icon is clicked 
				//is the discribtionText --> gives text feedback ! 
				#endregion
			
			//context Image
			with(objects[|i + 1]){
				//note mapOptionSprite will have origen in der topcenter
			
				//bottom to menu + padding + mapOptionSprite(height) * (mapOptions ) + i
				xCord = 350 + 10 + sprite_get_height(mapOptionSprite) * (array_length(mapOptions) + 1);
				yCord = 360; 
				changeSprite(xCord, yCord,mapOptionSprite, false, 0);		
			}
			
					
			for(var k = 0; k < array_length(mapOptions); k ++){
				withWorked = false;
				with(objects[|k + 2]){
					other.withWorked = true;
				
					xCord = 640;
					yCord = 360 + 10 + sprite_get_height(mapOptionSprite) * (array_length(other.mapOptions) - k); 
				
					savedObject = other.mapOptions[k];
					//should work as there is (if i think correctly) to chance the locked state while in event
					//have to look at not sure if somethin diffrent is need when closing ???
					MainFunction = triggerEvent;
					
					if(savedObject.locked){ 
						changeSprite(xCord, yCord,mapOptionSprite, false, 0); 
						
					}else {
						useLockedOverlay(xCord, yCord, mapOptionSprite);
					}
					setUseHighlightHoverImage(mapOptionSprite, 1);
					setDisplayedText(savedObject.textForDisplay, 
					xCord - sprite_get_xoffset(mapOptionSprite) + 20,
					yCord - sprite_get_yoffset(mapOptionSprite) + (sprite_get_height(mapOptionSprite) / 2) - 10);
				}
				
				if(withWorked == false){
					show_debug_message("_________________");
					show_debug_message("with didnt work")
					show_debug_message("_________________");
					objectNow = objects[|k + 2]
					xCord = 640;
					yCord = 360 + 10 + sprite_get_height(mapOptionSprite) * (array_length(mapOptions) - k); 
				
					objectNow.savedObject = mapOptions[k];
					//should work as there is (if i think correctly) to chance the locked state while in event
					//have to look at not sure if somethin diffrent is need when closing ???
					objectNow.MainFunction = triggerEvent;
					
					if(objectNow.savedObject.locked){ 
						objectNow.changeSprite(xCord, yCord,mapOptionSprite, false, 0); 
						
					}else {
						objectNow.useLockedOverlay(xCord, yCord, mapOptionSprite);
					}
					objectNow.setUseHighlightHoverImage(mapOptionSprite, 1);
					objectNow.setDisplayedText(objectNow.savedObject.textForDisplay, 
					xCord - sprite_get_xoffset(mapOptionSprite) + 20,
					yCord - sprite_get_yoffset(mapOptionSprite) + (sprite_get_height(mapOptionSprite) / 2) - 10);
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

objects = findMapDisplayItem();
