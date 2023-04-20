supportSelection = [];
numerOfDisplayedSupports = 8;


#region define all support choices 

function createSaleSupport(_class, _cost, _hoverText, _icon,_lvl = 1){
	class = _class;
	cost = _cost;
	lvl = _lvl;
	hoverText = _hoverText;
	icon = _icon
}

class = 0;
cost = 0;
hoverText = "something went wrong";
icon = 0;
lvl = 1; //have to look at later might be deleted (only buy lvl 1 )

class = classList.fieldHand;
cost = 150;
fieldHand = new createSaleSupport(class, cost, lvl);

class = classList.berserker;
cost = 300;
berserker = new createSaleSupport(class, cost, lvl);

class = classList.peasent;
cost = 100;
peasent = new createSaleSupport(class, cost, lvl);

class = classList.butcher;
cost = 200;
butcher = new createSaleSupport(class, cost, lvl);

class = classList.disownedNobal;
cost = 350;
disownedNobal = new createSaleSupport(class, cost, lvl);

class = classList.witchhunter;
cost = 675;
witchHunter= new createSaleSupport(class, cost, lvl);

class = classList.huntsMan;
cost = 325;
huntsMan= new createSaleSupport(class, cost, lvl);

class = classList.monch;
cost = 275;
monch = new createSaleSupport(class, cost, lvl);

class = classList.samurai;
cost = 600;
samurai = new createSaleSupport(class, cost, lvl);

class = classList.gunSlinger;
cost = 325;
gunSlinger = new createSaleSupport(class, cost, lvl);

#endregion

function generateSupportSelection(){
	//1 is a high tier support 
	//3 mid tier
	//4 low tier
	//ON AVARAGE
	show_debug_message("___________________________");
	show_debug_message(supportSelection);
	
	number = round( random_range(1, 2));
	if(number == 1){
		supportSelection[0] = witchHunter;
	}else{
		supportSelection[0] = samurai;
	}
	//very unsure about this 
	tier1 = [fieldHand, peasent, butcher, monch];  
	tier2 = [huntsMan, gunSlinger, berserker]; 
	tier3 = [disownedNobal];
	
	
	for(i = 1; i < 4; i ++){
		supportSelection[i] = generateFormTierList(
		[-1,20,50],
		undefined,
		tier3,
		tier2,
		tier1);
	}
	
	for(i = 4; i < 8; i ++){
		supportSelection[i] = generateFormTierList(
		[-1,10,30],
		undefined,
		tier3,
		tier2,
		tier1,
		-1);
	}
	show_debug_message("___________________________");
	show_debug_message(supportSelection);
}

generateSupportSelection();