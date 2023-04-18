function bandageEffect(){
	unit = selectedUnit;
	lvl = unit.lvl;
	unit.heal(round(unit.maxHealth * 0.03));
	unit.bleedDot = false;
}

function healingPotionEffect(){
	unit = selectedUnit;
	unit.heal(round(unit.maxHealth * 0.15));
}

function lockPickSetEffect(){
	if(room_get_name(room) == "rDungeonMap"){
	
	}
}