if(oTown.currentMenu == -1 && global.allowInput && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
	if(array_length(merchantInventory) == 0){
		generateInventory();
	}
	with(oTown){
		currentMenu = menus.merchant;
		displayMenuInTown();
	}
	
	
}