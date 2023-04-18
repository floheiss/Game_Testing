if(oTown.currentMenu == -1 && oTown.allowInputs && position_meeting(mouse_x,mouse_y, id)){
	oTown.currentMenu = menus.guild;
	with(oTown){
		event_user(0);
		event_user(1);
		event_user(0);
	}
	if(global.contract != false or array_length(contracts) < 6){
		generateContracts();
	}
	oMenuScreen.displayMenu();
}