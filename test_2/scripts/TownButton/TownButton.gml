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
		var numberInParty = 0;
		for(var i = 0; i < array_length(global.playerGroup); i ++){
			if(global.playerGroup[i] != -1){
				numberInParty ++;
			}
		}
		show_debug_message("member cost: " + string(self.supportDispalyed.cost));
		show_debug_message("--------------------");
		show_debug_message( "global gold: " + string(global.gold));
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
			with(oTown){
				currentMenu = -1;
				displayMenuInTown();
			}
		break;
		
		#endregion 
		
		#region tavern
		
		case menus.tavern:
			var member = oMenuScreen.currentDisplayedSupport;
			if(member != false){
				member.sold = true;
				global.gold -= member.cost;
				class = member.class;
				lvl = member.lvl;
				oTavern.convertSaleSupportIntoPlayGroup(class, lvl);
			}
			oMenuScreen.currentDisplayedSupport = false;
		break;
		
		#endregion
		
		#region merchant
		
		case menus.merchant:
			var toBuyItem = oMenuScreen.currentDisplayedItem;
			
			if(global.gold >= toBuyItem.cost && 
			!oMerchant.merchantInventory[self.position].sold &&
			!mInventory.isInventoryFull()){
				global.gold -= toBuyItem.cost;
				oMerchant.merchantInventory[self.position].sold = true;
				mInventory.addItemToInventory(toBuyItem.typeOfItem);
				self.image_index = 1;
				//have to change as now oGame handels allowInput !!!
				with(oGame){
					event_user(0);
					for(var i = 0; i < 100; i ++){
						//passes for some time to stop any wierd inputs 
					}
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