inventorySlots = global.maxInventorySize;
inventoryLength = 10;
global.inventory = array_create(inventorySlots, -1);

#region general inventory managment
//search items | find last position |

//finds a position for an Item 
function findOpenPositionInInventory(){
	position = 0;
	
	for(i = 0; i < global.maxInventorySize; i ++){
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
	inventoryFull = true;
	
	for(i = 0; i < global.maxInventorySize; i ++){
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
	position = false;
	
	for(i = 0; i < array_length(global.inventory); i++){
		if(global.inventory[i].typeOfItem ==  _itemType){
			position = i;
			break;
		}
	}
	
	return position
}
#endregion

#region adding Items to Inventory at 

//adds an item of the given type to the end of the inventory 
//ONLY SHOWS TEXT IF IT CANT (IVENTORY FULL) might rework
function addItemToInventory(_item, _position = -1){
	if(!isInventoryFull()){
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
		
		switch(_item){
			case itemList.bandage:
				name = "Bandage";
				type = itemList.bandage;
				battleEffect = bandageEffect;
				battleSprite = Bandage;
				battleDescriptionHover = "An old Bandage that will heal body and stops bleeding";
				battleDescriptionEffect = "heals for 15% max health, and stops any bleeding";
			break;
			case itemList.healingPotion:
				name = "Healing Potion";
				type = itemList.healingPotion;
				battleEffect = healingPotionEffect;
				battleSprite = HealingPotion;
				battleDescriptionHover = "Produced by toe local Methhead I hope it will heal";
				battleDescriptionEffect = "heals for 50% max health, and stops any bleeding";
			break;
			
			case itemList.lockPickSet:
				name = "Healing Potion";
				type = itemList.healingPotion;
				battleEffect = lockPickSetEffect; //change
				battleSprite = LockPickSet; 
				battleDescriptionHover = "Produced by toe local Methhead I hope it will heal";
				battleDescriptionEffect = "heals for 50% max health, and stops any bleeding";
			break;
			case itemList.rations:
				name = "Food Rations";
				type = itemList.rations;
				battleEffect = healingPotionBattleEffect; //change
				battleSprite = Rations;
				battleDescriptionHover = "Produced by toe local Methhead I hope it will heal";
				battleDescriptionEffect = "heals for 50% max health, and stops any bleeding";
			break;
		}
		item = new global.ItemGen.createItem(name,type,
		battleEffect,battleSprite,battleDescriptionHover,
		battleDescriptionEffect,position);
		global.inventory[position] = item;
	}else{
		show_debug_message("-------------------");
		show_debug_message("the Inventory is Full no more can be added");
		show_debug_message("-------------------");
	}
}
#endregion

addItemToInventory(itemList.bandage);
addItemToInventory(itemList.healingPotion, 4);




