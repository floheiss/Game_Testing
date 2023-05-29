if(oTown.currentMenu == -1 && global.allowInput  && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
	if(array_length(supportSelection) == 0){
		generateSupportSelection();
	}
	with(oTown){
		currentMenu = menus.tavern;
		displayMenuInTown();
	}
	
}