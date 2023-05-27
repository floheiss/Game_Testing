if(room_get_name(room) == "rBattleScreen"){
	
	draw_set_font(charDispalyFont);
	draw_text(x,y, "team: " + string(team));


	if(drawTarget or ds_list_find_index(mCombat.selectedTargets, id) != -1){
		draw_sprite(vTargeting,0,x,y);
	}

	if(selected)draw_sprite(vIndicator,0,x,y+ spriteHeight + hpBarHeight + 20);



	//draw hpBar
	_hp = currentHealth/maxHealth;
	draw_sprite(uiHPBar,0,x,y + spriteHeight + 16);
	draw_sprite_part(uiHPBar, 1, 0, 0, hpBarWidth * _hp, hpBarHeight, x, y + spriteHeight + 16);

	//draw BloodFlask 
	if(bloodMeter > 0){
		_bloodLvL = currentBloodLvL/maxBlood;
		if(_bloodLvL < 0 ){
			_bloodLvL = 0;
		}
		draw_sprite(uiBloodFlask, 0, x - 10, y + spriteHeight);
		draw_sprite_ext(uiBloodFlask,1,x - 10, y + spriteHeight, 1, _bloodLvL, 0, c_white, 1);
	}



	//draw buffsIcons
	if(findActivBuffs(id) > 0){
		drawDmg = false;
		drawDoge = false;
		drawTempo = false;
		drawHealth = false;
		drawBlood = false;
		yCord = y + spriteHeight + hpBarHeight + 16;
		if(selected){
			yCord = y + spriteHeight + hpBarHeight + 16 + 12;
		}
		for(var i = 0; i < findActivBuffs(id); i++){
			displayed = false;
			if(buffDmgRed != false && drawDmg == false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 0,x + 16*i, yCord);
				drawDmg = true;
				displayed = true;
			}
			if(buffDoge != false  && drawDoge == false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 0,x + 16*i, yCord);
				drawDoge= true;
				displayed = true;
			}
			if(buffTempo != false && drawTempo == false && displayed == false) {
				draw_sprite(TempoBuffDeBuff, 0,x + 16*i, yCord);
				drawTempo = true
				displayed = true;
			}
			if(buffHealth != false && drawHealth== false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 0,x + 16*i, yCord);
				drawHealth= true;
				displayed = true;
			}
			if(buffBlood != false && drawBlood == false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 0,x + 16*i, yCord);
				drawBlood = true;
				displayed = true;
			}
		}
	}

	//draw deBuffsIcons
	if(findActivDeBuffs(id) > 0){
		drawDmg = false;
		drawDoge = false;
		drawTempo = false;
		drawHealth = false;
		drawBlood = false;
		yCord = y + spriteHeight + hpBarHeight + 16;
		if(selected){
			yCord = y + spriteHeight + hpBarHeight + 16 + 12;
		}
		for(var i = findActivBuffs(id); i < findActivBuffs(id) + findActivBuffs(id); i++){
			displayed = false;
			if(deBuffDmgRed != false && drawDmg == false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 1,x + 16*i, yCord);
				drawDmg = true;
				displayed = true;
			}
			if(deBuffDoge != false  && drawDoge == false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 1,x + 16*i, yCord);
				drawDoge= true;
				displayed = true;
			}
			if(deBuffTempo != false && drawTempo == false && displayed == false) {
				draw_sprite(TempoBuffDeBuff, 1,x + 16*i, yCord);
				drawTempo = true
				displayed = true;
			}
			if(deBuffHealth != false && drawHealth== false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 1,x + 16*i, yCord);
				drawHealth= true;
				displayed = true;
			}
			if(deBuffBlood != false && drawBlood == false && displayed == false) {
				draw_sprite(ArmorBuffDebuff, 1,x + 16*i, yCord);
				drawBlood = true;
				displayed = true;
			}
		}
	}

	//hoverOver unit to see HP and Blood
	if(mCombat.targeting == false && position_meeting(mouse_x, mouse_y, id)){
		hpBarText = string(currentHealth) + "/" + string(maxHealth);
		widthHpBarText = string_width(hpBarText);
		draw_text(x + (spriteWidth/2) - (widthHpBarText/2), y  + spriteHeight + 19, hpBarText);
		if(bloodMeter > 0){
			bloodBarTextLine1 = string(currentBloodLvL);
			bloodBarTextLine2 = string(maxBlood);
		
			widthBloodBarTextLine1 = string_width(bloodBarTextLine1);
			widthBloodBarTextLine2 = string_width(bloodBarTextLine2);
			xOffset = (bloodFlaskWidth/2) + 17;
			yOffset = spriteHeight/2
			draw_text(x - xOffset , y + yOffset , bloodBarTextLine1);
			draw_text(x - xOffset, y + yOffset + 8, bloodBarTextLine2);
		}
	}

}
