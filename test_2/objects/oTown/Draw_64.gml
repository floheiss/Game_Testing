//not sure where this will be
draw_text(70, 50, "Gold: " + string(global.gold));

#region topbar managment

draw_sprite(TopBackBackground,0, 1280/2,0);

for(i = 0; i < 4; i++){
	xPos =  (640 - (64 + 4) * 2) + (64 + 4) * i;
	if(i < global.maxPlayGroupSize){
		if(global.playerGroup[i] != -1){
			unit = global.playerGroup[i];
			//not sure what doesnt work here have to debug
			draw_sprite_ext(unit.icon, 0, xPos,5,0.5,0.5,0,c_white,100);
		}else{
			
		}
	}else{
		draw_sprite_ext(LockedOverlay, 0, xPos,5,0.5,0.5,0,c_white,100);
	}
}

#endregion