name = "";
battleEffect = 0;
battleSprite = 0;
battleDescriptionHover  = "";
battledDescriptionEffect = "";

displaySpriteSubImage = -1; 
displayHoverDescribtion = "";
cost = 0;
positionInInventory = 0;

typeOfItem = itemList.bandage;
merchantText = "";

function createItem(_name, _type,_battleEffect,_battleSprite,_battleDescriptionHover, _battledDescriptionEffect, _positionInInventory) constructor{
	name = _name;
	typeOfItem = _type;
	battleEffect = _battleEffect;
	battleSprite = _battleSprite;
	battleDescriptionHover  = _battleDescriptionHover;
	battledDescriptionEffect = _battledDescriptionEffect;
	positionInInventory = _positionInInventory

	function effect(){
		script_execute(battleEffect);
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


