image_speed = 0;
bg = false;
bgSubimage = 0;
wasOpen = 0;

currentDisplayedContrat = false;
currentDisplayedItem = false;
currentDisplayedSupport = false;

memberSequence = -1;

welcomeText = "";


function displayMenu(){
	
	#region finds all objects in the MenuScree + reset
	var findDisplayObjects = function(){
		list = ds_list_create();
		for(var i = 0; i < instance_number(oDisplaySprite);i ++){
			instance = instance_find(oDisplaySprite, i);
			ds_list_add(list, instance);
		}
		return list;
	}

	objects = findDisplayObjects();
	

	
	for(i = 0; i < ds_list_size(objects); i ++){
		//resets all the objects so there is no leagcy for other menus
		objects[|i].resetButton();
		
		//maybe later look at to make 1 var ??????????
		objects[|i].contractDispalyed = false;
		objects[|i].itemDisplayed = false;
		objects[|i].supportDispalyed = false;
	}
	
	#endregion
		
	drawSelf = false;
	memberSequence = -1;
	
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
					changeSprite(200,200,Vera_Guild_girl, false, 0);
				}
			
				for(var i = 0; i < 6; i++){
					with(objects[|i + 1]){
						if(i < 3){
							var xCord = 480 + 192 * i;
							contractDispalyed = oGuild.contracts[i];
							changeSprite(xCord,180,Contract);
							setUseHighlightHoverImage(Contract, 1);
						}else{
							xCord = 480 + 192 * (i - 3)
							contractDispalyed = oGuild.contracts[i];
							changeSprite(xCord,200+64+50,Contract);
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
			
			for(var i = 0; i < 30; i ++){
				var xCord = 0; //note sure
				var yCord = 0;
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
					var item = global.inventory[i];
					with(objects[|i]){
						show_debug_message("the item will be: " + string(item));
						var index = item != -1 ? item.displaySpriteSubImage : 0;
						changeSprite(xCord,yCord,ItemSprite, false, index);
					}
				}else{
					with(objects[|i]){
						//not sure about cal :) 
						lockWithOutImage(xCord,yCord,ItemSprite);
					}
				}
				
			}
			
		break;
		#endregion
		
		#region merchant
		case menus.merchant:
			bg = Menu_Background_Guild;
			bgSubimage = 0;
			
			var inventory = global.inventory;
			var merchantInventory = oMerchant.merchantInventory;
			
			welcomeText = "Hi, need supplies?";
			with(objects[|0]){
				changeSprite(228,250,Vera_Guild_girl);
			}

			for(var i = 0; i < array_length(merchantInventory); i++){
				
				with(objects[|i + 1]){
					if(other.i < array_length(other.merchantInventory) /2){
						var xCord = 480 + 95 * i;
						itemDisplayed = merchantInventory[i];
						var position = i;
						if(itemDisplayed.sold == true){
							index = 1;
						}else{
							index = itemDisplayed.displaySpriteSubImage;
						}
						if(index == 1){
							lockWithOutImage(xCord,220,ItemSprite);
						}else{
							changeSprite(xCord,220,ItemSprite,false,index);
						}
					}else{
						var xCord = 480 + 95  * (i - array_length(merchantInventory) / 2)
						itemDisplayed = merchantInventory[i];
						var position = i;
						if(itemDisplayed.sold == true){
							index = 1;
						}else{
							index = itemDisplayed.displaySpriteSubImage;;
						}
						if(index == 1){
							lockWithOutImage(xCord,220+64+50,ItemSprite);
						}else{
							changeSprite(xCord,220+64+50,ItemSprite,false,index);
						}
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
				changeSprite(200,200,Vera_Guild_girl, false, 0);
			}
			for(var i = 0; i < oTavern.numberOfDisplayedSupports; i++){
				with(objects[|i + 1]){
					if(other.i < (oTavern.numberOfDisplayedSupports / 2)){
						var xCord = 480 + 142 * other.i;
						supportDispalyed = oTavern.supportSelection[i];
						changeSprite(xCord,180,supportDispalyed.icon, false, 0);
						
					}else{
						var xCord = 480 + 142 * (other.i - (oTavern.numberOfDisplayedSupports / 2));
						supportDispalyed = oTavern.supportSelection[i];
						changeSprite(xCord,210+64+50,supportDispalyed.icon, false, 0);
					}
					
				}
			}
			
		break;
		
		#endregion
		
		#region PartyInfoScreen
		
		case menus.partyInfo:
		
			bg = Menu_PartyInfo; //have to make
			var xCord = 200;
			var yCord = 400;
			memberSequence = currentDisplayedSupport.unitSequence;
			
		break;
				
		#endregion
	}
		
}



