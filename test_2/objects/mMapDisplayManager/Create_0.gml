currentMenu = -1
menusUI = layer_get_id("menusUI");

mapEventImage = -1;
discribtionText = ""; // have to reset after every event !!!!
mapOptions = []; // have to reset after every event !!!!
currentEvent = -1; // have to reset after every event !!!!
activeNote = -1;

campfireDisplaySupport = [];//is used for campfire

currentDisplayedSupport = -1;//is used for the info screen 

hoveredNote = -1; //for debugging
debug = false; //?????

function displayEvent(){
	
	var findMapDisplayItem = function(){
		var list = [];
		for(var i = 0; i < instance_number(oMapDisplayItem);i ++){
			var instance = instance_find(oMapDisplayItem, i);
			list[i] = instance;
		}
		return list;
	}

	var objects = findMapDisplayItem();
	
	for(i = 0; i < array_length(objects); i ++){
		//resets all the objects so there is no leagcy for other menus
		objects[i].resetButton();	
		objects[i].savedObject = -1;
	}
	
	//maybe add a general buttion to hide the event and see the map again ???	
	//draw as 1st element (problem with object list)!!
	
	switch(currentMenu){
		case menus.inventory:
			#region inventory
			
			inventory = global.inventory;
			mapEventImage = Menu_Background_Inventory;
			
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
					with(objects[i + 1]){
						show_debug_message("the item will be: " + string(other.item));
						index = other.item != -1 ?  other.item.displaySpriteSubImage : 0;
						changeSprite(other.xCord,other.yCord,ItemSprite, false, index);
					}
				}else{
					with(objects[i]){
						//not sure about cal :) 
						useLockedOverlay(other.xCord,other.yCord,ItemSprite);
					}
				}
				
			}
			
		#endregion
	
		break;
		
		case menus.campfire:
			#region campfire
			//have to look at player ground --> set all of them around the campfire 
			//have to make one default seleced --> have to save in var 
			//have to make the others selecable 
			//have to make a menu to use there skills

			for(var i = 0; i < array_length(campfireDisplaySupport); i++){
				with(objects[i + 1]){
					//have to look at x and y cord 
					var xCord = 260 + 150 * i;
					var yCord = 260; 
					
					savedObject = other.campfireDisplaySupport[i];
					MainFunction = changeSelecedSupportMapOption;
				
					changeSprite(xCord, yCord, savedObject.icon, false, 0);
					if(i == 0){
						oMapCampfire.updateSelecedSupport(self);
					}
				}
				
			}
			#region non with Code (Debug / linux bubuggieness)
			/*
			if(!withWored){

				for(var i = 0; i < array_length(campfireDisplaySupport); i++){
					var object = objects[i + 1];

					//have to look at x and y cord 
					xCord = 260 + 150 * i;
					yCord = 260; 
					
					object.savedObject = campfireDisplaySupport[i];
					object.MainFunction = changeSelecedSupportMapOption;
					object.changeSprite(xCord, yCord, savedObject.icon, false, 0);
					if(i == 0){
						oMapCampfire.updateSelecedSupport(object);
					}

						
				}
			}	
			*/
			#endregion
			
			for(var k = 0; k < array_length(mapOptions); k ++){
				with(objects[k + 5]){
				
					xCord = 640;
					yCord = 360 + 10 + sprite_get_height(mapOptionSprite) * (array_length(other.mapOptions) - k); 
				
					savedObject = other.mapOptions[k];
					//should work as there is (if i think correctly) to chance the locked state while in event
					//have to look at not sure if somethin diffrent is need when closing ???
					MainFunction = triggerCampfireSkill;
					setConditionForLocking(savedObject.condition);
					changeSprite(xCord,yCord,mapOptionSprite, false);
					setDisplayedText(savedObject.textForDisplay, 
					xCord - sprite_get_xoffset(mapOptionSprite) + 20,
					yCord - sprite_get_yoffset(mapOptionSprite) + (sprite_get_height(mapOptionSprite) / 2) - 10);
					setUseHighlightHoverImage(mapOptionSprite, 1);
				}
			}
			
			#region non with Code (Debug / linux bubuggieness)
			/*
			if(!withWored){
				show_debug_message("the 2 with was not triggered ");
				for(var i = 0; i < array_length(mapOptions); i++){
					show_debug_message("the skills will be drawn");
					var object = objects[i + 5];
					xCord = 800;
					yCord = 360 + 10 + sprite_get_height(mapOptionSprite) * (array_length(mapOptions) - i); 
				
					object.savedObject = mapOptions[i];
					//should work as there is (if i think correctly) to chance the locked state while in event
					//have to look at not sure if somethin diffrent is need when closing ???
					object.MainFunction = triggerCampfireSkill;
					
					object.setConditionForLocking(savedObject.condition);
					
					object.changeSprite(xCord,yCord,mapOptionSprite, false);
					object.setUseHighlightHoverImage(mapOptionSprite, 1);
					object.setDisplayedText(savedObject.textForDisplay, 
					xCord - sprite_get_xoffset(mapOptionSprite) + 20,
					yCord - sprite_get_yoffset(mapOptionSprite) + (sprite_get_height(mapOptionSprite) / 2) - 10);
				}
			}	
			*/
			#endregion
			
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
			
			with(objects[i + 1]){
				xCord = 350 + 10 + sprite_get_height(mapOptionSprite) * (array_length(mapOptions) + 1);
				yCord = 360; 
				changeSprite(xCord, yCord,mapOptionSprite, false, 0);		
			}
			
			for(var k = 0; k < array_length(mapOptions); k ++){
				with(objects[k + 2]){
				
					xCord = 640;
					yCord = 360 + 10 + sprite_get_height(mapOptionSprite) * (array_length(other.mapOptions) - k); 
				
					savedObject = other.mapOptions[k];
					//should work as there is (if i think correctly) to chance the locked state while in event
					//have to look at not sure if somethin diffrent is need when closing ???
					MainFunction = triggerEvent;
					
					setConditionForLocking(savedObject.condition);
					changeSprite(xCord,yCord,mapOptionSprite, false);
					setUseHighlightHoverImage(mapOptionSprite, 1);
					setDisplayedText(savedObject.textForDisplay, 
					xCord - sprite_get_xoffset(mapOptionSprite) + 20,
					yCord - sprite_get_yoffset(mapOptionSprite) + (sprite_get_height(mapOptionSprite) / 2) - 10);
				}
				
				#region  non with Code (Debug / linux bubuggieness)
				/*
				if(withWorked == false){
					show_debug_message("_________________");
					show_debug_message("with didnt work")
					show_debug_message("_________________");
					objectNow = objects[k + 2]
					xCord = 640;
					yCord = 360 + 10 + sprite_get_height(mapOptionSprite) * (array_length(mapOptions) - k); 
					objectNow.savedObject = mapOptions[k];
					objectNow.MainFunction = triggerEvent;

					object.changeSprite(xCord,yCord,mapOptionSprite, false);
					objectNow.setUseHighlightHoverImage(mapOptionSprite, 1);
					objectNow.setDisplayedText(objectNow.savedObject.textForDisplay, 
					xCord - sprite_get_xoffset(mapOptionSprite) + 20,
					yCord - sprite_get_yoffset(mapOptionSprite) + (sprite_get_height(mapOptionSprite) / 2) - 10);
					setConditionForLocking(savedObject.condition);
				}
				*/
				#endregion
				
			}
			
			#endregion

		break;
	}
	
}



