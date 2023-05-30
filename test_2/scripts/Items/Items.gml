//returns a new SaleItem struct
//is given a itemType 
function getNewSaleItem(_type){
	var newSaleItem = -1;
	
	#region struct 
	
	var saleItem = function(_name, _type, _merchantText, _displaySpriteSubImage, _cost) constructor{
		name = _name;
		typeOfItem = _type;
		merchantText = _merchantText;
		displaySpriteSubImage = _displaySpriteSubImage;
		cost = _cost;
		sold = false;	
	}

	#endregion
	
	#region Defis
	
	var name = "";
	var type = 0;
	var merchantText = "";
	var displaySpriteSubImage = 0;
	var cost = 0;
	
	switch(_type){
		
		case itemList.bandage: 
			name = "Bandage";
			type = itemList.bandage;
			merchantText = "Some old cloth and herbs I found  hope they help";
			displaySpriteSubImage = 2;
			cost = 25;
		break;
		case itemList.healingPotion: 
			name = "Healing Potion";
			type = itemList.healingPotion;
			merchantText = "the local methheads product I heard it is nice ";
			displaySpriteSubImage = 3;
			cost = 50;
		break;
		case itemList.antiPosion: 
			name = "Anti Posion";
			type = itemList.antiPosion;
			merchantText = "the local methheads product I heard it is nice dont ask why its green";
			displaySpriteSubImage = 4; //have to work out
			cost = 30;
		break;
		case itemList.bloodFlask: 
			name = "Bloodflask";
			type = itemList.bloodFlask;
			merchantText = "I heard your kind uses these, cost me a preaty penny";
			displaySpriteSubImage = 5; //have to work out
			cost = 100;
		break;
		case itemList.shovel: 
			name = "Shovel";
			type = itemList.shovel;
			merchantText = "Better leave the graverobbing to my men but you might need it ";
			displaySpriteSubImage = 6; //have to work out
			cost = 70;
		break;
		case itemList.lockPickSet: 
			name = "Lockpick set";
			type = itemList.lockPickSet;
			merchantText = "Test them on anything, you wouldnt come thought my locks";
			displaySpriteSubImage = 7; //have to work out
			cost = 130;
		break;
		case itemList.positionOfX: 
			name = "Posion of X";
			type = itemList.positionOfX; //might rework later
			merchantText = "product of the methhead I dont know what it does, I only know it cost me";
			displaySpriteSubImage = 8; //have to work out
			cost = round(random_range(95, 130));
		break;
		case itemList.rations: 
			name = "Food";
			type = itemList.rations; //might rework later (proviant --> based on cost )
			merchantText = "product of the methhead I dont know what it does, I only know it cost me";
			displaySpriteSubImage = 9; //have to work out
			cost = round(random_range(25, 75));
		break;
		case itemList.fieldMedicalSupply: 
			name = "Field medical supplies";
			type = itemList.fieldMedicalSupply; //might rework later (proviant --> based on cost )
			merchantText = "will get you patched up, not sure how well";
			displaySpriteSubImage = 10; //have to work out
			cost = 120;
		break;
	}
	
	#endregion
	
	newSaleItem = new saleItem(name, type, merchantText, displaySpriteSubImage, cost);
	
	return newSaleItem;
}

//returns a new Item struct
//is given a itemType 
function getNewItem(_type, _positionInInventory){
	var newItem = -1;
		
	#region item Defis
		
		var name = "";
		var type = 0;
		var battleEffect = 0;
		var battleSprite = 0;
		var battleDescriptionHover = "";
		var battleDescriptionEffect = "";
		var displaySpriteSubImage = 0;
		var roomToUse = 0;
		
		switch(_type){
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
		
		var item = function(_name, _type,
		_battleEffect,_battleSprite, _battleDescriptionHover, _battleDescriptionEffect, 
		_positionInInventory,_displaySpriteSubImage /*, _roomToUse*/) constructor{
			
			name = _name;
			typeOfItem = _type;
			battleEffect = _battleEffect;
			battleSprite = _battleSprite;
			battleDescriptionHover  = _battleDescriptionHover;
			battledDescriptionEffect = _battleDescriptionEffect;
			positionInInventory = _positionInInventory
			displaySpriteSubImage = _displaySpriteSubImage;
			roomToUse = [rDungeonMap]; // change later :) just for debug
			canBeUsed = false;
			/*
			for(i = 0; i < array_last(_roomToUse); i++){
				roomToUse[i] = _roomToUse[i];
			}
			*/
	
			function effect(){
				if(canBeUsed){
					if(is_method(battleEffect)){
						battleEffect();
					}else{
						script_execute(battleEffect);
					}
				}
			}
	
			function updateCanBeUsed(){
				for(var i = 0; i < array_length(roomToUse); i++){
					if(room_get_name(room) == roomToUse[i]){
						canBeUsed = true;
					}else if(room_get_name(room) != roomToUse[i]){
						canBeUsed = false;
					}	
				}
			}
	
			updateCanBeUsed();
	
		}

		#endregion
	
	newItem = new item(name, type,
		battleEffect, battleSprite, battleDescriptionHover, battleDescriptionEffect, 
		_positionInInventory, displaySpriteSubImage /*, _roomToUse*/) 
	return newItem;
}

