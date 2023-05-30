if(room_get_name(room) == "rBattleScreen"){
	
	#region findActivBuffs / findActivDeBuffs 
	
	//findes activ buffs for given target 
	//used for displays mostly
	var findActivBuffs = function(_target){
		var activBuffs = 0;
		if(_target.buffDmgRed != false){
			activBuffs ++;
		}
		if(_target.buffDoge != false){
			activBuffs ++;
		}
		if(_target.buffTempo != false){
			activBuffs ++;
		}
		return activBuffs;
	}

	//findes activ deBuffs for given target 
	//used for displays mostly
	//MORE HAVE TO BE ADDED 
	var findActivDeBuffs = function(_target){
		var deactivBuffs = 0;
		if(_target.deBuffDmgRed!= false){
			deactivBuffs ++;
		}
		if(_target.deBuffDoge != false){
			deactivBuffs ++;
		}
		if(_target.deBuffTempo != false){
			deactivBuffs ++;
		}
		return deactivBuffs;
	}

	#endregion
	
	draw_set_font(charDispalyFont);
	draw_text(x,y, "team: " + string(team));
	
	var drawTargetMultiAttack = false; 
	for(var i = 0; i < array_length(mCombat.selectedTargets); i ++){
		if(mCombat.selectedTargets[i] == id){
			drawTargetMultiAttack = true;
			break;
		}
	}
	
	if(drawTarget or drawTargetMultiAttack){
		draw_sprite(vTargeting,0,x,y);
	}

	if(selected)draw_sprite(vIndicator,0,x,y+ spriteHeight + hpBarHeight + 20);



	//draw hpBar
	var hp = currentHealth/maxHealth;
	draw_sprite(uiHPBar,0,x,y + spriteHeight + 16);
	draw_sprite_part(uiHPBar, 1, 0, 0, hpBarWidth * hp, hpBarHeight, x, y + spriteHeight + 16);

	//draw BloodFlask 
	if(bloodMeter > 0){
		var bloodLvL = currentBloodLvL/maxBlood;
		if(bloodLvL < 0 ){
			_bloodLvL = 0;
		}
		draw_sprite(uiBloodFlask, 0, x - 10, y + spriteHeight);
		draw_sprite_ext(uiBloodFlask,1,x - 10, y + spriteHeight, 1, _bloodLvL, 0, c_white, 1);
	}


	#region draw buffsIcons / deBuffsIcons
	
	if(findActivBuffs(id) > 0){
		var drawDmg = false;
		var drawDoge = false;
		var drawTempo = false;
		var drawHealth = false;
		var drawBlood = false;
		var yCord = y + spriteHeight + hpBarHeight + 16;
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
			if(buffHealth != false && drawHealth == false && displayed == false) {
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
	if(mCombat.targeting == false && position_meeting(MOUSEGUI_X, MOUSEGUI_Y, id)){
		var hpBarText = string(currentHealth) + "/" + string(maxHealth);
		var widthHpBarText = string_width(hpBarText);
		draw_text(x + (spriteWidth/2) - (widthHpBarText/2), y  + spriteHeight + 19, hpBarText);
		if(bloodMeter > 0){
			var bloodBarTextLine1 = string(currentBloodLvL);
			var bloodBarTextLine2 = string(bloodMeter);
		
			var widthBloodBarTextLine1 = string_width(bloodBarTextLine1);
			var widthBloodBarTextLine2 = string_width(bloodBarTextLine2);
			var xOffset = (bloodFlaskWidth/2) + 17;
			var yOffset = spriteHeight/2
			draw_text(x - xOffset , y + yOffset , bloodBarTextLine1);
			draw_text(x - xOffset, y + yOffset + 8, bloodBarTextLine2);
		}
	}
	
	#endregion
}
