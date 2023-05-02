if(mMapDisplayManager.currentMenu == -1 && oGame.allowInput && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
	show_debug_message("the inventory was pressed");
	mMapDisplayManager.currentMenu = menus.inventory;
	with(mMapDisplayManager){
		event_user(0);
	}
	with(oGame){
		event_user(0);
		event_user(0);
	}
	
	mMapDisplayManager.displayMenu();
}