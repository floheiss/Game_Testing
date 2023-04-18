image_speed = 0;
bg = false;
bgSubimage = 0;
wasOpen = 0;

currentDisplayedContrat = false;
currentDisplayedItem = false;

welcomeText = "";


function displayMenu(){
	objects = findDisplayObjects();
	
	for(i = 0; i < ds_list_size(objects); i ++){
		objects[|i].spriteToDraw = -1;
		objects[|i].btnState = buttonState.disabled;
	}
	
	
	
	drawSelf = false;
	switch(oTown.currentMenu){
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
			}else {
				welcomeText = "Hi, need money again ?";
				with(objects[|0]){
					changeSprite(228,250,Vera_Guild_girl);
					btnState = buttonState.active;
				}
			
				for(i = 0; i < 6; i++){
					with(objects[|i + 1]){
						if(other.i < 3){
							xCord = 480 + 192 * other.i;
							changeSprite(xCord,220,Contract);
							contract = oGuild.contracts[other.i];
							btnState = buttonState.active;
						}else{
							xCord = 480 + 192 * (other.i - 3)
							changeSprite(xCord,220+64+50,Contract);
							contract = oGuild.contracts[other.i];
							btnState = buttonState.active;
						}
					
					}
				}
			}
			
		break;
		
		case menus.inventory:
			inventory = global.inventory;
			
			bg = Menu_Background_Inventory;
			welcomeText = "";
			
			for(i = 0; i < 30; i ++){
				xCord = 0; //note sure
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
				
				if(i < global.maxInventorySize){
					item = global.inventory[i];
					with(objects[|i]){
						
						/*
						if(array_length(global.inventory) < other.i){
							image_index = global.inventory[other.i].displaySpriteSubImage;
						
						}else{
							image_index = 0;
						}
						*/
						subImageBtnIndicUse = false;
						//image = string(global.inventory[other.i].displaySpriteSubImage);
						image_index = global.inventory[other.i] != -1 ?  global.inventory[other.i].displaySpriteSubImage : 0;
						changeSprite(other.xCord,other.yCord,ItemSprite);
						
					}
				}else{
					with(objects[|i]){
						subImageBtnIndicUse = false;
						image_index = 1; //Displaies a Lock for all the Slots not yet unlocked
						changeSprite(other.xCord,other.yCord,ItemSprite);
						
					}
				}
				
			}
			
		break;
		
		case menus.mercant:
			bg = Menu_Background_Guild;
			bgSubimage = 0;
			
			inventory = global.inventory;
			merchantInventory = oMerchant.merchantInventory;
			
			welcomeText = "Hi, need supplies again?";
			with(objects[|0]){
				changeSprite(228,250,Vera_Guild_girl);
				btnState = buttonState.active;
			}
			for(i = 0; i < array_length(merchantInventory); i++){
				with(objects[|i + 1]){
					if(other.i < array_length(other.merchantInventory) /2){
						xCord = 480 + 95 * other.i;
						changeSprite(xCord,220,ItemSprite);
						itemDisplayed = other.merchantInventory[other.i];
						position = other.i;
						btnState = buttonState.active;
						subImageBtnIndicUse = false;
						if(itemDisplayed.sold == true){
							image_index = 1;
						}else{
							image_index = itemDisplayed.displaySpriteSubImage;;
						}
					}else{
						xCord = 480 + 95  * (other.i - array_length(other.merchantInventory) /2)
						changeSprite(xCord,220+64+50,ItemSprite);
						itemDisplayed = other.merchantInventory[other.i];
						position = other.i;
						
						btnState = buttonState.active;
						subImageBtnIndicUse = false;
						if(itemDisplayed.sold == true){
							image_index = 1;
						}else{
							image_index = itemDisplayed.displaySpriteSubImage;;
						}
					}
					
				}
			}
		break;
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