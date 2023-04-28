name = "";
battleEffect = 0;
battleSprite = 0;
battleDescriptionHover  = "";
battledDescriptionEffect = "";
roomToUse = [];

displaySpriteSubImage = -1; 
displayHoverDescribtion = "";
cost = 0;
positionInInventory = 0;

typeOfItem = itemList.bandage;
merchantText = "";

canBeUsed = false;

function createItem(_name, _type,_battleEffect,_battleSprite,_battleDescriptionHover, _battledDescriptionEffect, _positionInInventory /*, _roomToUse*/) constructor{
	name = _name;
	typeOfItem = _type;
	battleEffect = _battleEffect;
	battleSprite = _battleSprite;
	battleDescriptionHover  = _battleDescriptionHover;
	battledDescriptionEffect = _battledDescriptionEffect;
	positionInInventory = _positionInInventory
	roomToUse = [rDungeonMap]; // change later :) just for debug
	/*
	for(i = 0; i < array_last(_roomToUse); i++){
		roomToUse[i] = _roomToUse[i];
	}
	*/
	
	function effect(){
		if(canBeUsed){
			script_execute(battleEffect);
		}
	}
	
	function updateCanBeUsed(){
		for(i = 0; i < array_length(roomToUse); i++){
			if(room_get_name(room) == roomToUse[i]){
				canBeUsed = true;
			}else if(room_get_name(room) != roomToUse[i]){
				canBeUsed = false;
			}	
		}
	}

}

function createSaleItem(_name, _type, _merchantText,_displaySpriteSubImage, _cost) constructor{
	name = _name;
	typeOfItem = _type;
	merchantText = _merchantText;
	displaySpriteSubImage = _displaySpriteSubImage;
	cost = _cost;
	sold = false;
}


