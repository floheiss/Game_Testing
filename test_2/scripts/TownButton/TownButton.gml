function DisplayHover(){
	if(savedObject != -1){
		switch(oTown.currentMenu){
			#region guild
		
			case menus.guild:
				oMenuScreen.currentDisplayedContrat = savedObject;
			break;
		
			#endregion
		
			#region merchant
			case menus.merchant:
				var item = oMerchant.merchantInventory[savedObject];
				if(isInventoryFull()){
					oMenuScreen.welcomeText = "Your inventory is already full";
				}else if(global.gold <item.cost){
					oMenuScreen.welcomeText = "Sry i cant give credit";
				}else{
					oMenuScreen.currentDisplayedItem = item;
				}
			break;
			#endregion
	
			#region tavern
			case menus.tavern:
				var numberInParty = 0;
				for(var i = 0; i < array_length(global.playerGroup); i ++){
					if(global.playerGroup[i] != -1){
						numberInParty ++;
					}
				}
				show_debug_message("member cost: " + string(savedObject.cost));
				show_debug_message("--------------------");
				show_debug_message( "global gold: " + string(global.gold));
				if(global.maxPlayGroupSize <= numberInParty){
					oMenuScreen.welcomeText = "Sorry the people here dont trust you enough to come in higher numbers";
				} else if(global.gold < savedObject.cost){
					oMenuScreen.welcomeText = "Sry i cant give credit filler"; 
				} else{
					oMenuScreen.currentDisplayedSupport = savedObject;
				}
			break;
			#endregion
		
		}
	}
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
			member.sold = true;
			global.gold -= member.cost;
			class = member.class;
			lvl = member.lvl;
			oTavern.convertSaleSupportIntoPlayGroup(class, lvl);
			oMenuScreen.currentDisplayedSupport = false;
		break;
		#endregion
		
		#region merchant
		
		case menus.merchant:
			var itemToBuy = oMenuScreen.currentDisplayedItem;
			
			if(global.gold >= itemToBuy.cost && 
			!oMerchant.merchantInventory[savedObject].sold &&
			!isInventoryFull()){
				global.gold -= itemToBuy.cost;
				oMerchant.merchantInventory[savedObject].sold = true;
				
				addItemToInventory(itemToBuy.typeOfItem);
				self.locked = true;
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