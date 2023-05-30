event_inherited();

drawInGui = false;
drawInMap = true;

changeSprite(x,y,sprite_index);

merchantInventory = [];

MainFunction = function(){
	
	if(oTown.currentMenu == -1){
		if(array_length(merchantInventory) == 0){
						
			var generateInventory = function(){
				var maxItems = 8;
	
				var generateRandomSaleItem = function(_tierChances = [-1, 15, 35],
				_tier3Items = -1, _tier2Items = -1,_tier1Items  = -1){
					var salteItem = -1;
					
					var tier3Items = [itemList.healingPotion]; //[itemList.bloodFlask]
					var tier2Items = [itemList.healingPotion, itemList.healingPotion]; //[itemList.lockPickSet, itemList.posionOfX, itemList.shovel]
					var tier1Items = [itemList.bandage, itemList.bandage, itemList.bandage]; //[itemList.bandage, itemList.healPot , itemList.rations, itemList.fieldMedicalSupply, itemList.rations, itemList.antiPosion]
					
					#region changes the default arrays to para []
						
						if(_tier3Items  != -1 and is_array(_tier3Items)){
							tier3Items = _tier3Items;
						}
						if(_tier2Items  != -1 and is_array(_tier2Items)){
							tier2Items = _tier2Items;
						}
						if(_tier1Items  != -1 and is_array(_tier1Items)){
							tier1Items = _tier1Items;
						}
					
					#endregion
	
					var saleItemType = generateFormTierList(
						_tierChances,
						undefined,
						tier3Items,
						tier2Items,
						tier1Items
					);
	
					return salteItem = getNewSaleItem(saleItemType);
				}

				for(var i = 0; i < maxItems; i ++){
					merchantInventory[i] = generateRandomSaleItem();
				}
				merchantInventory  = array_shuffle(merchantInventory);
			}

			generateInventory();
		}
		with(oTown){
			currentMenu = menus.merchant;
			displayMenuInTown();
		}
	
	}
	
}

