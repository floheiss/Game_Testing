supportSelection = [];
numberOfDisplayedSupports = 8;


#region define all support choices 

function createSaleSupport(_class, _cost, _hoverText, _icon) constructor{
	class = _class;
	baseCost = _cost;
	lvl = 1;
	hoverText = _hoverText;
	icon = _icon;
	cost = _cost
	useLvLbasedOnBM = true;
	sold = false;
	
	//generates a random LvL based on BM
	// can be turned of with useLvLbasedOnBM = false
	function generateLvL(){
		if(useLvLbasedOnBM){
			randomize();
			bmLvL = oGame.getPlayerInfo().lvl;
	
			if(1 < bmLvL <= 5){
				lvl = bmLvL + round(random_range(-1, 1));
			}else if(bmLvL <= 10){
				lvl = bmLvL + round(random_range(0, 2));
			}else if(bmLvL <= 20){
				lvl = bmLvL + round(random_range(1, 3));
			}
			if(lvl == 0){
				lvl = 1;
				show_debug_message("lvl was calculated wrong : )");
			}
		}else {
			lvl = 1;
		}
	}
	// generateLvL(); for late when worked on 
	
	//adhusts the cost of the support based on LvL
	//not sure about the formular (5x the basecost maxes at ca lvl 15)
	function adjustCost(){
		if(lvl != 1){
			cost = ((5 * baseCost) - baseCost) * exp((0.1 * baseCost) * lvl)
		}
	}
	// adjustCost(); for late when worked on 
}

class = 0;
cost = 0;
hoverText = "something went wrong";
icon = 0;

class = classList.fieldHand;
cost = 150;
hoverText = "filler field Hand";
icon = FieldHandIcon;
fieldHand = new createSaleSupport(class, cost, hoverText, icon);

class = classList.berserker;
cost = 300;
hoverText = "filler Berserker";
icon = BerserkerIcon;
berserker = new createSaleSupport(class, cost, hoverText, icon);

class = classList.peasent;
cost = 100;
hoverText = "filler Peasent";
icon = SamuraiIcon;
peasent = new createSaleSupport(class, cost, hoverText, icon);

class = classList.butcher;
cost = 200;
hoverText = "filler Butcher";
icon = ButcherIcon;
butcher = new createSaleSupport(class, cost, hoverText, icon);

class = classList.disownedNobal;
cost = 350;
hoverText = "filler Nobal";
icon = DisowedNobalIcon;
disownedNobal = new createSaleSupport(class, cost, hoverText, icon);

class = classList.witchhunter;
cost = 675;
hoverText = "filler Witchhunter";
icon = WitchHunterIcon;
witchHunter= new createSaleSupport(class, cost, hoverText, icon);

class = classList.huntsMan;
cost = 325;
hoverText = "filler HuntsMan";
icon = HuntsManIcon;
huntsMan= new createSaleSupport(class, cost, hoverText, icon);

class = classList.monch;
cost = 275;
hoverText = "filler Monch";
icon = MonchIcon;
monch = new createSaleSupport(class, cost, hoverText, icon);

class = classList.samurai;
cost = 600;
hoverText = "filler Samurai";
icon = SamuraiIcon;
samurai = new createSaleSupport(class, cost, hoverText, icon);

class = classList.gunSlinger;
cost = 325;
hoverText = "filler GunSlinger";
icon = GunSlingerIcon;
gunSlinger = new createSaleSupport(class, cost, hoverText, icon);

#endregion

//is used to fill the supportSelection
// generates numberOfDisplayedSupports
//uses the tier system 
//LvL of the Supps is always based on PlayerLvL
function generateSupportSelection(){
	//1 is a high tier support 
	//3 3 tier
	//4 2/1 tier
	//rest filled with tier 1 
	//ON AVARAGE
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
	
	for(j = 4; j < 8; j ++){
		supportSelection[j] = generateFormTierList(
		[-1,10,30],
		undefined,
		tier3,
		tier2,
		tier1,
		-1);
	}
		
	if(numberOfDisplayedSupports  > 8){
		for(k = 8; k < numberOfDisplayedSupports; k ++){
			supportSelection[k] = generateFormTierList(
			[-1,5,25],
			undefined,
			tier3,
			tier2,
			tier1,
			-1);
		}
	}
}

function convertSaleSupportIntoPlayGroup(_class, _lvl){
	support = false;
	position = oGame.findOpenSlotInPlayGroup();
	if(position == -1){
		show_debug_message("there are no open Slots for teammates");
		return 0;
	}
	
	switch(_class){
		case classList.berserker:
			support = instance_create_depth(0,0,0,oSamurai);
			support.class = classList.berserker; //remove later:) 
			
		break;
		case classList.butcher:
			support = instance_create_depth(0,0,0,oSamurai);
			support.class = classList.butcher;
			
		break;
		case classList.disownedNobal:
			support = instance_create_depth(0,0,0,oSamuraiCommander);
			support.class = classList.disownedNobal;
		break;
		case classList.fieldHand:
			support = instance_create_depth(0,0,0,oSamurai);
			support.class = classList.fieldHand;
			
		break;
		case classList.gunSlinger:			
			support = instance_create_depth(0,0,0,oSamuraiArcher);
			support.class = classList.gunSlinger;
			
		break;
		case classList.huntsMan:
			support = instance_create_depth(0,0,0,oSamuraiArcher);
			support.class = classList.huntsMan;
		break;
		case classList.monch:
			support = instance_create_depth(0,0,0,oSamuraiCommander);
			support.class = classList.monch;
		break;
		case classList.peasent:
			support = instance_create_depth(0,0,0,oSamurai);
			support.class = classList.peasent;
		break;
		case classList.samurai:
			support = instance_create_depth(0,0,0,oSamurai);
			support.class = classList.samurai;
		break;
		case classList.witchhunter:
			support = instance_create_depth(0,0,0,oSamuraiCommander);
			support.class = classList.witchhunter;
		break;
	}
	
	support.lvl = _lvl;
	//i = 1000 !!!!!!!!!!!
	for(i = 1000; i < support.lvl; i++){
		support.lvlUp(); // have to make 
	}
	
	global.playerGroup[position] = support;
}
