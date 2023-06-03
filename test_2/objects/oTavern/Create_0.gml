event_inherited();

drawInGui = false;
drawInMap = true;
changeSprite(x,y,sprite_index);

supportSelection = [];


#region define all support choices 

var saleSupport = function(_class, _cost, _hoverText, _icon) constructor{
	class = _class;
	baseCost = _cost;
	lvl = 1;
	hoverText = _hoverText;
	icon = _icon;
	cost = 0;
	useLvLbasedOnBM = true;
	sold = false;
	
	//generates a random LvL based on BM
	// can be turned of with useLvLbasedOnBM = false
	function generateLvL(){
		if(useLvLbasedOnBM){
			randomize();
			var bmLvL = oGame.getPlayerInfo().lvl;
	
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
			return ((5 * baseCost) - baseCost) * exp((0.1 * baseCost) * lvl)
		}
		return baseCost;
	}
	cost = adjustCost();
	
	
}

var class = 0;
var cost = 0;
var hoverText = "something went wrong";
var icon = 0;

class = classList.conquistador;
cost = 500;
hoverText = "One of the local spanish. he is a good shot";
icon = Conquistador_Icon;
conquistador = new saleSupport(class, cost, hoverText, icon);

class = classList.footsoldiar;
cost = 150;
hoverText = "filler Soldier";
icon = Footsoldier_Icon;
footsoldiar = new saleSupport(class, cost, hoverText, icon);

class = classList.nobal;
cost = 300;
hoverText = "filler Nobal";
icon = Nobal_Icon;
nobal = new saleSupport(class, cost, hoverText, icon);

class = classList.eagleWarrior;
cost = 175;
hoverText = "filler Eagle";
icon = EagleWarrior_Icon;
eagleWarrior = new saleSupport(class, cost, hoverText, icon);

class = classList.jaguarWarrior;
cost = 175;
hoverText = "filler Jaguar";
icon = JaguarWarrior_Icon;
jaguarWarrior = new saleSupport(class, cost, hoverText, icon);

class = classList.missonarry;
cost = 350;
hoverText = "filler Missonarry";
icon = Missonarry_Icon;
missonarry = new saleSupport(class, cost, hoverText, icon);

class = classList.hunter;
cost = 325;
hoverText = "filler Hunter";
icon = Hunter_Icon;
hunter = new saleSupport(class, cost, hoverText, icon);

class = classList.witchhunter;
cost = 550;
hoverText = "filler Witchhunter";
icon = WitchHunter_Icon;
witchHunter = new saleSupport(class, cost, hoverText, icon);

class = classList.priest1;
cost = 600;
hoverText = "filler Priest 1";
icon = Priest_1_Icon;
priest1 = new saleSupport(class, cost, hoverText, icon);

class = classList.priest2;
cost = 325;
hoverText = "filler Priest 2";
icon = Priest_2_Icon;
priest2 = new saleSupport(class, cost, hoverText, icon);

#endregion

#region convertSaleSupportIntoPlayGroup

function convertSaleSupportIntoPlayGroup(_class, _lvl){
				var member = false;
				var position = oGame.findOpenSlotInPlayGroup();
				if(position == -1){
					show_debug_message("there are no open Slots for teammates");
					return 0;
				}
	
				switch(_class){
					case classList.footsoldiar:
						member = instance_create_depth(0,0,0,oFootsoldier);
					break;
					case classList.conquistador:
						member = instance_create_depth(0,0,0,oConquistador);
					break;
					case classList.nobal:
						member = instance_create_depth(0,0,0,oNobal);
					break;
					case classList.priest1:
						member = instance_create_depth(0,0,0,oPriest1);
					break;
					case classList.priest2:			
						member = instance_create_depth(0,0,0,oPriest2);			
					break;
					case classList.hunter:
						member = instance_create_depth(0,0,0,oHunter);
					break;
					case classList.missonarry:
						member = instance_create_depth(0,0,0,oMissonarry);
					break;
					case classList.jaguarWarrior:
						member = instance_create_depth(0,0,0,oJaguarWarrior);
					break;
					case classList.eagleWarrior:
						member = instance_create_depth(0,0,0,oEagleWarrior);
					break;
					case classList.witchhunter:
						member = instance_create_depth(0,0,0,oWitchHunter);
					break;
				}
	
				member.lvl = _lvl;
				//i = 1000 !!!!!!!!!!!
				//for lvling up the new member
				for(var i = 1000; i < member.lvl; i++){
					member.lvlUp(); // have to make 
				}
	
				global.playerGroup[position] = member;
			}


#endregion

MainFunction = function(){
	
	if(oTown.currentMenu == -1){
		if(array_length(supportSelection) == 0){
			//is used to fill the supportSelection
			// generates numberOfDisplayedSupports
			//uses the tier system 
			//LvL of the Supps is always based on PlayerLvL
			
 			 var generateSupportSelection = function(){
				var numberOfDisplayedSupports = 8;
				//1 is a high tier support 
				//3 3 tier
				//4 2/1 tier
				//rest filled with tier 1 
				//ON AVARAGE
				var number = round( random_range(1, 2));
				if(number == 1){
					supportSelection[0] = nobal;
				}else {
					supportSelection[0] = nobal; //witchHunter
				}

				//very unsure about this 
				var tier1 = [eagleWarrior, missonarry, footsoldiar, priest2];  
				var tier2 = [jaguarWarrior, hunter, priest1]; 
				var tier3 = [conquistador];
	
	
				for(var i = 1; i < 4; i ++){
					supportSelection[i] = generateFormTierList(
					[-1,20,50],
					undefined,
					tier3,
					tier2,
					tier1);
				}
	
				for(var j = 4; j < 8; j ++){
					supportSelection[j] = generateFormTierList(
					[-1,10,30],
					undefined,
					tier3,
					tier2,
					tier1,
					-1);
				}
		
				if(numberOfDisplayedSupports  > 8){
					for(var k = 8; k < numberOfDisplayedSupports; k ++){
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

			
			generateSupportSelection();
		}
		with(oTown){
			currentMenu = menus.tavern;
			displayMenuInTown();
		}
	
	}

}

