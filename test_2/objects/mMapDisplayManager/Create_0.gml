currentMenu = -1
menusUI = layer_get_id("menusUI");
mapEventImage = -1;

mapEventOptions = []; // have to reset after every event !!!!

function displayMenu(){
	objects = findDisplayObjects();

	
	for(i = 0; i < ds_list_size(objects); i ++){
		//resets all the objects so there is no leagcy for other menus
		objects[|i].spriteToDraw = -1;	
	}
	
	
	if(currentMenu == menus.inventory){
		#region inventory
			
		inventory = global.inventory;
		mapEventImage = Menu_Background_Inventory; //mapInventoryBG; have to make 
			
		for(i = 0; i < 30; i ++){
			xCord = 0;
			yCord = 0;
			#region calculate x/y
				
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
				with(objects[|i]){
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
	
	} else if(currentMenu == menus.campfire){
		
		#region campfire
		
		mapEventImage = Menu_Background_Campfire; //have to make
		
		//have to look at player ground --> set all of them around the campfire 
		//have to make one default seleced --> have to save in var 
		// have to make the others selecable 
		//have to make a menu to use there skills
		
		//one of the harded ones : ) 
		//will make at the end
		
		#endregion
	
	} else {
		//any other event is handel here 
		//the event will set mapEventOptions --> 
			//in them is save what text the options will display 
			//what happens when clicked (saves a function in scribt)
			//when are options locked (condion if they are false --> lock option)
			//(maybe add a hover that gives more info)
		//all of this will be set when the map icon is clicked 
		
	}
	
	//maybe add a general buttion to hide the event and see the map again ???	
		
		
		
	
	
}


function findMapDisplayItem(){
	list = ds_list_create();
	for(i = 0; i < instance_number(oMapDisplayItem);i ++){
		instance = instance_find(oMapDisplayItem, i);
		ds_list_add(list, instance);
	}
	return list;

}