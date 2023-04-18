merchantInventory = [];
merchantInventorySold = [];
maxItems = 8;

function  generateInventory(){
	
	for(i = 0; i < maxItems; i ++){
		merchantInventory[i] = generateRandomSaleItem();
	}
	merchantInventory  = array_shuffle(merchantInventory);
}


//reworked in LINUX to use (NEW LINUX) generateFormTierList
//generates a random SaleItem 
function generateRandomSaleItem(_tierChances = [-1, 15, 35],
_tier3Items = -1, _tier2Items = -1,_tier1Items  = -1){
	tier3Items = [bloodFlask];
	tier2Items = [lockPickSet, posionOFX, shovel];
	tier1Items = [bandage, healPot , rations, fieldMedicalSupply, rations,antiPosion];
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
	
	item = generateFormTierList(
		_tierChances,
		undefined,
		tier3Items,
		tier2Items,
		tier1Items
	);
	
	return item;
}

#region define Items to sale

name = "";
type = 0;
merchantText = "";
displaySpriteSubImage = 0;
cost = 0;
	
name = "Bandage";
type = itemList.bandage;
merchantText = "Some old cloth and herbs I found  hope they help";
displaySpriteSubImage = 2;
cost = 25;
bandage = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);
	
name = "Healing Potion";
type = itemList.healingPotion;
merchantText = "the local methheads product I heard it is nice ";
displaySpriteSubImage = 3;
cost = 50;
healPot = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);
	
name = "Anti Posion";
type = itemList.antiPosion;
merchantText = "the local methheads product I heard it is nice dont ask why its green";
displaySpriteSubImage = 4; //have to work out
cost = 30;
antiPosion = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);
	
name = "Bloodflask";
type = itemList.bloodFlask;
merchantText = "I heard your kind uses these, cost me a preaty penny";
displaySpriteSubImage = 5; //have to work out
cost = 100;
bloodFlask = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);

name = "Shovel";
type = itemList.shovel;
merchantText = "Better leave the graverobbing to my men but you might need it ";
displaySpriteSubImage = 6; //have to work out
cost = 70;
shovel = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);

name = "Lockpick set";
type = itemList.lockPickSet;
merchantText = "Test them on anything, you wouldnt come thought my locks";
displaySpriteSubImage = 7; //have to work out
cost = 130;
lockPickSet = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);

name = "Posion of X";
type = itemList.positionOfX; //might rework later
merchantText = "product of the methhead I dont know what it does, I only know it cost me";
displaySpriteSubImage = 8; //have to work out
cost = round(random_range(95, 130));
posionOFX = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);

name = "Food";
type = itemList.rations; //might rework later (proviant --> based on cost )
merchantText = "product of the methhead I dont know what it does, I only know it cost me";
displaySpriteSubImage = 9; //have to work out
cost = round(random_range(25, 75));
rations = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);

name = "Field medical supplies";
type = itemList.fieldMedicalSupply; //might rework later (proviant --> based on cost )
merchantText = "will get you patched up, not sure how well";
displaySpriteSubImage = 10; //have to work out
cost = 120;
fieldMedicalSupply = new global.ItemGen.createSaleItem(name, type, merchantText, displaySpriteSubImage, cost);

#endregion


