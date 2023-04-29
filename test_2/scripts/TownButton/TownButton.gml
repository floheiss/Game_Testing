function CancelButtonTown(){
	oTown.currentMenu = -1;
	objects = oMenuScreen.findDisplayObjects();
	//not sure if here or in oMenuScreen
	for(i = 0; i < ds_list_size(objects); i ++){
		objects[|i].spriteToDraw = -1;
	}
	//have to change so oGame allowInputs is used 
	with(oTown){
		event_user(0);
		event_user(1);
		event_user(0);
	}
	
}

function DisplayHover(){
	
	#region guild
	
	if(self.contractDispalyed!= false){
		oMenuScreen.currentDisplayedContrat = self.contractDispalyed;
	}
	
	#endregion
	
	#region merchant
	
	if(self.itemDisplayed != false){
		if(mInventory.isInventoryFull()){
			oMenuScreen.welcomeText = "Your inventory is already full";
		}else if(global.gold < self.itemDisplayed.cost){
			oMenuScreen.welcomeText = "Sry i cant give credit";
		}else{
			oMenuScreen.currentDisplayedItem = self.itemDisplayed;
		}
	}
	
	#endregion
	
	#region Tavern
	
	if(self.supportDispalyed != false){
		numberInParty = 0;
		for(i = 0; i < array_length(global.playerGroup); i ++){
			if(global.playerGroup[i] != -1){
				numberInParty ++;
			}
		}
		show_debug_message("support cost: " + string(self.supportDispalyed.cost));
		show_debug_message("--------------------");
		show_debug_message( "all gold: " +string(global.gold));
		if(global.maxPlayGroupSize <= numberInParty){
			oMenuScreen.welcomeText = "Sorry the people here dont trust you enough to come in higher numbers";
		} else if(global.gold < self.supportDispalyed.cost){
			oMenuScreen.welcomeText = "Sry i cant give credit filler"; 
		} else{
			oMenuScreen.currentDisplayedSupport = self.supportDispalyed;
		}
		
	}
	
	#endregion
}

function DisplayMain(){
	
	switch(oTown.currentMenu){
		#region guild
		case menus.guild:
			global.contract = oMenuScreen.currentDisplayedContrat;
			oTown.currentMenu = -1;
			with(oTown){
				event_user(0);
				event_user(1);
				event_user(0);
			}
		break;
		#endregion 
		
		#region tavern
		case menus.tavern:
			support = oMenuScreen.currentDisplayedSupport;
			if(support != false){
				support.sold = true;
				global.gold -= support.cost;
				class = support.class;
				lvl = support.lvl;
				oTavern.convertSaleSupportIntoPlayGroup(class, lvl);
			}
			oMenuScreen.currentDisplayedSupport = false;
		break;
		
		#endregion
		
		#region merchant
		case menus.merchant:
			toBuyItem = oMenuScreen.currentDisplayedItem;
			
			if(global.gold >= toBuyItem.cost && 
			!oMerchant.merchantInventory[self.position].sold &&
			!mInventory.isInventoryFull()){
				global.gold -= toBuyItem.cost;
				oMerchant.merchantInventory[self.position].sold = true;
				mInventory.addItemToInventory(toBuyItem.typeOfItem);
				self.image_index = 1;
				//have to change as now oGame handels allowInput !!!
				with(oTown){
					event_user(0);
					event_user(0);
				}
				oMenuScreen.currentDisplayedItem = false;
			}

		break;
		#endregion
	}
	
}

function startContractButton(){

}