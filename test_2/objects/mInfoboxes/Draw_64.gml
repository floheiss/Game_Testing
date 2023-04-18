//displayes an Infobox of char if hover over 
//disabeled at mo
if(position_meeting(mouse_x, mouse_y, pUnit) && mCombat.targeting == false && false == true) {
	var unit = instance_position(mouse_x,mouse_y, pUnit);
	xCord = x - 300 + 20;
	yCord =  y + 14;
	
	draw_sprite(MouseOverInfo,0 ,x ,y);
	draw_text(xCord , yCord ,"Health: " + string(unit.currentHealth) +  " / " + string(unit.maxHealth));
	
	draw_text(xCord , yCord+ 16,"Doge: " + string(unit.currentdoge));
	draw_text(xCord , yCord+ 16 * 2,"Tempo: " + string(unit.currentTempo));
	draw_text(xCord , yCord + 16 * 3,"My Team" + string(unit.team) + " position: " + string(unit.position));
	
	
	draw_text(xCord , yCord + 16 * 4,"Melee damage reduction: " + string(unit.dmgRedMelee + unit.dmgBonusRedMelee));
	draw_text(xCord , yCord + 16 * 5,"Ranged damage reduction: " + string(unit.dmgRedRange + unit.dmgBonusRedRange));
	draw_text(xCord , yCord + 16 * 6,"Magic damage reduction: " + string(unit.dmgRedMagic + unit.dmgBonusRedMagic));
	
	if(findActivBuffs(unit) > 0){
		drawDmg = false;
		drawDoge = false;
		drawTempo = false;
		drawHealth = false;
		drawBlood = false;
		yCord = y + 14 + 16 * 7;
		for(var i = 0; i < findActivBuffs(unit); i++){
			displayed = false;
			if(unit.buffDmgRed != false && drawDmg == false && displayed == false) {
				draw_text(xCord, yCord + 16 *i, "damage reduction Buff");
				draw_text(xCord ,yCord + 16 *(i + 1),"Lastes for " + string(unit.buffDmgRed.duration) + " turns");
				draw_text(xCord ,yCord + 16 *(i + 2),"it buffs for " + string(unit.buffDmgRed.amount));
	
			}
			if(unit.buffDoge != false  && drawDoge == false && displayed == false) {
				draw_text(xCord, yCord + 16 *i, "Doge Buff");
				draw_text(xCord ,yCord + 16 *(i + 1),"Lastes for " + string(unit.buffDoge.duration) + " turns");
				draw_text(xCord ,yCord + 16 *(i + 2),"it buffs for " + string(unit.buffDmgRed.amount));
			}
			if(unit.buffTempo != false && drawTempo == false && displayed == false) {
				draw_text(xCord, yCord + 16 *i, "Tempo Buff");
				draw_text(xCord ,yCord + 16 *(i + 1),"Lastes for " + string(unit.buffTempo.duration) + " turns");
				draw_text(xCord ,yCord + 16 *(i + 2),"it buffs for " + string(unit.buffTempo.amount));
			}
			if(unit.buffHealth != false && drawHealth== false && displayed == false) {
				draw_text(xCord, yCord + 16 *i, "Health Buff");
				draw_text(xCord ,yCord + 16 *(i + 1),"Lastes for " + string(unit.buffHealth.duration) + " turns");
				draw_text(xCord ,yCord + 16 *(i + 2),"it buffs for " + string(unit.buffHealth.amount));
			}
			if(unit.buffBlood != false && drawBlood == false && displayed == false) {
				draw_text(xCord, yCord + 16 *i, "Blood Buff");
				draw_text(xCord ,yCord + 16 *(i + 1),"Lastes for " + string(unit.buffBlood.duration) + " turns");
				draw_text(xCord ,yCord + 16 *(i + 2),"it buffs for " + string(unit.buffBlood.amount));
			}
		}
	}

}