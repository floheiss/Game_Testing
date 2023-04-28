if(oTown.currentMenu == -1 && oTown.allowInputs && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
	oTown.currentMenu = menus.inventory;
	with(oTown){
		event_user(0);
		event_user(1);
		event_user(0);
	}

	oMenuScreen.displayMenu();
}