if(room_get_name(room) == "rBattleScreen"){
	draw_text(0,0,"combat Phase: " + string(combatPhase));
	draw_text(0,16,"selected Target: " + string(selectedUnit));
	draw_text(0,32,"Turn: " + string(turnCounter));
	draw_text(0,48,"targeting: " + string(targeting));
}
