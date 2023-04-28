function CancelButtonTown(){
	oTown.currentMenu = -1;
	objects = oMenuScreen.findDisplayObjects();
	//not sure if here or in oMenuScreen
	for(i = 0; i < ds_list_size(objects); i ++){
		objects[|i].spriteToDraw = -1;
	}
	
	object_set_visible(oMenuScreen.cancelButton, false);
	
	with(oTown){
		event_user(0);
		event_user(1);
		event_user(0);
	}
	
}

function DisplayHover(){
	show_debug_message("Hover triggered");
	if(self.contractDispalyed!= false){
		oMenuScreen.currentDisplayedContrat = self.contractDispalyed;
	}
	
	if(self.itemDisplayed != false){
		if(mInventory.isInventoryFull()){
			oMenuScreen.welcomeText = "Your inventory is already full";
		}else if(global.gold < self.itemDisplayed.cost){
			oMenuScreen.welcomeText = "Sry i cant give credit";
		}else{
			oMenuScreen.currentDisplayedItem = self.itemDisplayed;
		}
	}
	
	if(self.supportDispalyed != false){
		if(global.maxPlayGroupSize >= array_length(global.playerGroup)){
			oMenuScreen.welcomeText = "Sorry the people hire dont trust you enough to come in higher numbers";
		} else if(global.gold < self.supportDispalyed.cost){
			oMenuScreen.welcomeText = "Sry i cant give credit filler"; 
		} else{
			oMenuScreen.currentDisplayedSupport = self.supportDispalyed;
		}
		
	}
	
	
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
				global.gold -= suppot.cost;
				class = support.class;
				lvl = support.lvl;
				oTavern.convertSaleSupportIntoPlayGroup(class, lvl);
			}
		break;
		
		#endregion
		
		#region merchant
		case menus.merchant:
			toBuyItem = self.itemDisplayed;
			
			if(global.gold >= toBuyItem.cost && 
			!self.toBuyItem.sold &&
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