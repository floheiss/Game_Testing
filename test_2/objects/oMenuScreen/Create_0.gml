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
		var list = [];
		
		for(var i = 0; i < instance_number(oDisplaySprite);i ++){
			var instance = instance_find(oDisplaySprite, i);
			list[i] =  instance;
		}
		
		return list;
	}

	objects = findDisplayObjects();
	
	for(var i = 0; i < array_length(objects); i ++){
		objects[i].resetButton();
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
				with(objects[0]){
					changeSprite(400,220,Sign_Go_Work);
					HoverFunction = noone;
				}
			}else{
				welcomeText = "Hi, need money again ?";
				with(objects[0]){
					changeSprite(200,200,Vera_Guild_girl, false, 0);
					HoverFunction = noone;
				}
				var xCord = 480; 
				for(var i = 0; i < 6; i++){
					with(objects[i + 1]){
						if(i < 3){
							xCord += 192 * i;
							savedObject = oGuild.contracts[i];
							changeSprite(xCord,180,Contract);
							setUseHighlightHoverImage(Contract, 1);
						}else{
							xCord += 192 * (i - 3)
							savedObject = oGuild.contracts[i];
							changeSprite(xCord, 200+64+50,Contract);
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
					with(objects[i]){
						savedObject = item;
						var index = savedObject != -1 ? item.displaySpriteSubImage : 0;
						changeSprite(xCord,yCord,ItemSprite, false, index);
					}
				}else{
					with(objects[i]){
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
			
			with(objects[0]){
				changeSprite(228,250,Vera_Guild_girl);
				HoverFunction = noone;
			}

			for(var i = 0; i < array_length(merchantInventory); i++){
				
				with(objects[i + 1]){
					savedObject = i;
					show_debug_message(savedObject)
					var item = merchantInventory[savedObject];
					
					var iForX = (i < (array_length(merchantInventory) / 2)) ? i  : (i - array_length(merchantInventory) / 2);
					var xCord = 480 + 95 * iForX;
					
					var addY = (i < (array_length(merchantInventory) / 2)) ? 0 : 110;
					var yCord = 200 + addY;
					
					var index = (item.sold == true) ? 0 : item.displaySpriteSubImage;
					changeSprite(xCord,yCord,ItemSprite, false, index);
					if(index == 0){
						setConditionForLocking(true);
					}
				}	
			}
		break;
		
		#endregion 
	
		#region tavern
		
		case menus.tavern:
			savedObject = false;
			bg = Menu_Background_Guild;
			welcomeText = "Need replacments ?";
			with(objects[0]){
				changeSprite(200,200,Vera_Guild_girl, false, 0);
				HoverFunction = noone;
			}
			var numberOfDisplayedSupports = array_length(oTavern.supportSelection);
			for(var i = 0; i < numberOfDisplayedSupports; i++){
				with(objects[i + 1]){
					if(i < (numberOfDisplayedSupports / 2)){
						var xCord = 480 + 142 * i;
						savedObject = oTavern.supportSelection[i];
						changeSprite(xCord,180,savedObject.icon, false, 0);
					}else{
						var xCord = 480 + 142 * (i - (numberOfDisplayedSupports / 2));
						savedObject = oTavern.supportSelection[i];
						changeSprite(xCord,210+64+50, savedObject.icon, false, 0);
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



