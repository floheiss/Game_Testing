image_speed = 0;
bg = false;
bgSubimage = 0;
wasOpen = 0;

currentDisplayedContrat = false;
currentDisplayedItem = false;
currentDisplayedSupport = false;



welcomeText = "";


function displayMenu(){
	objects = findDisplayObjects();
	
	for(i = 0; i < ds_list_size(objects); i ++){
		//resets all the objects so there is no leagcy for other menus
		objects[|i].spriteToDraw = -1;
		objects[|i].contractDispalyed = false;
		objects[|i].itemDisplayed = false;
		objects[|i].supportDispalyed = false;
		objects[|i].useHighLightHover = false;
	}
	
	
	
	
	drawSelf = false;
	switch(oTown.currentMenu){
		#region guild 
		case menus.guild:
			currentDisplayedContrat = false;
			bg = Menu_Background_Guild;
			
			if(global.contract != false){
				//wip for removeing the display if contract is taken
				welcomeText = "";
				bgSubimage = 1;
				with(objects[|0]){
					changeSprite(400,220,Sign_Go_Work);
				}
			}else{
				welcomeText = "Hi, need money again ?";
				with(objects[|0]){
					changeSprite(228,250,Vera_Guild_girl, false, 0);
				}
			
				for(i = 0; i < 6; i++){
					with(objects[|i + 1]){
						if(other.i < 3){
							xCord = 480 + 192 * other.i;
							contractDispalyed = oGuild.contracts[other.i];
							changeSprite(xCord,220,Contract);
							setUseHighlightHoverImage(Contract, 1);
						}else{
							xCord = 480 + 192 * (other.i - 3)
							contractDispalyed = oGuild.contracts[other.i];
							changeSprite(xCord,220+64+50,Contract);
							setUseHighlightHoverImage(Contract, 1);
						}
					
					}
				}
			}
			
		break;
		#endregion 
		
		#region inventory
		case menus.inventory:
			inventory = global.inventory;
			
			bg = Menu_Background_Inventory;
			welcomeText = "";
			
			for(i = 0; i < 30; i ++){
				xCord = 0; //note sure
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
						changeSprite(other.xCord,other.yCord,ItemSprite, false,1);	
					}
				}
				
			}
			
		break;
		#endregion
		
		#region merchant
		case menus.merchant:
			bg = Menu_Background_Guild;
			bgSubimage = 0;
			
			inventory = global.inventory;
			merchantInventory = oMerchant.merchantInventory;
			
			welcomeText = "Hi, need supplies again?";
			with(objects[|0]){
				changeSprite(228,250,Vera_Guild_girl);
			}

			for(i = 0; i < array_length(merchantInventory); i++){
				
				with(objects[|i + 1]){
					if(other.i < array_length(other.merchantInventory) /2){
						xCord = 480 + 95 * other.i;
						itemDisplayed = other.merchantInventory[other.i];
						position = other.i;
						if(itemDisplayed.sold == true){
							index = 1;
						}else{
							index = itemDisplayed.displaySpriteSubImage;
						}
						changeSprite(xCord, 220, ItemSprite, false, index);
					}else{
						xCord = 480 + 95  * (other.i - array_length(other.merchantInventory) / 2)
						itemDisplayed = other.merchantInventory[other.i];
						position = other.i;
						if(itemDisplayed.sold == true){
							index = 1;
						}else{
							index = itemDisplayed.displaySpriteSubImage;;
						}
						changeSprite(xCord,220+64+50,ItemSprite,false,index);
					}
					
				}
			}
		break;
		#endregion 
	
		#region tavern
		
		case menus.tavern:
			currentDisplayedSupport = false;
			bg = Menu_Background_Guild;
			welcomeText = "Need replacments ?";
			with(objects[|0]){
				changeSprite(228,250,Vera_Guild_girl, false, 0);
			}
			for(i = 0; i < oTavern.numberOfDisplayedSupports; i++){
				with(objects[|i + 1]){
					if(other.i < (oTavern.numberOfDisplayedSupports / 2)){
						xCord = 480 + 142 * other.i;
						supportDispalyed = oTavern.supportSelection[other.i];
						changeSprite(xCord,220,supportDispalyed.icon, false, 0);
						
					}else{
						xCord = 480 + 142 * (other.i - (oTavern.numberOfDisplayedSupports / 2));
						supportDispalyed = oTavern.supportSelection[other.i];
						changeSprite(xCord,220+64+50,supportDispalyed.icon, false, 0);
					}
					
				}
			}
			
		break;
		
		#endregion
			
	}
	
	
}


function findDisplayObjects(){
	list = ds_list_create();
	for(var i = 0; i < instance_number(oDisplaySprite);i ++){
		instance = instance_find(oDisplaySprite, i);
		ds_list_add(list, instance);
	}
	return list;
}