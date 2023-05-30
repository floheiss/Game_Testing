#region general inventory managment
//search items | find last position | removing form position
//removing the the first of a given item

//finds a position for an Item 
function findOpenPositionInInventory(){
	var position = -1;
	
	for(var i = 0; i < global.maxInventorySize; i ++){
		if(global.inventory[i] == -1){
			position = i; 
			break;
		}
	}
	
	return position;
}

//looks into the inventory 
//if all slots are filled returns true ELSE false
function isInventoryFull(){
	var inventoryFull = true;
	
	for(var i = 0; i < global.maxInventorySize; i ++){
		if(global.inventory[i] == -1){
			inventoryFull = false;
			break;
		}
	}
	return inventoryFull;
}

//searches the inventory for the given Type and returns the position
//if it cant find one returns false
function findItemInInventory(_itemType){
	var position = false;
	
	for(var i = 0; i < array_length(global.inventory); i++){
		if(global.inventory[i] != -1){
			if(global.inventory[i].typeOfItem ==  _itemType){
				position = i;
				break;
			}
		}
	}
	return position
}

//removes an item for the inventory on a given position
//maybe look if uses for items (lockpick can be used 3 items, ...) are a thing ???
function removeItemFormInventory(_position){
	global.inventory[_position] = -1;
}

//removes the first time of a given type 
//does nothing if there is no such item
function removeFirstGivenItem(_itemType){
	var position = findItemInInventory(_itemType);
	if(position != false){
		removeItemFormInventory(position);
	}
}

#endregion

#region adding Items to Inventory at 

//adds an item of the given type to the end of the inventory 
//ONLY SHOWS TEXT IF IT CANT (IVENTORY FULL) might rework
function addItemToInventory(_item, _position = -1){
	if(!isInventoryFull()){
		var position = 0;
		if(_position != -1){
			if(global.inventory[_position] == -1){
				position = _position;
			}else{
				//rework need a return part 
				show_debug_message("the item slot is blocked, used the first open instead");
				position = findOpenPositionInInventory();
			}
		}else{
			position = findOpenPositionInInventory();
		}
		
		var name = "Bandage";
		var type = itemList.bandage;
		var battleEffect = bandageEffect;
		var battleSprite = Bandage;
		var battleDescriptionHover = "An old Bandage that will heal body and stops bleeding";
		var battleDescriptionEffect = "heals for 15% max health, and stops any bleeding";
		var displaySpriteSubImage = 2;
		var roomToUse = ["rBattleScreen","rDungeonMap"];
			
		
		switch(_item){
			case itemList.bandage:
				name = "Bandage";
				type = itemList.bandage;
				battleEffect = bandageEffect;
				battleSprite = Bandage;
				battleDescriptionHover = "An old Bandage that will heal body and stops bleeding";
				battleDescriptionEffect = "heals for 15% max health, and stops any bleeding";
				displaySpriteSubImage = 2;
				roomToUse = ["rBattleScreen","rDungeonMap"];
			break;
			case itemList.healingPotion:
				name = "Healing Potion";
				type = itemList.healingPotion;
				battleEffect = healingPotionEffect;
				battleSprite = HealingPotion;
				battleDescriptionHover = "Produced by toe local Methhead I hope it will heal";
				battleDescriptionEffect = "heals for 50% max health, and stops any bleeding";
				displaySpriteSubImage = 3;
				roomToUse = ["rBattleScreen","rDungeonMap"];
			break;
			
			case itemList.lockPickSet:
				name = "Healing Potion";
				type = itemList.healingPotion;
				battleEffect = lockPickSetEffect; //change
				battleSprite = LockPickSet; 
				battleDescriptionHover = "Produced by toe local Methhead I hope it will heal";
				battleDescriptionEffect = "heals for 50% max health, and stops any bleeding";
				displaySpriteSubImage = 2;
				roomToUse = ["rDungeonMap"];
			break;
			case itemList.rations:
				name = "Food Rations";
				type = itemList.rations;
				battleEffect = healingPotionBattleEffect; //change
				battleSprite = Rations;
				battleDescriptionHover = "Produced by toe local Methhead I hope it will heal";
				battleDescriptionEffect = "heals for 50% max health, and stops any bleeding";
				displaySpriteSubImage = 2;
				roomToUse = ["rDungeonMap"];
			break;
		}
		var item = new global.ItemGen.createItem(name,type,
		battleEffect,battleSprite,battleDescriptionHover,
		battleDescriptionEffect,position,displaySpriteSubImage);
		global.inventory[position] = item;
	}else{
		show_debug_message("-------------------");
		show_debug_message("the Inventory is Full no more can be added");
		show_debug_message("-------------------");
	}
}

#endregion

