function bandageEffect(){
	unit = mCombat.selectedUnit;
	lvl = unit.lvl;
	unit.heal(round(unit.maxHealth * 0.03));
	unit.bleedDot = false;
}

function healingPotionEffect(){
	unit = mCombat.selectedUnit
	unit.heal(round(unit.maxHealth * 0.1));
}
