if(oTown.currentMenu == -1 && global.allowInput && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
	with(oTown){
		currentMenu = menus.inventory;
		displayMenuInTown();
	}
}


