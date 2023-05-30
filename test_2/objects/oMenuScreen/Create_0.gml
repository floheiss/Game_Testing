#region var Stuff

image_speed = 0;
bg = false;
bgSubimage = 0;
wasOpen = 0;

currentDisplayedContrat = false;
currentDisplayedItem = false;
currentDisplayedSupport = false;

memberSequence = -1;

welcomeText = "";

#endregion

function displayMenu(){
	
	#region finds all objects in the MenuScree + reset
	var findDisplayObjects = function(){
		var list = ds_list_create();
		
		for(var i = 0; i < instance_number(oDisplaySprite);i ++){
			var instance = instance_find(oDisplaySprite, i);
			ds_list_add(list, instance);
		}
		
		return list;
	}

	objects = findDisplayObjects();
		
	for(i = 0; i < ds_list_size(objects); i ++){
		
		with(objects[|i]){
			//resets all the objects so there is no leagcy for other menus
			resetButton();
		
			//maybe later look at to make 1 var ??????????
			contractDispalyed = false;
			itemDisplayed = false;
			supportDispalyed = false;
			
		}
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
		
			
			bg = Menu_Background_Inventory;
			welcomeText = "";
			addItemToInventory(itemList.bandage);
			addItemToInventory(itemList.healingPotion, 3);
			
					
			for(var i = 0; i < 30; i ++){
				
				#region calculate x/y
				
				var xCord = (x - sprite_get_xoffset(sprite_index));
				var yCord = (y - sprite_get_yoffset(sprite_index));
				var minus10Multi = floor(i / 10);
				var iCal = (i - (10 * minus10Multi));
				
				xCord += 25 + 3 * iCal + 85 * iCal;
				yCord += 35 + 25 * minus10Multi + 85 * minus10Multi;
				
				#endregion
					
				if(i < global.maxInventorySize){
					var item = global.inventory[i];
					with(objects[|i]){
						savedObject = item;
						var index = savedObject != -1 ? item.displaySpriteSubImage : 0;
						changeSprite(xCord,yCord,ItemSprite, false, index);
					}
				}else{
					with(objects[|i]){
						changeSprite(xCord,yCord,ItemSprite, false, 0);
						setConditionForLocking(true);
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
					if(i < array_length(merchantInventory) /2){
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
			var numberOfDisplayedSupports = array_length(oTavern.supportSelection);
			for(var i = 0; i < numberOfDisplayedSupports; i++){
				with(objects[|i + 1]){
					if(i < (numberOfDisplayedSupports / 2)){
						var xCord = 480 + 142 * i;
						supportDispalyed = oTavern.supportSelection[i];
						changeSprite(xCord,180,supportDispalyed.icon, false, 0);
						
					}else{
						var xCord = 480 + 142 * (i - (numberOfDisplayedSupports / 2));
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



