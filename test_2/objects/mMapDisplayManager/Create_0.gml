currentMenu = -1
menusUI = layer_get_id("menusUI");
bg = -1;

function displayMenu(){
	objects = findDisplayObjects();
	
	for(i = 0; i < ds_list_size(objects); i ++){
		//resets all the objects so there is no leagcy for other menus
		objects[|i].spriteToDraw = -1;	
	}
	
	switch(currentMenu){
		#region inventory
		
		case menus.inventory:
			inventory = global.inventory;
			bg = Menu_Background_Inventory; //mapInventoryBG; have to make 
			
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
			
		break;
		
		#endregion
		
		
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