if(oTown.currentMenu == -1 && oTown.allowInputs && position_meeting(mouse_x,mouse_y, id)){
	oTown.currentMenu = menus.tavern;
	with(oTown){
		event_user(0);
		event_user(1);
		event_user(0);
	}
	
	if(array_length(supportSelection) == 0){
		generateSupportSelection();
	}
	
	oMenuScreen.displayMenu();
}