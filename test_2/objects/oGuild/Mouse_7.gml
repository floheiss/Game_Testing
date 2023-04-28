if(oTown.currentMenu == -1 && oTown.allowInputs && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
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